//
//  QRCode.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 28/03/25.
//

import Foundation
import SwiftData

@Model
class QRCode {
    var id: UUID
    var content: String
    var scannedAt: Date?
    
    init(content: String, scannedAt: Date? = nil) {
        self.id = UUID()
        self.content = content
        self.scannedAt = scannedAt
    }
}
