//
//  ShimmerText.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 27/03/25.
//

import SwiftUI

struct ShimmerText: View {
    @State private var isAnimating: Bool = true
    var text: String = ""
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        
        Rectangle()
            .overlay {
                LinearGradient(colors: [.clear, .white, .clear], startPoint: .leading, endPoint: .trailing)
                    .frame(width: 150)
                    .offset(x: isAnimating ? -screenWidth/2 : screenWidth/2)
            }
            .animation(
                .linear(duration: 2)
                .repeatForever(autoreverses: false), value: isAnimating)
            .mask {
                Text(text)
                    .foregroundColor(.black)
                    .font(.largeTitle)
            }
            .onAppear {
                self.isAnimating.toggle()
            }
            .background(.gray)
        
    }
}

#Preview {
    VStack {
        ShimmerText(text: "Scan Button")
    }
}
