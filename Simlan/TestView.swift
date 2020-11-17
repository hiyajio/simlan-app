//
//  TestView.swift
//  Simlan
//
//  Created by Zachary Sy on 11/10/20.
//

import SwiftUI
import FirebaseAuth

struct TestView: View {
    @ObservedObject var viewRouter: ViewRouter
        
        var body: some View{
            
            VStack{
                
                Text("Logged successfully")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black.opacity(0.7))
                
                Button(action: {
                    
                    try! Auth.auth().signOut()
                    self.viewRouter.currentView = "login"
                    UserDefaults.standard.set(false, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                    
                }) {
                    
                    Text("Log out")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                }
                .background(Color("Color"))
                .cornerRadius(10)
                .padding(.top, 25)
            }
        }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(viewRouter: ViewRouter())
    }
}
