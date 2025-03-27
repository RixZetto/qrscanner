//
//  VaultButton.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 27/03/25.
//

import SwiftUI

struct VaultButton: View {
    @State private var isPressed = false
    
    var body: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0)) {
                isPressed.toggle()
            }
                
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isPressed.toggle()
            }
            
        } label: {
            Image(systemName: "folder.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .shadow(radius: 5)
                .padding()
                .background(Color.blue)
                .clipShape(Circle())
                .scaleEffect(isPressed ? 1.2 : 1.0)
                .shadow(radius: 5)
        }

    }
}

#Preview {
    VaultButton()
}
