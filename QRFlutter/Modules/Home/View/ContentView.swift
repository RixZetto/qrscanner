//
//  ContentView.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 26/03/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject private var qrRepository: QRRepository
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var isAuthenticated = false
    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        NavigationStack {
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
                    
                    NavigationLink(destination: ScannerView(qrRepository: qrRepository)) {
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
                            NavigationLink(destination: ScannerView(qrRepository: qrRepository)) {
                                VaultButton()
                            }
                            .accessibilityLabel("vault")
                            .padding(.horizontal, 40)
                        }
                        
                        
                    }
                    
                    
                }
            }
            
        }.sheet(isPresented: $viewModel.isAboutViewPresented) {
            Group {
                AboutView()
            }.accessibilityIdentifier("AboutSheet")
                .presentationDetents([.medium, .large])
                .padding(10)
            
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
