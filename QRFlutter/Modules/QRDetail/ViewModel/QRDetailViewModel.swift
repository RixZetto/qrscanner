//
//  QRDetailViewModel.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 28/03/25.
//

import Foundation

class QRDetailViewModel: ObservableObject {
    let repository: QRRepository
    
    init(repository: QRRepository) {
        self.repository = repository
    }
    
    @MainActor
    func store(qr: String) {
        self.repository.saveQRCode(qr)
    }
    
}
