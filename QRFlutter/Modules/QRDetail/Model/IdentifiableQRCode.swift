//
//  IdentifiableQRCode.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 28/03/25.
//
import Foundation

struct IdentifiableQRCode: Identifiable {
    let id: UUID
    var code: String
    
    init(_ code: String) {
        self.id = UUID()
        self.code = code
    }
}
