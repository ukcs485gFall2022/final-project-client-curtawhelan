//
//  OCKHealthKitPassthroughStore.swift
//  OCKSample
//
//  Created by Corey Baker on 1/5/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import Foundation
import CareKitStore
import HealthKit
import os.log

extension OCKHealthKitPassthroughStore {

    func addTasksIfNotPresent(_ tasks: [OCKHealthKitTask]) async throws {
        let tasksToAdd = tasks
        let taskIdsToAdd = tasksToAdd.compactMap { $0.id }

        // Prepare query to see if tasks are already added
        var query = OCKTaskQuery(for: Date())
        query.ids = taskIdsToAdd

        let foundTasks = try await fetchTasks(query: query)
        var tasksNotInStore = [OCKHealthKitTask]()

        // Check results to see if there's a missing task
        tasksToAdd.forEach { potentialTask in
            if foundTasks.first(where: { $0.id == potentialTask.id }) == nil {
                tasksNotInStore.append(potentialTask)
            }
        }

        // Only add if there's a new task
        if tasksNotInStore.count > 0 {
            do {
                _ = try await addTasks(tasksNotInStore)
                Logger.ockHealthKitPassthroughStore.info("Added tasks into HealthKitPassthroughStore!")
            } catch {
                Logger.ockHealthKitPassthroughStore.error("Error adding HealthKitTasks: \(error.localizedDescription)")
            }
        }
    }

    /*
        xTODO: You need to tie an OCPatient and CarePlan to these tasks,
    */

    func populateSampleData(_ patientUUID: UUID? = nil) async throws {

        // let carePlanUUID = try await OCKStore.getCarePlanUUIDs().first

        let stepSchedule = OCKSchedule.dailyAtTime(
            hour: 8, minutes: 0, start: Date(), end: nil, text: nil,
            duration: .hours(12), targetValues: [OCKOutcomeValue(2000.0, units: "Steps")])

        let waterSchedule = OCKSchedule.dailyAtTime(
            hour: 8, minutes: 0, start: Date(), end: nil, text: nil,
            duration: .allDay, targetValues: [OCKOutcomeValue(3.0, units: "Liters")])

        let vitaminDSchedule = OCKSchedule.dailyAtTime(
            hour: 8, minutes: 0, start: Date(), end: nil, text: nil,
            duration: .allDay, targetValues: [OCKOutcomeValue(600.0, units: "International Unit")])

        var steps = OCKHealthKitTask(
            id: TaskID.steps,
            title: "Steps",
            carePlanUUID: nil,
            schedule: stepSchedule,
            healthKitLinkage: OCKHealthKitLinkage(
                quantityIdentifier: .stepCount,
                quantityType: .cumulative,
                unit: .count()))
        steps.asset = "figure.walk"
        steps.card = .numericProgress

        var drinkingWater = OCKHealthKitTask(
            id: TaskID.drinkingWater,
            title: "Water Intake (L)",
            carePlanUUID: nil,
            schedule: waterSchedule,
            healthKitLinkage: OCKHealthKitLinkage(
                quantityIdentifier: .dietaryWater,
                quantityType: .cumulative,
                unit: .liter()))
        drinkingWater.asset = "drop.circle.fill"
        drinkingWater.card = .numericProgress
        drinkingWater.instructions = "Tip: Drink water throughout the day, not all at once"

        var vitaminD = OCKHealthKitTask(
            id: TaskID.vitaminD,
            title: "Vitamin D Intake (IU)",
            carePlanUUID: nil,
            schedule: vitaminDSchedule,
            healthKitLinkage: OCKHealthKitLinkage(
                quantityIdentifier: .dietaryVitaminD,
                quantityType: .cumulative,
                unit: .internationalUnit()))
        vitaminD.asset = "sun.max.fill"
        vitaminD.card = .numericProgress

        try await addTasksIfNotPresent([vitaminD, drinkingWater])
    }
}
