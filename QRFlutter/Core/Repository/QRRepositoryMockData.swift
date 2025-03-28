//
//  QRRepositoryMockData.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 28/03/25.
//
import Foundation

class QRRepositoryMockData: QRRepository {
    var storedCodes: [String] = ["1234567890", "1234567891"]
    
    override func totalQRCodes() -> Int {
        return storedCodes.count
    }
    
    override func saveQRCode(_ qrCode: String) {
        self.storedCodes.append(qrCode)
    }
    
    override func fetchQRCodes() -> [QRCode] {
        return storedCodes.map { QRCode(content: $0) }
    }
}
