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
    @State var monstersNumber: Int =  0
    var body: some View {
            Form {
                TextField("Enter Dungeon name", text: $name)
                TextField("Enter Dungeon Level", value: $level, format: .number)
                Button {
                    monstersNumber+=1
                } label: {
                  
                    Label {
                        Text("Add Random Monster \(monstersNumber)")
                            .foregroundStyle(.primary)
                    } icon: {
                        RoundedRectangle(cornerRadius: 0)
                            .fill(.blue)
                            .frame(width: 10, height: 10)
                    }
                }
                Button {
                   update()
                } label: {
                    Label("Update Dungeon", systemImage: "plus.circle.fill")
                }
            }.onAppear {
            name = dungeon.name
            level = dungeon.level
        monstersNumber = dungeon.monsters.count
            }.alert("Error in Updating", isPresented: $presentError) {
                Button("OK", role: .cancel) {
                    presentError = false
                }
            }
    }
    
    func generateRandomMonsters(monstersNumber: Int) -> [Monster] {
        var monsters: [Monster] = []

        for _ in 1...monstersNumber {
            let randomId = UUID().uuidString
            let randomName = "\(dungeon.name) monster \(Int.random(in: 1...100))"
            let randomLevel = Int.random(in: 1...10)

            let monster = Monster(id: randomId, name: randomName, level: randomLevel)
            monsters.append(monster)
        }

        return monsters
    }
    func update() {
        dungeon.name = name
        dungeon.level = level
        
        if monstersNumber > 0 {
            dungeon.monsters = generateRandomMonsters(monstersNumber: monstersNumber)
        }
        
        do {
            try context.save()
            dismiss()
        } catch  {
            presentError = true
        }
    }
}

#Preview {
    EditDungeonView(dungeon: Dungeon(name: "Hello", level: 1, difficulty: 1, skillNeedded: 1, monsters: []))
}
