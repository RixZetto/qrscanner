//
//  QRFlutterApp.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 26/03/25.
//

import SwiftUI
import SwiftData

@main
struct QRFlutterApp: App {
    @StateObject private var qrRepository = QRRepository.shared
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
                .environmentObject(qrRepository)
        }
        .modelContainer(sharedModelContainer)
    }
}
