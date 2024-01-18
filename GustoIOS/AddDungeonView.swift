//
//  AddDungeonView.swift
//  GustoIOS
//
//  Created by Carlo Luis Martinez on 18/1/24.
//

import SwiftUI

struct AddDungeonView: View {
    @State var dungeon: Dungeon = Dungeon(name: "God", level: 1, difficulty: 1, skillNeedded: 1)
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context

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
        }
    }
    func save() {
        context.insert(dungeon)
        try? context.save()
        dismiss()
    }
}

#Preview {
    AddDungeonView()
}
