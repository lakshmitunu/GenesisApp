//
//  TaskDataModel.swift
//  AppGenesis
//
//  Created by LAKSHMI VENKATA SIVA TUNUGUNTLA on 2/24/24.
//

import Foundation

import SwiftUI

struct ItemData: Identifiable, Encodable, Decodable, Hashable {
    var id: String = UUID().uuidString
    var title: String
    var notes: String
    var completed: Bool
}

class TaskDataModel: ObservableObject {
    @Published var items: [ItemData] = []
    
    func restore(key: String) {
        if UserDefaults.standard.object(forKey: key) == nil {
            return
        }
        let json = UserDefaults.standard.string(forKey: key) ?? "{}"
        let jsonDecoder = JSONDecoder()
        guard let jsonData = json.data(using: .utf8) else {
            return
        }
        do {
            let items: [ItemData] = try jsonDecoder.decode([ItemData].self, from: jsonData)
            self.items = items
        } catch {
            debugPrint("🧨", "updateItemsForMoreItems: \(error)")
        }
    }
    
    func save(key: String, item: ItemData) {
        self.items.append(item)
        saveToStorage(key: key, item: items)
    }
    
    func saveToStorage(key: String, item: [ItemData]) {
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(self.items)
            let json = String(data: jsonData, encoding: .utf8) ?? "{}"
            let userDefaults = UserDefaults.standard
            userDefaults.set(json, forKey: key)
            userDefaults.synchronize()
        } catch {
            debugPrint("🧨", "updateItemsForMoreItems: \(error)")
        }
    }
    
    func update(item: ItemData, completed: Bool) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            self.items[index].completed = completed
            saveToStorage(key: "tasks", item: items)
        }
    }
    
}
