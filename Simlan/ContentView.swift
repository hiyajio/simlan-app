//
//  ContentView.swift
//  Simlan
//
//  Created by Jio Buenviaje on 10/22/20.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var show = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View{
            
            VStack{
                if self.viewRouter.currentView == "home" {
                    HomeView(viewRouter: self.viewRouter)
                } else if self.viewRouter.currentView == "test" {
                    TestView(viewRouter: self.viewRouter)
                }
                if self.viewRouter.currentView == "login" {
                    LoginView(viewRouter: self.viewRouter)
                }
                else if self.viewRouter.currentView == "signup"{
                    SignupView(viewRouter: self.viewRouter).offset(y: 65)
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) { (_) in
                    
                    self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                }
            }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
