//
//  EditDungeonView.swift
//  GustoIOS
//
//  Created by Carlo Luis Martinez on 18/1/24.
//

import SwiftUI

struct EditDungeonView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State var presentError = false
    
    let dungeon: Dungeon
    @State var name: String = ""
    @State var level: Int =  0
    var body: some View {
            Form {
                TextField("Enter Dungeon name", text: $name)
                TextField("Enter Dungeon Level", value: $level, format: .number)
                Button {
                   update()
                } label: {
                    Label("Update Dungeon", systemImage: "plus.circle.fill")
                }
            }.onAppear {
            name = dungeon.name
            level = dungeon.level
            }.alert("Error in Updating", isPresented: $presentError) {
                Button("OK", role: .cancel) {
                    presentError = false
                }
            }
    }
    func update() {
        dungeon.name = name
        dungeon.level = level
        do {
            try context.save()
            dismiss()
        } catch  {
            presentError = true
        }
    }
}

#Preview {
    EditDungeonView(dungeon: Dungeon(name: "Hello", level: 1, difficulty: 1, skillNeedded: 1))
}
