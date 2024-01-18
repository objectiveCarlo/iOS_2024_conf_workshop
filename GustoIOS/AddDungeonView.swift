//
//  AddDungeonView.swift
//  GustoIOS
//
//  Created by Carlo Luis Martinez on 18/1/24.
//

import SwiftUI
import SwiftData

struct AddDungeonView: View {
    @State var dungeon: Dungeon = Dungeon(name: "God", level: 1, difficulty: 1, skillNeedded: 1, monsters: [])
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    @State var presentError = false

    var body: some View {
        @Bindable var dungeon = dungeon
        NavigationStack {
            Form {
                TextField("Enter Dungeon name", text: $dungeon.name)
                TextField("Enter DungeonLevel", value: $dungeon.level, format: .number)
                Button {
                   save()
                } label: {
                    Label("Save Dungeon", systemImage: "plus")
                }
            }
        }.alert("Error in Adding", isPresented: $presentError) {
            Button("OK", role: .cancel) {
                presentError = false
            }
        }
    }
    func save() {
        let name = dungeon.name
        var duplicateDungeonFetchDescriptor = FetchDescriptor<Dungeon>(predicate: #Predicate { item in
            item.name == name
        })
        duplicateDungeonFetchDescriptor.fetchLimit  = 1
        do {
            let duplicate = try context.fetch(duplicateDungeonFetchDescriptor)
            if !duplicate.isEmpty {
                print("duplicate id \(duplicate[0].id)")
                presentError = true
                return
            }

            context.insert(dungeon)
            try context.save()
            dismiss()

        } catch {
            presentError = true
        }
    }
}

#Preview {
    AddDungeonView()
}
