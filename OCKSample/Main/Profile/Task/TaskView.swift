//
//  TaskView.swift
//  OCKSample
//
//  Created by Curt Whelan on 10/27/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import SwiftUI
import HealthKit
import ParseSwift

struct TaskView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = TaskViewModel()
    @State var repeating = true
    @State var taskPickerSegmentValue = 0
    @State var healthKitTaskPickerSegmentValue = 0

    var body: some View {
        NavigationView {
            Form {
                general
            }
            .navigationTitle("Add Custom Task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        Task {
                            if taskPickerSegmentValue == 0 {
                                await viewModel.addTask()
                            } else {
                                await viewModel.addHealthKitTask()
                            }
                            dismissHandler()
                        }
                    }
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) {
                        dismissHandler()
                    }
                }
            }
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}

private extension TaskView {
    var general: some View {
        Section {
            Picker("Type of Task", selection: $taskPickerSegmentValue) {
                Text("Normal Task").tag(0)
                Text("HealthKit Task").tag(1)
            }
            .pickerStyle(.segmented)

            switch taskPickerSegmentValue {
            case 0: // care kit task
                TextField("Title", text: $viewModel.title)
                TextField("Instructions", text: $viewModel.instructions)
                TextField("Motivation (Optional)", text: $viewModel.motivation)
                Picker("Card Style", selection: $viewModel.selectedCareKitCard) {
                    ForEach(CareKitCard.allCases) { item in
                        Text(item.rawValue)
                    }
                }
                Toggle("Select Specific Day", isOn: $repeating)
            case 1: // health kit task
                TextField("Title", text: $viewModel.title)
                TextField("Instructions", text: $viewModel.instructions)
                TextField("Motivation (Optional)", text: $viewModel.motivation)
                Picker("HealthKit Task", selection: $viewModel.selectedHealthKitTask) {
                    Text("Exercise Time").tag(HKQuantityTypeIdentifier.appleExerciseTime)
                    Text("Stand Time").tag(HKQuantityTypeIdentifier.appleStandTime)
                    Text("Step Count").tag(HKQuantityTypeIdentifier.stepCount)
                    Text("Protein Consumed").tag(HKQuantityTypeIdentifier.dietaryProtein)
                    Text("Caffeine Consumed").tag(HKQuantityTypeIdentifier.dietaryCaffeine)
                }
                Picker("Card Style", selection: $viewModel.selectedHealthKitCard) {
                    Text("Numeric Progess").tag(CareKitCard.numericProgress)
                    Text("Labled Value").tag(CareKitCard.labeledValue)
                }
            default:
                TextField("Error", text: $viewModel.title)
            }

            Picker("Schedule", selection: $viewModel.selectedDay) {
                ForEach(WeekDays.allCases) { day in
                    Text(day.rawValue.capitalized)
                }
            }
            .disabled(repeating == false)

        } header: {
            Text("General")
        }
        .headerProminence(.increased)
    }
}

private extension TaskView {
    func dismissHandler() {
        if #available(iOS 15, *) {
            dismiss()
        } else {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
