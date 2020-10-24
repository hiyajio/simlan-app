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
		StartupAPI.shared.testURL()
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(ViewRouter())
        }
    }
}
