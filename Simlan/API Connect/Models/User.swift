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
	
	init(from info:StartupAPI.UserResponse.User, experience:[StartupAPI.UserResponse.Experience]=[], education:[StartupAPI.UserResponse.Education] = []){
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
		
		for exp in experience{
			self.experience.append(Experience(from: exp))
		}
		
		for edu in education{
			self.education.append(Education(from: edu))
		}
		
		
	}
	
}


struct Experience{
	var name:String
	var start:Date
	var end:Date?
	var present:Bool?
	var project:Bool?
	var title:String?
	var description:String?
	var tags:[String] = []
	
	init(name:String, start:Date, tags:[String]){
		self.name = name
		self.start = start
		self.tags = tags
	}
	
	init(from info:StartupAPI.UserResponse.Experience) {
		let df = DateFormatter()
		df.dateFormat = "yyyy-MM-dd"
		
		name = info.name
		start = df.date(from: info.start)!
		
		if let endDate = info.end{
			end = df.date(from: endDate)
		}else{
			end = nil
		}
		
		present = info.present
		project = info.project
		title = info.title
		description = info.description
		tags = info.tags ?? []
		
	}
}

struct Education{
	var college:String
	var start:Date
	var end:Date?
	var present:Bool?
	var major:String
	var minor:String?
	var gpa:Double
	var tags:[String]
	
	init(from info:StartupAPI.UserResponse.Education){
		let df = DateFormatter()
		df.dateFormat = "yyyy-MM-dd"
		
		college = info.college
		start = df.date(from: info.start)!
		
		if let endDate = info.end{
			end = df.date(from: endDate)
		}else{
			end = nil
		}
		
		present = info.present
		major = info.major
		minor = info.minor
		gpa = Double(info.gpa ?? "0.0") ?? 0.0
		tags = info.tags ?? []
		
	}
}

struct Listing{
	var name:String
	var ownerId:String?
	var start:Date
	var location:String?
	var type:String?
	var paid:Bool?
	var title:String
	var description:String?
	var tags:[String]
	
	init(name:String,start:Date,location:String?=nil,type:String?=nil,paid:Bool?=nil,title:String,description:String?=nil, tags:[String]=[]){
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
