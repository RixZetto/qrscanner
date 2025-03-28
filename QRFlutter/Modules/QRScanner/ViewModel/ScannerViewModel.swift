//
//  ScannerViewModel.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 28/03/25.
//
import Foundation

class ScannerViewModel: ObservableObject {
    
    private let repository: QRRepository
    
    init(repository: QRRepository) {
        self.repository = repository
    }

    @MainActor
    func storeQR(_ qr: String) async {
        self.repository.saveQRCode(qr)
    }
}
