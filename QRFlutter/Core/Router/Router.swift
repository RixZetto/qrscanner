//
//  Router.swift
//  QRFlutter
//
//  Created by Ricardo Rodríguez on 28/03/25.
//
import SwiftUI

class Router: ObservableObject {
    
    @Published var path = NavigationPath()
    
    func navigate(to route: AppRoute) {
        path.append(route)
    }
    
    func goBack() {
        path.removeLast()
    }
    
}
