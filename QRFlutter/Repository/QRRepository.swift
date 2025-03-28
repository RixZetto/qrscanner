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
    
    @Published var totalCodes: Int = 0
    
    init() {
        do {
            let schema = Schema([QRCode.self])
            let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            self.container = try ModelContainer(for: schema, configurations: config)
            self.context = self.container.mainContext
            self.totalCodes = self.totalQRCodes()
        } catch {
            fatalError("Failed on initializing ModelContainer: \(error)")
        }
    }
    
    // MARK: - Get Total
    func totalQRCodes() -> Int {
        let fetchDescriptor = FetchDescriptor<QRCode>()
        do {
            let qrCodes = try self.context.fetch(fetchDescriptor)
            return qrCodes.count
        }
        catch {
            print("Error while fetching \(error.localizedDescription)")
        }
        return 0
    }
    
    // MARK: - Add QRCodes to Repository
     func saveQRCode(_ qrCode: String) {
        let model = QRCode(content: qrCode)
        self.context.insert(model)
        do {
            try self.context.save()
            self.totalCodes += 1
        } catch {
            
        }
    }
}
