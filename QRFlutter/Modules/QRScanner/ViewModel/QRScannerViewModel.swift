//
//  QRScannerViewModel.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 28/03/25.
//

import UIKit

class QRScannerViewModel {
    
    // MARK: - Handle Navigation
    
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
    
}
