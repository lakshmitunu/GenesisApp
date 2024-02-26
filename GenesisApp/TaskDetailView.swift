//
//  TaskDetailView.swift
//  AppGenesis
//
//  Created by LAKSHMI VENKATA SIVA TUNUGUNTLA on 2/24/24.
//

import Foundation

import SwiftUI

struct TaskDetailView: View {
  
    @EnvironmentObject var taskDataModel: TaskDataModel
    var item: ItemData
    @State var title: String = ""
    @State var notes: String = ""
    @State var toggleCompleted = false
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                } header: {
                    Text("Task Title")
                }
                Section {
                  TextField("Notes", text: $notes, axis: .vertical)

                } header: {
                    Text("Notes")
                }
                HStack {
                    Toggle("Completed", isOn: $toggleCompleted)
                }
            }
        }
        .onAppear {
            title = item.title
            notes = item.notes
            toggleCompleted = item.completed
        }
        .onChange(of: toggleCompleted) {newValue in
          taskDataModel.update(item: item, completed: newValue)
        }
    }
}

