//
//  TaskView.swift
//  OCKSample
//
//  Created by Curt Whelan on 10/27/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import SwiftUI

struct TaskView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode

    @StateObject var viewModel = TaskViewModel()
    @State var repeating = true

    var body: some View {
        NavigationView {
            Form {
                general
            }
            .navigationTitle("Add Task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        Task {
                            await viewModel.addTask()
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

            Picker("Type of Task", selection: $viewModel.selectedTypeOfTask) {
                ForEach(TypeOfTask.allCases) { type in
                    Text(type.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)

            TextField("Title", text: $viewModel.title)

            TextField("Instructions", text: $viewModel.instructions)

            TextField("Motivation (Optional)", text: $viewModel.motivation)

            Picker("Card Style", selection: $viewModel.selectedCard) {
                ForEach(CareKitCard.allCases) { item in
                    Text(item.rawValue)
                }
            }

            Toggle("Select Specific Day", isOn: $repeating)

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
