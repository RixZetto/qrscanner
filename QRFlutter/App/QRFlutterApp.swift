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
    //@StateObject private var flutterEngine: FlutterEngineWrapper
    
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
        //let engineWrapper = FlutterEngineWrapper()
        self._qrRepository = StateObject(wrappedValue: QRRepository.shared)
        //self._flutterEngine = StateObject(wrappedValue: engineWrapper)
    }
    

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(qrRepository)
                //.environmentObject(flutterEngine)
        }
        .modelContainer(sharedModelContainer)
    }
}
