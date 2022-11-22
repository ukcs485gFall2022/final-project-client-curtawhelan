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
            TextField("Title", text: $viewModel.title)

            TextField("Instructions", text: $viewModel.instructions)

            TextField("Motivation", text: $viewModel.motivation)

            Picker("Card Style", selection: $viewModel.selectedCard) {
                ForEach(CareKitCard.allCases) { item in
                    Text(item.rawValue)
                }
            }

            Picker("Schedule", selection: $viewModel.selectedDay) {
                ForEach(WeekDays.allCases) { day in
                    Text(day.rawValue.capitalized)
                }
            }
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
