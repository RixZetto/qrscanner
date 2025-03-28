//
//  QRScannerView.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 27/03/25.
//
import SwiftUI

struct QRScannerView: UIViewControllerRepresentable {
    
    
    func makeUIViewController(context: Context) -> some UIViewController {
        QRScannerViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // TODO: - 
    }
}

