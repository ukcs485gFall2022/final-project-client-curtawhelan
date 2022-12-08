//
//  Profile.swift
//  OCKSample
//
//  Created by Corey Baker on 11/25/20.
//  Copyright © 2020 Network Reconnaissance Lab. All rights reserved.
//

import Foundation
import CareKit
import CareKitStore
import SwiftUI
import ParseCareKit
import os.log
import Combine
import ParseSwift

class ProfileViewModel: ObservableObject {
    // MARK: Public read, private write properties
    // Publishers for Patient
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var birthday = Date()
    @Published var sex: OCKBiologicalSex = .other("other")
    var sexOtherField = "other"
    @Published var note = ""
    @Published var allergy = ""

    // Publishers for Contact
    @Published var street = ""
    @Published var city = ""
    @Published var state = ""
    @Published var zipCode = ""

    var emailLabel = "Email 1" // publish if want to update in the view
    @Published var emailValue = ""

    var messagingLabel = "Messaging Number 1"
    @Published var messagingValue = ""

    var phoneNumbersLabel = "Phone Number 1"
    @Published var phoneNumbersValue = ""

    var otherContactInfoLabel = "Other Contact Info 1"
    @Published var otherContactInfoValue = ""

    @Published var isShowingSaveAlert = false
    @Published var isPresentingAddTask = false
    @Published var isPresentingContact = false
    @Published var isPresentingImagePicker = false
    @Published var profileUIImage = UIImage(systemName: "person.fill") {
        willSet {
            guard self.profileUIImage != newValue,
                let inputImage = newValue else {
                return
            }

            if !isSettingProfilePictureForFirstTime {
                Task {
                    guard var currentUser = User.current,
                          let image = inputImage.jpegData(compressionQuality: 0.25) else {
                        Logger.profile.error("User is not logged in or there was an error compressing image")
                        return
                    }

                    let newProfilePicture = ParseFile(name: "profile.jpg", data: image)
                    currentUser = currentUser.set(\.profilePicture, to: newProfilePicture)
                    do {
                        _ = try await currentUser.save()
                        Logger.profile.info("Saved and updated profile picture!")
                    } catch {
                        Logger.profile.error("Error saving profile picture: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    @Published private(set) var error: Error?
    private(set) var storeManager: OCKSynchronizedStoreManager
    private(set) var alertMessage = "All changs saved successfully!"

    // MARK: Private read/write properties
    private var patient: OCKPatient? {
        willSet {
            if let currentFirstName = newValue?.name.givenName {
                firstName = currentFirstName
            } else {
                firstName = ""
            }
            if let currentLastName = newValue?.name.familyName {
                lastName = currentLastName
            } else {
                lastName = ""
            }
            if let currentBirthday = newValue?.birthday {
                birthday = currentBirthday
            } else {
                birthday = Date()
            }
            if let currentSex = newValue?.sex {
                sex = currentSex
            } else {
                sex = OCKBiologicalSex.other(sexOtherField)
            }
            if let currentAllergy = newValue?.allergies?.first {
                allergy = currentAllergy
            } else {
                allergy = ""
            }
        }
    }

    private var contact: OCKContact? {
        willSet {
            if let currentEmail = newValue?.emailAddresses?.first {
                emailLabel = currentEmail.label
                emailValue = currentEmail.value
            } else {
                emailLabel = ""
                emailValue = ""
            }
            if let address = newValue?.address {
                street = address.street
                city = address.city
                state = address.state
                zipCode = address.postalCode
            } else {
                street = ""
                city = ""
                state = ""
                zipCode = ""
            }
            if let currentMessagingNumber = newValue?.messagingNumbers?.first {
                messagingLabel = currentMessagingNumber.label
                messagingValue = currentMessagingNumber.value
            } else {
                messagingLabel = ""
                messagingValue = ""
            }
            if let currentPhoneNumber = newValue?.phoneNumbers?.first {
                phoneNumbersLabel = currentPhoneNumber.label
                phoneNumbersValue = currentPhoneNumber.value
            } else {
                phoneNumbersLabel = ""
                phoneNumbersValue = ""
            }
            if let currentOtherContactInfo = newValue?.otherContactInfo?.first {
                otherContactInfoLabel = currentOtherContactInfo.label
                otherContactInfoValue = currentOtherContactInfo.value
            } else {
                otherContactInfoLabel = ""
                otherContactInfoValue = ""
            }
        }
    }
    private var isSettingProfilePictureForFirstTime = true
    private var cancellables: Set<AnyCancellable> = []

    init(storeManager: OCKSynchronizedStoreManager? = nil) {
        self.storeManager = storeManager ?? StoreManagerKey.defaultValue
        reloadViewModel()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadViewModel(_:)),
                                               name: Notification.Name(rawValue: Constants.shouldRefreshView),
                                               object: nil)
    }

    // MARK: Helpers (private)
    private func clearSubscriptions() {
        cancellables = []
    }

    @objc private func reloadViewModel(_ notification: Notification? = nil) {
        Task {
            _ = await findAndObserveCurrentProfile()
        }
    }

    @MainActor
    private func findAndObserveCurrentProfile() async {
        guard let uuid = try? Utility.getRemoteClockUUID() else {
            Logger.profile.error("Could not get remote uuid for this user.")
            return
        }
        clearSubscriptions()

        do {
            try await fetchProfilePicture()
        } catch {
            Logger.profile.error("Could not fetch profile image: \(error)")
        }

        // Build query to search for OCKPatient
        // swiftlint:disable:next line_length
        var queryForCurrentPatient = OCKPatientQuery(for: Date()) // This makes the query for the current version of Patient
        queryForCurrentPatient.ids = [uuid.uuidString] // Search for the current logged in user

        do {
            guard let appDelegate = AppDelegateKey.defaultValue,
                  let foundPatient = try await appDelegate.store?.fetchPatients(query: queryForCurrentPatient),
                  let currentPatient = foundPatient.first else {
                // swiftlint:disable:next line_length
                Logger.profile.error("Could not find patient with id \"\(uuid)\". It's possible they have never been saved.")
                return
            }
            self.observePatient(currentPatient)

            var queryForCurrentContact = OCKContactQuery(for: Date())
            queryForCurrentContact.ids = [uuid.uuidString]
            guard let foundContact = try await appDelegate.store?.fetchContacts(query: queryForCurrentContact),
                let currentContact = foundContact.first else {
                // swiftlint:disable:next line_length
                Logger.profile.error("Error: Could not find contact with id \"\(uuid)\". It's possible they have never been saved.")
                return
            }
            self.observeContact(currentContact)

        } catch {
            // swiftlint:disable:next line_length
            Logger.profile.error("Could not find patient with id \"\(uuid)\". It's possible they have never been saved. Query error: \(error.localizedDescription)")
        }
    }

    @MainActor
    private func observePatient(_ patient: OCKPatient) {
        storeManager.publisher(forPatient: patient,
                               categories: [.add, .update, .delete])
            .sink { [weak self] in
                self?.patient = $0 as? OCKPatient
            }
            .store(in: &cancellables)
    }

    @MainActor
    private func findAndObserveCurrentContact() async {
        guard let uuid = try? Utility.getRemoteClockUUID() else {
            Logger.profile.error("Could not get remote uuid for this user.")
            return
        }
        clearSubscriptions()

        // Build query to search for OCKPatient
        // swiftlint:disable:next line_length
        var queryForCurrentPatient = OCKPatientQuery(for: Date()) // This makes the query for the current version of Patient
        queryForCurrentPatient.ids = [uuid.uuidString] // Search for the current logged in user

        do {
            guard let appDelegate = AppDelegateKey.defaultValue,
                  let foundPatient = try await appDelegate.store?.fetchPatients(query: queryForCurrentPatient),
                let currentPatient = foundPatient.first else {
                // swiftlint:disable:next line_length
                Logger.profile.error("Could not find patient with id \"\(uuid)\". It's possible they have never been saved.")
                return
            }
            self.observePatient(currentPatient)

            // Query the contact also so the user can edit
            var queryForCurrentContact = OCKContactQuery(for: Date())
            queryForCurrentContact.ids = [uuid.uuidString]
            guard let foundContact = try await appDelegate.store?.fetchContacts(query: queryForCurrentContact),
                let currentContact = foundContact.first else {
                // swiftlint:disable:next line_length
                Logger.profile.error("Error: Could not find contact with id \"\(uuid)\". It's possible they have never been saved.")
                return
            }
            self.observeContact(currentContact)

            try? await fetchProfilePicture()
        } catch {
            // swiftlint:disable:next line_length
            Logger.profile.error("Could not find patient with id \"\(uuid)\". It's possible they have never been saved. Query error: \(error.localizedDescription)")
        }
    }

    @MainActor
    private func observeContact(_ contact: OCKContact) {

        storeManager.publisher(forContact: contact,
                               categories: [.add, .update, .delete])
            .sink { [weak self] in
                self?.contact = $0 as? OCKContact
            }
            .store(in: &cancellables)
    }

    @MainActor
    private func fetchProfilePicture() async throws {

        // Profile pics are stored in Parse User.
        guard let currentUser = try await User.current?.fetch() else {
            Logger.profile.error("User is not logged in")
            return
        }

        if let pictureFile = currentUser.profilePicture {

            // Download picture from server if needed
            do {
                let profilePicture = try await pictureFile.fetch()
                guard let path = profilePicture.localURL?.relativePath else {
                    Logger.profile.error("Could not find relative path for profile picture.")
                    return
                }
                self.profileUIImage = UIImage(contentsOfFile: path)
            } catch {
                Logger.profile.error("Could not fetch profile picture: \(error.localizedDescription).")
            }
        }
        self.isSettingProfilePictureForFirstTime = false
    }
}

// MARK: User intentional behavior
extension ProfileViewModel {

    @MainActor
    func saveProfile() async {
        alertMessage = "All changes saved successfully!"
        do {
            try await savePatient()
            try await saveContact()
        } catch {
            alertMessage = "Could not save profile: \(error)"
        }
        isShowingSaveAlert = true
    }

    @MainActor
    // swiftlint:disable:next cyclomatic_complexity
    func savePatient() async throws {

        if var patientToUpdate = patient {
            var patientHasBeenUpdated = false

            if patient?.name.givenName != firstName {
                patientHasBeenUpdated = true
                patientToUpdate.name.givenName = firstName
            }

            if patient?.name.familyName != lastName {
                patientHasBeenUpdated = true
                patientToUpdate.name.familyName = lastName
            }

            if patient?.birthday != birthday {
                patientHasBeenUpdated = true
                patientToUpdate.birthday = birthday
            }

            if patient?.sex != sex {
                patientHasBeenUpdated = true
                patientToUpdate.sex = sex
            }

            let notes = [OCKNote(author: firstName,
                                 title: "New Note",
                                 content: note)]

            if patient?.notes != notes {
                patientHasBeenUpdated = true
                patientToUpdate.notes = notes
            }

            if patient?.allergies?.first != allergy {
                patientHasBeenUpdated = true
                patientToUpdate.allergies = [allergy]
            }

            if patientHasBeenUpdated {
                let updated = try await storeManager.store.updateAnyPatient(patientToUpdate)
                Logger.profile.info("Successfully updated patient!")
                guard let updatedPatient = updated as? OCKPatient else {
                    Logger.profile.error("Could not cast to OCKPatient")
                    return
                }
                self.patient = updatedPatient
            }
        } else {
            guard let remoteUUID = try? Utility.getRemoteClockUUID().uuidString else {
                Logger.profile.error("The user currently is not logged in")
                return
            }

            var newPatient = OCKPatient(id: remoteUUID,
                                        givenName: firstName,
                                        familyName: lastName)
            newPatient.birthday = birthday

            let addedPatient = try await storeManager.store.addAnyPatient(newPatient)
            Logger.profile.info("Succesffully saved new patient")
            guard let addedOCKPatient = addedPatient as? OCKPatient else {
                Logger.profile.error("Could not cast to OCKPatient")
                return
            }
            self.patient = addedOCKPatient
            self.observePatient(addedOCKPatient)
        }
    }

    @MainActor
    // swiftlint:disable:next cyclomatic_complexity
    func saveContact() async throws {

        if var contactToUpdate = contact {
            // If a current contact was fetched, check to see if any of the fields have changed

            var contactHasBeenUpdated = false

            // Since OCKPatient was updated earlier, we should compare against this name
            if let patientName = patient?.name,
                contact?.name != patient?.name {
                contactHasBeenUpdated = true
                contactToUpdate.name = patientName
            }

            // Create a mutable temp address to compare
            let potentialAddress = OCKPostalAddress()
            potentialAddress.street = street
            potentialAddress.city = city
            potentialAddress.state = state
            potentialAddress.postalCode = zipCode

            if contact?.address != potentialAddress {
                contactHasBeenUpdated = true
                contactToUpdate.address = potentialAddress
            }

            let potentialEmail = OCKLabeledValue(label: emailLabel, value: emailValue)
            if var emailAddresses = contact?.emailAddresses {
                if emailAddresses.first != potentialEmail {
                    contactHasBeenUpdated = true
                    emailAddresses[0] = potentialEmail
                    contactToUpdate.emailAddresses = emailAddresses
                }
            } else {
                contactHasBeenUpdated = true
                contactToUpdate.emailAddresses = [potentialEmail]
            }

            let potentialMessagingNumber = OCKLabeledValue(label: messagingLabel, value: messagingValue)
            if var messagingNumbers = contact?.messagingNumbers {
                if messagingNumbers.first != potentialMessagingNumber {
                    contactHasBeenUpdated = true
                    messagingNumbers[0] = potentialMessagingNumber
                    contactToUpdate.messagingNumbers = messagingNumbers
                }
            } else {
                contactHasBeenUpdated = true
                contactToUpdate.messagingNumbers = [potentialMessagingNumber]
            }

            let potentialPhoneNumber = OCKLabeledValue(label: phoneNumbersLabel, value: phoneNumbersValue)
            if var phoneNumbers = contact?.phoneNumbers {
                if phoneNumbers.first != potentialPhoneNumber {
                    contactHasBeenUpdated = true
                    phoneNumbers[0] = potentialPhoneNumber
                    contactToUpdate.phoneNumbers = phoneNumbers
                }
            } else {
                contactHasBeenUpdated = true
                contactToUpdate.phoneNumbers = [potentialPhoneNumber]
            }

            let potentialOtherContactInfo = OCKLabeledValue(label: otherContactInfoLabel, value: otherContactInfoValue)
            if var otherContactInfo = contact?.otherContactInfo {
                if otherContactInfo.first != potentialOtherContactInfo {
                    contactHasBeenUpdated = true
                    otherContactInfo[0] = potentialOtherContactInfo
                    contactToUpdate.otherContactInfo = otherContactInfo
                }
            } else {
                contactHasBeenUpdated = true
                contactToUpdate.otherContactInfo = [potentialOtherContactInfo]
            }

            if contactHasBeenUpdated {
                let updated = try await storeManager.store.updateAnyContact(contactToUpdate)
                Logger.profile.info("Successfully updated contact")
                guard let updatedContact = updated as? OCKContact else {
                    Logger.profile.error("Could not cast to OCKContact")
                    return
                }
                self.contact = updatedContact
            }

        } else {

            guard let remoteUUID = try? Utility.getRemoteClockUUID().uuidString else {
                Logger.profile.error("The user currently is not logged in")
                return
            }

            guard let patientName = self.patient?.name else {
                Logger.profile.info("The patient did not have a name.")
                return
            }

            // Added code to create a contact for the respective signed up user
            let newContact = OCKContact(id: remoteUUID,
                                        name: patientName,
                                        carePlanUUID: nil)

            guard let addedContact = try await storeManager.store.addAnyContact(newContact) as? OCKContact else {
                Logger.profile.error("Could not cast to OCKContact")
                return
            }

            self.contact = addedContact
            self.observeContact(addedContact)
        }
    }
}
