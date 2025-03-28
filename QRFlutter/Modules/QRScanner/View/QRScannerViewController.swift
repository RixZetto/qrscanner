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
    let viewModel: QRScannerViewModel!
    
    init(qrRepository: QRRepository) {
        self.viewModel = QRScannerViewModel(repository: qrRepository)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.viewModel.delegate = self
        self.initVideoCapture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.checkCameraPermissions()
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
    
    // MARK: - QR Detection
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
           metadataObject.type == .qr,
           let qrCode = metadataObject.stringValue {
            self.captureSession.stopRunning()
            self.viewModel.storeQR(qrCode)
        }
    }

          
}

// MARK: - QRScannerViewDelegate Implementation

extension QRScannerViewController: QRScannerViewDelegate {
    
    func onCameraPermissionGranted() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }
    
    func showRequestPermission() {
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
    
}
