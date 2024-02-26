//
//  GenesisAppApp.swift
//  GenesisApp
//
//  Created by LAKSHMI VENKATA SIVA TUNUGUNTLA on 2/26/24.
//

import SwiftUI

@main
struct MyTasksApp: App {
    @StateObject var taskDataModel = TaskDataModel()
    
    var body: some Scene {
        WindowGroup {
            TaskListView()
                .environmentObject(taskDataModel)
        }
    }
}
