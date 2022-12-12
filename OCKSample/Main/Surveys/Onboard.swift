//
//  Onboard.swift
//  OCKSample
//
//  Created by Corey Baker on 11/11/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import Foundation
import CareKitStore
#if canImport(ResearchKit)
import ResearchKit
#endif

struct Onboard: Surveyable {
    static var surveyType: Survey {
        Survey.onboard
    }
}

#if canImport(ResearchKit)
extension Onboard {
    /*
     xTODO: Modify the onboarding so it properly represents the
     usecase of your application. Changes should be made to
     each of the steps in this type method. For example, you
     should change: title, detailText, image, and imageContentMode,
     and learnMoreItem.
     */
    func createSurvey() -> ORKTask {
        // The Welcome Instruction step.
        let welcomeInstructionStep = ORKInstructionStep(
            identifier: "\(identifier()).welcome"
        )

        welcomeInstructionStep.title = "Welcome!"
        welcomeInstructionStep.detailText =
        """
        Thank you for downloading Trek Track! \n
        Tap Next to get started on your Trek to better mental health.
        """
        welcomeInstructionStep.image = UIImage(systemName: "heart.fill")
        welcomeInstructionStep.imageContentMode = .scaleAspectFill

        // The Informed Consent Instruction step.
        let studyOverviewInstructionStep = ORKInstructionStep(
            identifier: "\(identifier()).overview"
        )

        studyOverviewInstructionStep.title = "A Few Things First..."
        studyOverviewInstructionStep.iconImage = UIImage(systemName: "hand.app.fill")

        let heartBodyItem = ORKBodyItem(
            text: "We will ask you to share some of your health data",
            detailText: "Data will be used to track your stats",
            image: UIImage(systemName: "brain.head.profile"),
            learnMoreItem: nil,
            bodyItemStyle: .image
        )

        let completeTasksBodyItem = ORKBodyItem(
            text: "We only use this data in ways that will help you reach your goals",
            detailText: "It will never be sold to advertisers",
            image: UIImage(systemName: "figure.mind.and.body"),
            learnMoreItem: nil,
            bodyItemStyle: .image
        )

        let signatureBodyItem = ORKBodyItem(
            text: "We will require a signature to confirm your consent",
            detailText: "No apple pen required",
            image: UIImage(systemName: "square.and.pencil.circle.fill"),
            learnMoreItem: nil,
            bodyItemStyle: .image
        )

        let secureDataBodyItem = ORKBodyItem(
            text: "Your data is kept private and secure",
            detailText: "Always always always",
            image: UIImage(systemName: "lock.iphone"),
            learnMoreItem: nil,
            bodyItemStyle: .image
        )

        studyOverviewInstructionStep.bodyItems = [
            heartBodyItem,
            completeTasksBodyItem,
            signatureBodyItem,
            secureDataBodyItem
        ]

        // The Signature step (using WebView).
        let webViewStep = ORKWebViewStep(
            identifier: "\(identifier()).signatureCapture",
            html: informedConsentHTML
        )

        webViewStep.showSignatureAfterContent = true

        // The Request Permissions step.
        // xTODO: Set these to HealthKit info you want to display
        // by default.
        let healthKitTypesToWrite: Set<HKSampleType> = [
            .quantityType(forIdentifier: .dietaryWater)!,
            .quantityType(forIdentifier: .dietaryVitaminD)!
        ]

        let healthKitTypesToRead: Set<HKObjectType> = [
            .characteristicType(forIdentifier: .dateOfBirth)!,
            .quantityType(forIdentifier: .stepCount)!
        ]

        let healthKitPermissionType = ORKHealthKitPermissionType(
            sampleTypesToWrite: healthKitTypesToWrite,
            objectTypesToRead: healthKitTypesToRead
        )

        let notificationsPermissionType = ORKNotificationPermissionType(
            authorizationOptions: [.alert, .badge, .sound]
        )

        let motionPermissionType = ORKMotionActivityPermissionType()

        let requestPermissionsStep = ORKRequestPermissionsStep(
            identifier: "\(identifier()).requestPermissionsStep",
            permissionTypes: [
                healthKitPermissionType,
                notificationsPermissionType,
                motionPermissionType
            ]
        )

        requestPermissionsStep.title = "Health Data Request"
        // swiftlint:disable:next line_length
        requestPermissionsStep.text = "Please review the health data types below and enable sharing to enhance your experience."

        // Completion Step
        let completionStep = ORKCompletionStep(
            identifier: "\(identifier()).completionStep"
        )

        completionStep.title = "Onboarding Complete"

        completionStep.text = "Thank you for completing the onboarding survey. \nYour Trek has only just begun!"

        let surveyTask = ORKOrderedTask(
            identifier: identifier(),
            steps: [
                welcomeInstructionStep,
                studyOverviewInstructionStep,
                webViewStep,
                requestPermissionsStep,
                completionStep
            ]
        )
        return surveyTask
    }

    func extractAnswers(_ result: ORKTaskResult) -> [CareKitStore.OCKOutcomeValue]? {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            Utility.requestHealthKitPermissions()
        }
        return [OCKOutcomeValue(Date())]
    }
}
#endif
