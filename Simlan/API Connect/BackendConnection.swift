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
	@Published var currentUser:User? = User()
	
	// MARK: - Init
	
	init(){
	}
	
	
	
	// MARK: - Create and Login
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
}






