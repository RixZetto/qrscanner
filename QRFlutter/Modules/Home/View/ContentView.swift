//
//  ContentView.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 26/03/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var qrRepository: QRRepository
    @Environment(\.modelContext) private var modelContext
    //@Query private var items: [Item]
    @State private var isAuthenticated = false
    @State private var showToast: Bool = false
    @State private var selectedCode: IdentifiableQRCode?
    @State private var showDetails: Bool = false
    @State private var isScanning: Bool = false
    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        NavigationStack(path: self.$router.path) {
            ZStack {
                
                // Wallpaper
                Image("wallpaper")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    
                    // MARK: - Header
                    VStack(spacing: 4) {
                        Text("Secured QRScanner")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                        
                        Text("By Ricardo Rodríguez")
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                    
                    // MARK: - Scan Button
                    
                    Button {
                        self.router.navigate(to: .qrScanner)
                    } label: {
                        ScanButton()
                    }.accessibilityLabel("scanQR")
                    

                    Spacer()
                    
                    
                    ZStack {
                        
                        // MARK: - About this App
                        VStack {
                            Button {
                                viewModel.showAboutView()
                            } label: {
                                Image(systemName: "info.bubble.fill.rtl")
                                Text("Acerca del App")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                            }
                            .padding()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                 
                        }
                        
                        // MARK: - Vault Button
                        HStack {
                            Spacer()
                            Button {
                                self.router.navigate(to: .flutterScreen)
                            } label: {
                                VaultButton()
                            }
                            .accessibilityLabel("vault")
                            .padding(.horizontal, 40)
                            
                        }
                        
                        
                    }
                    
                    
                }
            }.navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .qrScanner:
                    ScannerView(isScanning: $isScanning) { code in
                        self.selectedCode = IdentifiableQRCode(code)
                        self.showDetails.toggle()
                    }.accessibilityLabel("scanView")
                case .flutterScreen:
                    ProtectedView {
                        FlutterView(repository: qrRepository, engineManager: FlutterEngineManager())
                            .accessibilityLabel("flutterVaultView")
                    }.accessibilityLabel("protectedView")
                }
            }
            
        }
        
        .sheet(isPresented: $viewModel.isAboutViewPresented) {
            Group {
                AboutView()
            }.accessibilityIdentifier("AboutSheet")
                .presentationDetents([.medium, .large])
                .padding(10)
            
        }
        .sheet(isPresented: $showDetails) {
            if let selectedCode = self.selectedCode {
                QRDetailView(code: selectedCode, showDetail: $showDetails, repository: qrRepository) { storedCode in
                    self.showToast.toggle()
                }
            }
        }
        .toast(isShowing: $showToast, message: "✅ QR Guardado en Vault!") {
            self.showToast = false
        }
        .onChange(of: showDetails) { oldValue, newValue in
            if newValue == false {
                self.isScanning = true
            }
        }
    }

}

#Preview {
    ContentView()
        .modelContainer(for: QRCode.self, inMemory: true)
        .environmentObject(QRRepositoryMockData())
}
