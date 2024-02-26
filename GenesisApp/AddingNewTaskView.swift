//
//  AddingNewTaskView.swift
//  AppGenesis
//
//  Created by LAKSHMI VENKATA SIVA TUNUGUNTLA on 2/24/24.
//

import Foundation
import SwiftUI

struct AddingNewTaskView: View {
    @EnvironmentObject var taskDataModel: TaskDataModel
    @Environment(\.dismiss) var dismiss
    @State var title: String = ""
    @State var notes: String = ""
    @State var isDisabled = true
    
    var body: some View {
        NavigationStack {
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
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Adding New Task").font(.headline)
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button {
                       
                       add()
                    } label: {
                        Text("Add")
                    }
                    .disabled(isDisabled)
                }
            }
            .onChange(of: title) { newValue in
                debugPrint("\(newValue)")
                isDisabled = newValue.isEmpty
            }
        }
    }
    
    func add() {
        let item = ItemData(title: title, notes: notes, completed: false)
        taskDataModel.save(key: "tasks", item: item)
        dismiss()
    }
}
