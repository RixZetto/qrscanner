//
//  QRScannerViewModel.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 28/03/25.
//

import UIKit
import AVFoundation

// MARK: - Delegate
protocol QRScannerViewDelegate: AnyObject {
    func onCameraPermissionGranted()
    func showRequestPermission()
}

// MARK: - ViewModel
class QRScannerViewModel: ObservableObject {

    weak var delegate: QRScannerViewDelegate?
    
    // MARK: - Check permissions
    func checkCameraPermissions() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            print("Camera permission OK")
            self.delegate?.onCameraPermissionGranted()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    print("Camera permission OK")
                    self.delegate?.onCameraPermissionGranted()
                } else {
                    self.delegate?.showRequestPermission()
                    print("Camera permission denied")
                }
            }
        default:
            self.delegate?.showRequestPermission()
            print("Camera permission denied")
        }
    }
    
    // MARK: - Handle Navigation
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
    
}
