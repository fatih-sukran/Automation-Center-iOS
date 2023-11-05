//
//  ContentView.swift
//  Automation Center
//
//  Created by fatih.sukran on 5.11.2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var testMethods: [TestMethod]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(testMethods) { testMethod in
                    NavigationLink {
                        Text("Test Method: \(testMethod.name)")
                    } label: {
                        Text("Test Method: \(testMethod.name)")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = TestMethod(id: 0, name: "Test")
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(testMethods[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: TestMethod.self, inMemory: true)
}
