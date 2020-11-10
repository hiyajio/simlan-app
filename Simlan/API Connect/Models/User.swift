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
	@Published var isApplicant:Bool = true
	@Published var country:String?
	@Published var location:String?
	@Published var greeting:String?
	@Published var linkedIn:String?
	@Published var github:String?
	@Published var tags:[String] = []
	
	init(from info:StartupAPI.UserResponse.User){
		firstName = info.firstName
		lastName = info.lastName
		email = info.email
		isApplicant = info.type
		country = info.country
		location = info.location
		greeting = info.greeting
		linkedIn = info.linkedIn
		github = info.github
		tags = info.tags ?? []
		
	}
	
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
	var ownerId:String?
	var start:Date
	var location:String?
	var type:String?
	var paid:Bool?
	var title:String?
	var description:String?
	var tags:[String]
	
	init(name:String,start:Date,location:String?=nil,type:String?=nil,paid:Bool?=nil,title:String? = nil,description:String?=nil, tags:[String]=[]){
		self.name = name
		self.start = start
		self.location = location
		self.type = type
		self.paid = paid
		self.title = title
		self.description = description
		self.tags = tags
	}
	
	init(from info:StartupAPI.ListingResult.ListingInfo){
		let df = DateFormatter()
		df.dateFormat = "yyyy-MM-dd"
		
		name = info.name
		ownerId = info.owner
		start = df.date(from: info.start)!
		location = info.location
		type = info.type
		paid = info.paid
		title = info.title
		description = info.description
		tags = info.tags ?? []
	}
}
