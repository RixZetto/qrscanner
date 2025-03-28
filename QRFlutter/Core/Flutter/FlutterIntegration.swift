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
        
        let qrCodeController = FlutterMethodChannel(
            name: "com.rixstudio.qrcode",
            binaryMessenger: engine.binaryMessenger
        )
        
        qrCodeController.setMethodCallHandler { (call, result) in
            if call.method == "fetchQRCodes" {
                Task { @MainActor in
                    let codes = QRRepository.shared.fetchQRCodes().map { qrCode in
                        return [
                            "content": qrCode.content,
                            "id": qrCode.id.uuidString,
                            "scannedAt": qrCode.scannedAt?.ISO8601Format() ?? ""
                        ]
                    }
                    
                    result(codes)
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        
        GeneratedPluginRegistrant.register(with: self.engine)
    }
    
    // MARK: - Init Flutter ViewController
    func createFlutterViewController() -> FlutterViewController {
        FlutterViewController(engine: self.engine, nibName: nil, bundle: nil)
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
}

// MARK: - View
struct FlutterView: UIViewControllerRepresentable {
    var repository: QRRepository
    var engineManager: FlutterEngineManager
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = engineManager.createFlutterViewController()
        
        let qrCodeController = FlutterMethodChannel(
            name: "com.rixstudio.qrcode",
            binaryMessenger: engineManager.engine.binaryMessenger
        )
        
        qrCodeController.setMethodCallHandler { (call, result) in
            if call.method == "fetchQRCodes" {
                Task { @MainActor in
                    let codes = QRRepository.shared.fetchQRCodes().map { qrCode in
                        return [
                            "content": qrCode.content,
                            "id": qrCode.id.uuidString,
                            "scannedAt": qrCode.scannedAt?.ISO8601Format() ?? ""
                        ]
                    }
                    
                    result(codes)
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
