//
//  ToastView.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 28/03/25.
//
import SwiftUI

struct ToastView: View {
    let message: String
    
    var body: some View {
        Text(message)
            .padding()
            .background(Color.black.opacity(0.7))
            .foregroundStyle(.white)
            .cornerRadius(20)
            .padding()
            .transition(.move(edge: .top).combined(with: .opacity))
            .animation(.easeOut(duration: 0.5), value: message)
    }
}

struct ToastModifier: ViewModifier {
    @Binding var isShowing: Bool
    
    let message: String
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                VStack {
                    Spacer()
                    ToastView(message: message)
                }
                .padding(.top, 40)
                .transition(.opacity)
                .animation(.easeInOut, value: isShowing)
            }
        }
    }
}

extension View {
    func toast(isShowing: Binding<Bool>, message: String, onComplete: (() -> Void)? = nil) -> some View {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            onComplete?()
        }
        return self.modifier(ToastModifier(isShowing: isShowing, message: message))
    }
}

fileprivate struct ToastPreview: View {
    @State var showToast = false
    
    var body: some View {
        VStack {
            Button("Probar Toast") {
                showToast = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showToast = false
                }
            }
        }.toast(isShowing: $showToast, message: "Mensaje de prueba")
    }
}

#Preview {
    ToastPreview()
}

