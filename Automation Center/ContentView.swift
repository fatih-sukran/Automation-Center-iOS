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
    @ObservedObject var viewModel: TestMethodViewModel

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(viewModel.testMethods) { testMethod in
                    NavigationLink {
                        TestDetailView(test: testMethod)
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
        .onAppear { // fetch all data when page appear
            Task {
                await viewModel.fetchAll()
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = TestMethod(id: 0, name: "Test")
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
////                modelContext.delete(testMethods[index])
//            }
//        }
    }
}

#Preview {
    ContentView(viewModel: TestMethodViewModel())
        .modelContainer(for: TestMethod.self, inMemory: true)
}
