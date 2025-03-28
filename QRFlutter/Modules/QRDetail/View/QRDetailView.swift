//
//  QRDetailView.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 28/03/25.
//

import SwiftUI

struct QRDetailView: View {
    @State var code: IdentifiableQRCode
    @Binding var showDetail: Bool
    @StateObject var viewModel: QRDetailViewModel
    var onStoredQR: ((_ storedQR: String) -> Void)?
    
    init(code: IdentifiableQRCode, showDetail: Binding<Bool>, repository: QRRepository, onStoreQR: ((_ storedQR: String) -> Void)? = nil) {
        self.code = code
        self._showDetail = Binding(projectedValue: showDetail)
        self._viewModel = StateObject(wrappedValue: QRDetailViewModel(repository: repository))
        self.onStoredQR = onStoreQR
    }
    
    var body: some View {
        VStack {
            
            Text("QR Consumido")
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Contenido")
                    .font(.caption)
                    
                Text(code.code)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                
            }.padding()
                .foregroundColor(.primary)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(20)
            
            Spacer()
            
            HStack {
                Button {
                    self.viewModel.store(qr: code.code)
                    self.onStoredQR?(code.code)
                    self.showDetail = false
                } label: {
                    Image(systemName: "qrcode")
                    Text("Guardar")
                        .frame(maxWidth: .infinity)
                }
                
                .buttonStyle(.bordered)
                
                Button {
                    self.showDetail = false
                } label: {
                    Text("Cancelar")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            }.padding(20)
        }
        
    }
    
    
}

#Preview {
    QRDetailView(code: IdentifiableQRCode("Abcdef123456 URL test string cntent abc def aaaa"), showDetail: .constant(true), repository: QRRepository())
}
