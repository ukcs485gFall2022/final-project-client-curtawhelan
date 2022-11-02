//
//  TaskViewModel.swift
//  OCKSample
//
//  Created by Curt Whelan on 10/27/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import Foundation
import CareKitStore

class TaskViewModel: ObservableObject {
    @Published var instructions = ""
    @Published var task = OCKTask(id: "",
                                  title: nil,
                                  carePlanUUID: nil,
                                  schedule: .dailyAtTime(hour: 0,
                                                         minutes: 0,
                                                         start: Date(),
                                                         end: nil,
                                                         text: nil))

    @Published var error: AppError?

    // MARK: Intents
    func addTask() async throws {
        guard let appDelegate = AppDelegateKey.defaultValue else {
            error = AppError.couldntBeUnwrapped
            return
        }

        var updatedTask = task
        if instructions != updatedTask.instructions {
            updatedTask.instructions = instructions
        }

        do {
            try await appDelegate.store?.addTasksIfNotPresent([updatedTask])
        } catch {
            self.error = AppError.errorString("Couldn't add task: \(error.localizedDescription)")
        }
    }
}
