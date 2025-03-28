//
//  ProtectedView.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 28/03/25.
//

import LocalAuthentication
import SwiftUI

struct ProtectedView<Content:View> : View {
    @State private var isAuthenticating: Bool = false
    @State private var isAuthenticated: Bool = false
    @State private var showError: Bool = false
    var defaultText: String = "Protected View"
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        VStack {
            if isAuthenticated {
                self.content()
            }
            else {
                if showError {
                    Spacer()
                    VStack(spacing: 20) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .tint(.red)
                        Text("No hemos podido reconocer tu identidad. Intentalo de nuevo.")
                    }.padding(20)
                }
                
                Spacer()
                Button {
                    Task {
                        await self.authenticateUser()
                    }
                } label: {
                    Image(systemName: "faceid")
                    Text("Autenticar")
                }
                .buttonStyle(.bordered)
                .disabled(isAuthenticating)

            }
        }
        .onAppear {
            Task {
                await self.authenticateUser()
            }
        }
    }
    
    func authenticateUser() async  {
        let context = LAContext()
        var error: NSError?
        self.isAuthenticating = true
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Autenticación requerida") { success, error in
                DispatchQueue.main.async {
                    self.isAuthenticating = false
                    if success {
                        self.isAuthenticated = true
                    }else {
                        self.showError = true
                    }
                }
            }
        } else {
            self.isAuthenticating = false
            self.showError = true
        }
    }
}

#Preview {
    ProtectedView {
        Text("Hello, World!")
    }
}
