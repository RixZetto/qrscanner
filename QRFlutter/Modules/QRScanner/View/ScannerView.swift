//
//  ScannerView.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 27/03/25.
//
import SwiftUI
import AVFoundation

struct ScannerView: UIViewControllerRepresentable {
    @StateObject var viewModel: ScannerViewModel
    
    init(qrRepository: QRRepository) {
        self._viewModel = StateObject(wrappedValue: ScannerViewModel(repository: qrRepository))
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = QRScannerViewController()
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // TODO: - 
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, QRScannerViewControllerDelegate {
        var parent: ScannerView
        
        init(_ parent: ScannerView) {
            self.parent = parent
        }
        
        func onScanned(code: String) {
            Task { @MainActor in
                await self.parent.viewModel.storeQR(code)
            }
        }
    }
}

