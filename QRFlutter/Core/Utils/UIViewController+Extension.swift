//
//  UIViewController+Extension.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 28/03/25.
//

import UIKit

extension UIViewController {
    
    func dismissViewcontroller() {
        DispatchQueue.main.async {
            if let navigationController = self.navigationController {
                navigationController.popViewController(animated: true)
            } else if let presentingVC = self.presentingViewController {
                presentingVC.dismiss(animated: true)
            } else {
                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = scene.windows.first,
                   let rootVC = window.rootViewController {
                    rootVC.dismiss(animated: true)
                }
            }
        }
    }
    
}
