//
//  ContentView.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 26/03/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var isAuthenticated = false

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                NavigationLink(destination: QRScannerView()) {
                    ScanButton()
                }.accessibilityLabel("scanQR")
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: QRScannerView()) {
                        VaultButton()
                    }.accessibilityLabel("vault")
                }.padding(20)
            }
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
