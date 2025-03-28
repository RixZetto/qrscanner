//
//  FlutterIntegration.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 28/03/25.
//

import SwiftUI
import Flutter

// MARK: - Plugin Registrant
enum GeneratedPluginRegistrant {
    static func register(with registrar: FlutterPluginRegistry) {
        //QRFlutterPlugin.register(with: registrar)
    }
}

// MARK: - Engine Manager
class FlutterEngineManager {
    static let shared = FlutterEngineManager()
    
    let engine: FlutterEngine
    
    init() {
        self.engine = FlutterEngine(name: "flutter-engine")
        self.engine.run()
        GeneratedPluginRegistrant.register(with: self.engine)
    }
}

// MARK: - Property Wrapper
class FlutterEngineWrapper: ObservableObject {
    let engineManager: FlutterEngineManager
    
    init() {
        self.engineManager = FlutterEngineManager()
    }
    
    deinit {
        self.engineManager.engine.destroyContext()
    }
    
    // MARK: - Init Flutter ViewController
    
    func createFlutterViewController() -> UIViewController {
        return FlutterViewController(engine: self.engineManager.engine, nibName: nil, bundle: nil)
    }
    
}

// MARK: - View
struct FlutterView: UIViewControllerRepresentable {
    let engineWrapper: FlutterEngineWrapper
    
    func makeUIViewController(context: Context) -> UIViewController {
        engineWrapper.createFlutterViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
