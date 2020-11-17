//
//  SimlanApp.swift
//  Simlan
//
//  Created by Jio Buenviaje on 10/22/20.
//

import SwiftUI
import Firebase
import FirebaseCore

@main
struct SimlanApp: App {
    @EnvironmentObject var viewRouter: ViewRouter
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            // TestView()
           ContentView().environmentObject(ViewRouter())
        }
    }
}
