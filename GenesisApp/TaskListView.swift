//
//  TaskListView.swift
//  AppGenesis
//
//  Created by LAKSHMI VENKATA SIVA TUNUGUNTLA on 2/24/24.
//

import Foundation

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var taskDataModel: TaskDataModel
    @State var showingSheet: Bool = false
    @State var firstTime = true

    // Default tasks
    let defaultTasks: [ItemData] = [
        ItemData(title: "Task 1", notes: "Task1 Notes", completed: false)
    ]

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ForEach(taskDataModel.items, id: \.id) { item in
                    HStack {
                        NavigationLink {
                            TaskDetailView(item: item)
                        } label: {
                            Text(item.title)
                        }
                        Spacer()
                        Image(systemName: item.completed == true ? "checkmark.square" : "square")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .foregroundColor(item.completed == true ? .green : .red)
                    }
                    Divider()
                }
                Spacer()
                Button {
                    showingSheet = true
                } label: {
                    HStack {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        Text("New Task")
                        Spacer()
                    }
                }
            }
            .padding()
            .background(Color.white)
            .navigationBarTitle("My Tasks")
            .onAppear {
                if firstTime == true {
                    taskDataModel.restore(key: "tasks")
                    firstTime = false
                }
            }
            .fullScreenCover(isPresented: $showingSheet) {
                AddingNewTaskView()
            }
            .padding()
            .background(Color.gray.opacity(0.1))
        }
    }
}

