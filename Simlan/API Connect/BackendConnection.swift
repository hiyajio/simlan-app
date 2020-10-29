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

	// MARK: - Init
	
	init(){
	}
	
	
	
	// MARK: - Functions
	
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
	
	
}



