//
//  QRFlutterApp.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 26/03/25.
//

import SwiftUI
import SwiftData
import Flutter

@main
struct QRFlutterApp: App {
    @StateObject private var qrRepository: QRRepository
    @StateObject private var router = Router()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            QRCode.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init() {
        self._qrRepository = StateObject(wrappedValue: QRRepository.shared)
    }
    

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(qrRepository)
                .environmentObject(router)
        }
        .modelContainer(sharedModelContainer)
    }
}
