//
//  Page.swift
//  Simlan
//
//  Created by Jio Buenviaje on 10/29/20.
//

import Foundation

struct Page: Identifiable {
    
    let id: UUID
    let image: String
    let heading: String
    let subSubheading: String
    
    static var getAll: [Page] {
        [
            Page(id: UUID(), image: "screen-1", heading: "Lorem ipsum dolor", subSubheading: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."),
            Page(id: UUID(), image: "screen-2", heading: "Lorem ipsum dolor", subSubheading: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."),
            Page(id: UUID(), image: "screen-3", heading: "Lorem ipsum dolor", subSubheading: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."),
            Page(id: UUID(), image: "screen-4", heading: "Lorem ipsum dolor", subSubheading: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.")
            
        ]
    }
}
