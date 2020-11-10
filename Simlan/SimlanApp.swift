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
//		StartupAPI.shared.updateEducation(education: Education(college: "ND Sux", major: "Undecided", gpa: 1.0, tags: []))
//		StartupAPI.shared.updateExperience(experience: Experience(name: "A Job", description: "nothing", tags: []))
		StartupAPI.shared.getListings()
//		StartupAPI.shared.createListing(listing: Listing(name: "Worst Job", start: Date()))
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(ViewRouter())
        }
    }
}
