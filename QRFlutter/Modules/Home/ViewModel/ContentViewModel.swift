//
//  ContentViewModel.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 27/03/25.
//
import SwiftUI

class ContentViewModel: ObservableObject {
    
    @Published var isAboutViewPresented: Bool = false
    
    func showAboutView() {
        isAboutViewPresented.toggle()
    }
    
}
