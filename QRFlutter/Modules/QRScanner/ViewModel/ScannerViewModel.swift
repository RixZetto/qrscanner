//
//  ScannerViewModel.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 28/03/25.
//
import Foundation

class ScannerViewModel: ObservableObject {
    private let repository: QRRepository
    @Published var showToast: Bool = false
    
    init(repository: QRRepository) {
        self.repository = repository
    }
    
    @MainActor
    func handleScannedCode(_ code: String) async {
        self.showToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showToast = false
        }
        self.repository.saveQRCode(code)
    }

}
