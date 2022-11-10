//
//  OCKSynchronizedStoreManager.swift
//  OCKSample
//
//  Created by Corey Baker on 11/7/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import Foundation
import CareKit
import CareKitStore
import CareKitUI
import os.log

extension OCKSynchronizedStoreManager {
    func addTasksIfNotPresent(_ tasks: [OCKAnyTask]) async throws {
        let taskIdsToAdd = tasks.compactMap { $0.id }

        // Prepare query to see if tasks are already added
        var query = OCKTaskQuery(for: Date())
        query.ids = taskIdsToAdd

        let foundTasks = try await store.fetchAnyTasks(query: query)
        var tasksNotInStore = [OCKAnyTask]()

        // Check results to see if there's a missing task
        tasks.forEach { potentialTask in
            if foundTasks.first(where: { $0.id == potentialTask.id }) == nil {
                tasksNotInStore.append(potentialTask)
            }
        }

        // Only add if there's a new task
        if tasksNotInStore.count > 0 {
            do {
                _ = try await store.addAnyTasks(tasksNotInStore)
                Logger.ockStore.info("Added tasks into OCKSynchronizedStoreManager!")
            } catch {
                Logger.ockStore.error("Error adding tasks: \(error.localizedDescription)")
            }
        }
    }

    func addContactsIfNotPresent(_ contacts: [OCKAnyContact]) async throws {
        let contactIdsToAdd = contacts.compactMap { $0.id }

        // Prepare query to see if contacts are already added
        var query = OCKContactQuery(for: Date())
        query.ids = contactIdsToAdd

        let foundContacts = try await store.fetchAnyContacts(query: query)
        var contactsNotInStore = [OCKAnyContact]()

        // Check results to see if there's a missing task
        contacts.forEach { potential in
            if foundContacts.first(where: { $0.id == potential.id }) == nil {
                contactsNotInStore.append(potential)
            }
        }

        // Only add if there's a new task
        if contactsNotInStore.count > 0 {
            do {
                _ = try await store.addAnyContacts(contactsNotInStore)
                Logger.ockSynchronizedStoreManager.info("Added contacts into OCKSynchronizedStoreManager!")
            } catch {
                Logger.ockSynchronizedStoreManager.error("Error adding contacts: \(error.localizedDescription)")
            }
        }
    }
}
