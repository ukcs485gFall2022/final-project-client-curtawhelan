//
//  TaskView.swift
//  OCKSample
//
//  Created by Curt Whelan on 10/27/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import SwiftUI

struct TaskView: View {
    var body: some View {
        NavigationView {
            Form {
                general
            }
            .navigationTitle("Add Task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {

                    }
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) {

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
            TextField("Task Title", text: .constant(""))
            TextField("Description", text: .constant(""))
            TextField("Task Motivation", text: .constant(""))
        } header: {
            Text("General")
        }
        .headerProminence(.increased)
    }
}
