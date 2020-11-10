//
//  BackendConnection.swift
//  Simlan
//
//  Created by Zachary Sy on 10/24/20.
//

import SwiftUI
import Combine
import Alamofire

class StartupAPI: ObservableObject{
	static let shared = StartupAPI()
	
	static var rootURL:String = "https://startup-5676.nodechef.com/"

	@Published var sessionId:String? = UserDefaults.standard.string(forKey: "sessionId")
	@Published var currentUser:User? = nil
	@Published var listings:[Listing] = []
	
	// MARK: - Init
	
	init(){
		login()
		getListings()
	}
	
	
	
	// MARK: - User Stuff
	func createUser(firstName:String, lastName:String, email:String, password:String, isApplicant:Bool){
		let requestParam:CreateUserRequest = CreateUserRequest(firstName: firstName, lastName: lastName, email: email, password: password, type: isApplicant)
		
		AF.request(StartupAPI.rootURL + "user/create", method: .post, parameters: requestParam, encoder: URLEncodedFormParameterEncoder(destination: .queryString))
			.validate()
			.responseJSON{ response in
				guard let value = response.value as? [String:Any] else {fatalError("error parsing request result")}
				if let error = value["error"] as? String{
					print("\n\n error: \(error)\n\n")
				}

				if let id = value["sessionId"] as? String {
					self.sessionId = id
					UserDefaults.standard.setValue(id, forKey: "sessionId")
					self.login()
				}
			}
	}
	
	func login(){
		guard let id = sessionId else { return }
		
		AF.request(StartupAPI.rootURL + "user", method: .get, parameters: ["sessionId":id])
			.validate()
			.responseJSON{ response in
				debugPrint(response)
				guard let value = response.value as? [String:Any] else {fatalError("error parsing request result")}
				if let error = value["error"] as? String{
					print("\n\n error: \(error)\n\n")
					
				}
			}
	}
	
	
	// MARK: - Onboarding
	func onboardInfo(){
		
		guard let id = sessionId else { return }
		guard let user = currentUser else { return }
		
		let requestParams = InfoRequest(sessionId:id, location: user.location, greeting: user.greeting, linkedIn: user.linkedIn, github: user.github, tags: user.tags)
			
		
		AF.request(StartupAPI.rootURL + "user/onboard/info", method: .post, parameters: requestParams, encoder: URLEncodedFormParameterEncoder(destination: .queryString))
			.validate()
			.responseJSON{ response in
				guard let value = response.value as? [String:Any] else {fatalError("error parsing request result")}
				if let error = value["error"] as? String{
					print("\n\n error: \(error)\n\n")
					
				}
			}
	}
	
	func onboardEducation(education:Education){
		guard let id = sessionId else { return }
		let requestParams = EduRequest(sessionId: id, education: education)
		
		AF.request(StartupAPI.rootURL + "user/onboard/education", method: .post, parameters: requestParams, encoder: URLEncodedFormParameterEncoder(destination: .queryString))
			.validate()
			.responseJSON{ response in
				guard let value = response.value as? [String:Any] else {fatalError("error parsing request result")}
				if let error = value["error"] as? String{
					print("\n\n error: \(error)\n\n")
					
				}
			}
	}
	
	func onboardExperience(experience: Experience){
		guard let id = sessionId else { return }
		let requestParams = ExpRequest(sessionId: id, experience: experience)
		
		AF.request(StartupAPI.rootURL + "user/onboard/experience", method: .post, parameters: requestParams, encoder: URLEncodedFormParameterEncoder(destination: .queryString))
			.validate()
			.responseJSON{ response in
				guard let value = response.value as? [String:Any] else {fatalError("error parsing request result")}
				if let error = value["error"] as? String{
					print("\n\n error: \(error)\n\n")
					
				}
			}
	}
	
	// MARK: - Reset
	
	func reset(){
		guard let user = currentUser else { return }
		
		let requestParams = ResetRequest(email: user.email)
		
		AF.request(StartupAPI.rootURL + "user/reset", method: .get, parameters: requestParams, encoder: URLEncodedFormParameterEncoder(destination: .queryString))
			.validate()
			.responseJSON{ response in
				guard let value = response.value as? [String:Any] else {fatalError("error parsing request result")}
				if let error = value["error"] as? String{
					print("\n\n error: \(error)\n\n")
				}
				
				if let message = value["msg"] as? String{
					print("\n\n message: \(message)\n\n")
				}
			}
	}
	
	
	// MARK: - Update
	
	func updateInfo(){
		
		guard let id = sessionId else { return }
		guard let user = currentUser else { return }
		
		let requestParams = InfoRequest(sessionId:id, location: user.location, greeting: user.greeting, linkedIn: user.linkedIn, github: user.github, tags: user.tags)
		
		
		AF.request(StartupAPI.rootURL + "user/update/info", method: .put, parameters: requestParams, encoder: URLEncodedFormParameterEncoder(destination: .queryString))
			.validate()
			.responseJSON{ response in
				guard let value = response.value as? [String:Any] else {fatalError("error parsing request result")}
				if let error = value["error"] as? String{
					print("\n\n error: \(error)\n\n")
					
				}
			}
	}
	
	func updateEducation(education:Education){
		guard let id = sessionId else { return }
		let requestParams = EduRequest(sessionId: id, education: education)
		
		AF.request(StartupAPI.rootURL + "user/update/education", method: .put, parameters: requestParams, encoder: URLEncodedFormParameterEncoder(destination: .queryString))
			.validate()
			.responseJSON{ response in
				debugPrint(response)
				guard let value = response.value as? [String:Any] else {fatalError("error parsing request result")}
				if let error = value["error"] as? String{
					print("\n\n error: \(error)\n\n")
					
				}
			}
	}
	
	func updateExperience(experience: Experience){
		guard let id = sessionId else { return }
		let requestParams = ExpRequest(sessionId: id, experience: experience)
		
		AF.request(StartupAPI.rootURL + "user/update/experience", method: .put, parameters: requestParams, encoder: URLEncodedFormParameterEncoder(destination: .queryString))
			.validate()
			.responseJSON{ response in
				debugPrint(response)
				guard let value = response.value as? [String:Any] else {fatalError("error parsing request result")}
				if let error = value["error"] as? String{
					print("\n\n error: \(error)\n\n")
					
				}
			}
	}
	
	// MARK: - Listings
	
	func getListings(name:String? = nil, type:String? = nil, paid:Bool? = nil, sortBy:String? = nil){
		let requestParam = ListingRequest(name: name, type: type, paid: paid, sortBy: sortBy)
		
		AF.request(StartupAPI.rootURL + "listings", method: .get, parameters: requestParam)
			.responseDecodable(of: ListingResult.self){ response in
				guard let value = response.value else { fatalError("\(response.debugDescription)") }
				
				if value.error != nil{
					print("\n\nerror: \(value.error!)\n\n")
					return
				}
				
				for listing in value.listings{
					self.listings.append(Listing(from: listing))
				}
				
				
			}
	}
	
	func createListing(listing:Listing){
		guard let id = sessionId else { return }
		
		let requestParam = CreateListingRequest(id: id, listing: listing)
		
		AF.request(StartupAPI.rootURL + "listings/create", method: .post, parameters: requestParam, encoder: URLEncodedFormParameterEncoder(destination: .queryString))
			.validate()
			.responseJSON{ response in

				guard let value = response.value as? [String:Any] else {fatalError("error parsing request result")}
				if let error = value["error"] as? String{
					print("\n\n error: \(error)\n\n")
				}
			}
	}
	
	func updateListing(listing:Listing){
		guard let id = sessionId else { return }
		
		let requestParam = CreateListingRequest(id: id, listing: listing)
		
		AF.request(StartupAPI.rootURL + "listings/update", method: .put, parameters: requestParam, encoder: URLEncodedFormParameterEncoder(destination: .queryString))
			.validate()
			.responseJSON{ response in
				
				guard let value = response.value as? [String:Any] else {fatalError("error parsing request result")}
				if let error = value["error"] as? String{
					print("\n\n error: \(error)\n\n")
				}
			}
	}
	
	
	// MARK: - Test URL
	
	func testURL(){
		let parameters: [String: [String]] = [
			"foo": ["bar"],
			"baz": ["a", "b"],
			"qux": ["x", "y", "z"]
		]

		
		AF.request(StartupAPI.rootURL + "test",method: .get,parameters: parameters).responseJSON { response in
			debugPrint(response)
		}
		
	}
	
	// MARK: - Structs
		
	struct CreateUserRequest: Encodable{
		let firstName:String
		let lastName:String
		let email:String
		let password:String
		let type:Bool
	}
	
	struct InfoRequest: Encodable{
		let sessionId:String
		let location:String?
		let greeting:String?
		let linkedIn:String?
		let github:String?
		let tags:[String]
	}
	
	struct EduRequest:Codable{
		let sessionId:String
		let college:String
		let start:String
		let end:String?
		let present:Bool?
		let major:String
		let minor:String?
		let gpa:Double
		let tags:[String]
		
		init(sessionId:String, education:Education){
			let df =  DateFormatter()
			df.dateFormat = "yyyy-MM-dd"
			
			self.sessionId = sessionId
			college = education.college
			start = df.string(from: education.start)
			
			if let end = education.end{
				self.end = df.string(from: end)
			}else{
				self.end = nil
			}
			
			present = education.present
			major = education.major
			minor = education.minor
			gpa = education.gpa
			tags = education.tags
			
		}
	}
	
	struct ExpRequest:Codable{
		var sessionId:String
		var name:String
		var start:String?
		var end:String?
		var present:Bool?
		var project:Bool?
		var title:String?
		var description:String
		var tags:[String]
		
		init(sessionId:String, experience:Experience){
			let df =  DateFormatter()
			df.dateFormat = "yyyy-MM-dd"
			
			self.sessionId = sessionId
			name = experience.name
			
			if let start = experience.start{
				self.start = df.string(from: start)
			}else{
				self.start = nil
			}
			
			
			if let end = experience.end{
				self.end = df.string(from: end)
			}else{
				self.end = nil
			}
			
			present = experience.present
			project = experience.project
			title = experience.title
			description = experience.description
			tags = experience.tags
			
		}
	}
	
	struct ResetRequest:Encodable{
		let email:String
	}
	
	struct ListingRequest:Encodable {
		let name:String?
		let type:String?
		let paid:Bool?
		let sortBy:String?
	}
	
	struct ListingResult:Codable{
		let listings:[ListingInfo]
		let error:String?
		
		struct ListingInfo:Codable{
			let createdAt:String
			let description:String
			let name:String
			let objectId:String
			let owner:Owner
			let paid:Bool
			let start:Start
			let tags:[String]
			let location:String
			let title:String
			let type:String
			let updatedAt:String
			
			
			
			struct Owner:Codable{
				let __type:String
				let className:String
				let objectId:String
			}
			
			struct Start:Codable{
				let __type:String
				let iso:String
			}
		}
	}
	
	
	struct CreateListingRequest:Encodable{
		let sessionId:String
		let name:String
		let start:String
		let title:String?
		let location:String?
		let type:String?
		let paid:Bool?
		let description:String?
		let tags:[String]
		
		init(id:String, listing:Listing){
			let df =  DateFormatter()
			df.dateFormat = "yyyy-MM-dd"
			
			sessionId = id
			name = listing.name
			start = df.string(from: listing.start)
			title = listing.title
			location = listing.location
			type = listing.type
			paid = listing.paid
			description = listing.description
			tags = listing.tags
			
		}
	}
}






