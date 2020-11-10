//
//  TestView.swift
//  Simlan
//
//  Created by Zachary Sy on 11/10/20.
//

import SwiftUI

struct TestView: View {
	@StateObject var api = StartupAPI.shared // Make this an environment object
	
    var body: some View {
		if let user = api.currentUser{
			Text(user.email)
			Button("logout"){
				api.logout()
			}
		}else{
			Text("logged out")
			Button("login"){
				api.login(email: "testing3@yahoo.com", pw:"password")
			}
		}
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
