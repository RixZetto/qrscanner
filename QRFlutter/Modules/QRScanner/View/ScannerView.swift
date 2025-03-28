//
//  ScannerView.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 27/03/25.
//
import SwiftUI
import AVFoundation

struct ScannerView: UIViewControllerRepresentable {
    @Binding var isScanning: Bool
    var onCodeScanned: ((String) -> Void)?
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = QRScannerViewController()
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if let qrVC = uiViewController as? QRScannerViewController {
            if isScanning {
                qrVC.startScanner()
            }
            else {
                qrVC.stopScanner()
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, QRScannerViewControllerDelegate {
        var parent: ScannerView
        
        init(_ parent: ScannerView) {
            self.parent = parent
        }
        
        func onScannerStarted() {
            self.parent.isScanning = true
        }
        
        func onScannerStopped() {
            self.parent.isScanning = false
        }
        
        func onScanned(code: String) {
            self.parent.onCodeScanned?(code)
        }
    }
}

