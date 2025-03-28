//
//  AboutView.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 27/03/25.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        PresentationCard(
            appName: "Secured QR Scanner",
            devName: "Ricardo Rodríguez",
            devEmail: "rrodriguezgarcia@gmail.com",
            devPortfolio: "https://www.rixcode.dev",
            gitUrl: "https://github.com/RixZetto/qrscanner")
    }
}


#Preview {
    AboutView()
}
