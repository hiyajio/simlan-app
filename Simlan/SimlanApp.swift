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
//		StartupAPI.shared.onboardEducation(education: Education(college: "ND Sux", major: "Undecided", gpa: 1.0, tags: []))
//		StartupAPI.shared.onboardExperience(experience: Experience(name: "A Job", start:Date(), description: "nothing", tags: []))
//		StartupAPI.shared.getListings()
//		StartupAPI.shared.createListing(listing: Listing(name: "Worst Job", start: Date()))
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
			TestView()
           // ContentView().environmentObject(ViewRouter())
        }
    }
}
