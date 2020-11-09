//
//  User.swift
//  Simlan
//
//  Created by Zachary Sy on 11/8/20.
//

import SwiftUI
import Combine

class User: ObservableObject{
	@Published var experience:[Experience] = []
	@Published var education:[Education] = []
	
	@Published var firstName:String = ""
	@Published var lastName:String = ""
	@Published var email:String = ""
	@Published var password:String = ""
	@Published var isApplicant:Bool = true
	@Published var country:String = ""
	@Published var location:String = ""
	@Published var greeting:String = ""
	@Published var linkedIn:String = ""
	@Published var github:String = ""
	@Published var tags:[String] = []
	
	
}


struct Experience{
	var name:String
	var start:Date?
	var end:Date?
	var present:Bool?
	var project:Bool?
	var title:String?
	var description:String
	var tags:[String]
}

struct Education{
	var college:String
	var start:Date = Date()
	var end:Date?
	var present:Bool?
	var major:String
	var minor:String?
	var gpa:Double
	var tags:[String]
}

struct Listing{
	var name:String
	var start:Date?
	var location:String?
	var type:String?
	var paid:Bool?
	var title:String
	var description:String?
	var tags:[String]
}
