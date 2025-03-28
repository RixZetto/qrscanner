//
//  QRScannerViewController.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 27/03/25.
//
import UIKit
import AVFoundation

class QRScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    let viewModel = QRScannerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.initVideoCapture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkCameraPermissions()
    }
    
    // MARK: - Check permissions
    func checkCameraPermissions() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            print("Camera permission OK")
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    print("Camera permission OK")
                } else {
                    self.showRequestPermissionAlert()
                    print("Camera permission denied")
                }
            }
        default:
            self.showRequestPermissionAlert()
            print("Camera permission denied")
        }
    }
    
    func showRequestPermissionAlert() {
        let alert = UIAlertController(
            title: "Se requiere acceso a la Cámara",
            message: "Esta aplicación requiere acceso a la cámara para poder escanear los códigos QR.",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ir a Configuración", style: .default, handler: { _ in
            self.viewModel.openSettings()
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { _ in
            self.dismissViewcontroller()
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    // MARK: - initialize video capture components
    func initVideoCapture() {
        self.captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if self.captureSession.canAddInput(videoInput) {
            self.captureSession.addInput(videoInput)
        } else {
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if self.captureSession.canAddOutput(metadataOutput) {
            self.captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: .main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            return
        }
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        self.previewLayer.frame = self.view.layer.bounds
        self.previewLayer.videoGravity = .resizeAspectFill
        
        self.view.layer.addSublayer(self.previewLayer)
    }
    
}
