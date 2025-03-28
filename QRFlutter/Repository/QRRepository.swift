//
//  QRRepository.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 28/03/25.
//
import SwiftData
import Foundation

@MainActor
class QRRepository: ObservableObject {
    static let shared = QRRepository()
    private let container: ModelContainer
    private let context: ModelContext
    
    init() {
        do {
            let schema = Schema([QRCode.self])
            let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            self.container = try ModelContainer(for: schema, configurations: config)
            self.context = self.container.mainContext
        } catch {
            fatalError("Failed on initializing ModelContainer: \(error)")
        }
    }
    
    // MARK: - Add QRCodes to Repository
    func saveQRCode(_ qrCode: String) {
        let model = QRCode(content: qrCode)
        self.context.insert(model)
        do {
            try self.context.save()
        } catch {
            
        }
    }
    
}
