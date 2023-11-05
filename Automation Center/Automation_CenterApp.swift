//
//  Automation_CenterApp.swift
//  Automation Center
//
//  Created by fatih.sukran on 5.11.2023.
//

import SwiftUI
import SwiftData

@main
struct Automation_CenterApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            TestMethod.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
