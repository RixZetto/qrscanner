//
//  ScanButton.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 27/03/25.
//

import SwiftUI

struct ScanButton: View {
    @State private var isPressed = false
    @State private var shimmerOffset: CGFloat = -150
    
    var body: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0)) {
                isPressed.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isPressed.toggle()
            }
            
        } label: {
            HStack {
                Image(systemName: "qrcode.viewfinder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .padding()
                Text("Escanear QR")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
            }
            .background {
                ZStack {
                    Color.blue.clipShape(Capsule())
                    
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, .white, .clear]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ).frame(width: 200, height: 200)
                        .offset(x: self.shimmerOffset)
                        .blendMode(.overlay)
                }
            }
            .clipShape(Capsule())
            .onAppear {
                self.startAnimation()
            }
            
        }
        .buttonStyle(PlainButtonStyle())
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .scaleEffect(isPressed ? 1.2 : 1)
    }
    
    
    // MARK: - Animation Methods
    
    func startAnimation() {
        withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
            self.shimmerOffset = 200
        }
    }

}


#Preview {
    VStack {
        ScanButton()
    }
}
