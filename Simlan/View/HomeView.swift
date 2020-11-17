//
//  HomeView.swift
//  Simlan
//
//  Created by Jio Buenviaje on 10/22/20.
//

import SwiftUI
import FirebaseAuth

struct HomeView : View {
    
    @ObservedObject var viewRouter: ViewRouter
    
    @StateObject var api = StartupAPI.shared // Make this an environment object
    
    @State var index = 0
    
    var body: some View{
        
        if let user = api.currentUser{
            
            HStack(spacing: 15){
                              
                              Button(action: {
                                  
                              }) {
                                  
                                  Image(systemName: "chevron.left")
                                      .font(.system(size: 22))
                                      .foregroundColor(.black)
                              }
                              
                              Text("Listings")
                                  .font(.title)
                              
                              Spacer(minLength: 0)
                              
                              Button(action: {
                                
                                api.logout()
                                                self.viewRouter.currentView = "login"
                                                UserDefaults.standard.set(false, forKey: "status")
                                                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                                  
                              }) {
                                  
                                  Text("Logout")
                                      .foregroundColor(.white)
                                      .padding(.vertical, 10)
                                      .padding(.horizontal, 25)
                                      .background(Color("Color"))
                                      .cornerRadius(10)
                              }
                          }
                          .padding()
                
                VStack{
                    
                    HStack{
                        
                        VStack(spacing: 0){
                            
                            Image("profile")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .background(Color("Color1"))
                            .clipShape(Circle())
                        }
                        Spacer()
                        VStack(alignment: .leading, spacing: 12){
                            
                            Text("John Stewart")
                                .font(.title)
                                .foregroundColor(Color.black.opacity(0.8))
                            
                            Text("john.stewart@gmail.com")
                                .foregroundColor(Color.black.opacity(0.7))
                        }
                        .padding(.leading, 20)
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    // Tab Items...
                    
                    HStack{
                        
                        Button(action: {
                            
                            self.index = 0
                            
                        }) {
                            
                            Text("Experience")
                                .foregroundColor(self.index == 0 ? Color.white : .gray)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(self.index == 0 ? Color("Color") : Color.clear)
                                .cornerRadius(10)
                        }
                        
                        Spacer(minLength: 0)
                        
                        Button(action: {
                            
                            self.index = 1
                            
                        }) {
                            
                            Text("Education")
                                .foregroundColor(self.index == 1 ? Color.white : .gray)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(self.index == 1 ? Color("Color") : Color.clear)
                                .cornerRadius(10)
                        }
                        
                        Spacer(minLength: 0)
                        
                        Button(action: {
                            
                            self.index = 2
                            
                        }) {
                            
                            Text("Applied")
                                .foregroundColor(self.index == 2 ? Color.white : .gray)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(self.index == 2 ? Color("Color") : Color.clear)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal,8)
                    .padding(.vertical,5)
                    .background(Color("Color1"))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding(.top,25)
                    
                    // Cards...
                    
                    TabView(selection: self.$index){

                        ExperienceView().tag(0)
                        
                        EducationView().tag(1)
                        
                        AppliedView().tag(2)
                                }
                                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    
                }
                .background(Color("Color1").edgesIgnoringSafeArea(.all))
            }
    }
}

// Experience View....

struct ExperienceView : View {
    
    var body: some View{
        
        VStack(){
        
        HStack(spacing: 20){
            
            VStack(spacing: 12){
                
                Image("airbnb")
                .resizable()
                .frame(width: 80, height: 80)
                
                Text("Airbnb")
                    .font(.title)
                    .padding(.top,10)
                
                Text("Web Engineer")
                    .foregroundColor(Color("Color"))
                
                Text("1 Year")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical)
            // half screen - spacing - two side paddings = 60
            .frame(width: (UIScreen.main.bounds.width - 60) / 2)
            .background(Color("Color1"))
            .cornerRadius(15)
            // shadows...
            
            VStack(spacing: 12){
                
                Image("apple")
                .resizable()
                .frame(width: 80, height: 80)
                
                Text("Apple")
                    .font(.title)
                    .padding(.top,10)
                
                Text("iOS Engineer")
                    .foregroundColor(Color("Color"))
                
                Text("2 Years")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical)
            // half screen - spacing - two side paddings = 60
            .frame(width: (UIScreen.main.bounds.width - 60) / 2)
            .background(Color("Color1"))
            .cornerRadius(15)
            // shadows...
            
        }
        .padding(.top,20)
        
        HStack(spacing: 20){
            
            VStack(spacing: 12){
                
                Image("paypal")
                .resizable()
                .frame(width: 80, height: 80)
                
                Text("Paypal")
                    .font(.title)
                    .padding(.top,10)
                
                Text("Software Engineer")
                    .foregroundColor(Color("Color"))
                
                Text("3 Years")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical)
            // half screen - spacing - two side paddings = 60
            .frame(width: (UIScreen.main.bounds.width - 60) / 2)
            .background(Color("Color1"))
            .cornerRadius(15)
            // shadows...
            
            VStack(spacing: 12){
                
                Image("bing")
                .resizable()
                .frame(width: 80, height: 80)
                
                Text("Bing")
                    .font(.title)
                    .padding(.top,10)
                
                Text("Web Developer")
                    .foregroundColor(Color("Color"))
                
                Text("1 Year")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical)
            // half screen - spacing - two side paddings = 60
            .frame(width: (UIScreen.main.bounds.width - 60) / 2)
            .background(Color("Color1"))
            .cornerRadius(15)
            // shadows...
            
        }
        .padding(.top,20)
        
        Spacer(minLength: 0)
        }
    }
}

// Education View....

struct EducationView : View {
    
    var body: some View{
        
        VStack(){
        
        HStack(spacing: 20){
            
            VStack(alignment: .leading, spacing: 12){
                
                Image("stanford")
                .resizable()
                .frame(width: 80, height: 80)
                
                Text("MS Computer Science")
                    .padding(.top,10)
                
                Text("Stanford University")
                    .foregroundColor(Color("Color"))
                
                Text("2019")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical)
            // half screen - spacing - two side paddings = 60
            .frame(width: (UIScreen.main.bounds.width - 60) / 2)
            .background(Color("Color1"))
            .cornerRadius(15)
            // shadows...
            
            VStack(alignment: .leading, spacing: 12){
                
                Image("harvard")
                .resizable()
                .frame(width: 80, height: 80)
                
                Text("Master of Business Administration")
                    .padding(.top,10)
                
                Text("Harvard University")
                    .foregroundColor(Color("Color"))
                
                Text("2017")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical)
            // half screen - spacing - two side paddings = 60
            .frame(width: (UIScreen.main.bounds.width - 60) / 2)
            .background(Color("Color1"))
            .cornerRadius(15)
            // shadows...
            
        }
        .padding(.top,20)
        
        HStack(spacing: 20){
            
            VStack(alignment: .leading, spacing: 12){
                
                Image("nyu")
                .resizable()
                .frame(width: 80, height: 80)
                
                Text("BS Computer Science")
                    .padding(.top,10)
                
                Text("New York University")
                    .foregroundColor(Color("Color"))
                
                Text("2015")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical)
            // half screen - spacing - two side paddings = 60
            .frame(width: (UIScreen.main.bounds.width - 60) / 2)
            .background(Color("Color1"))
            .cornerRadius(15)
            // shadows...
            
        }
        .padding(.top,20)
        
        Spacer(minLength: 0)
        }
    }
}

// Applied View....

struct AppliedView : View {
    
    var body: some View{
        
        VStack() {
            
        HStack(spacing: 20){
            
            VStack(spacing: 12){
                
                Image("ebay")
                .resizable()
                .frame(width: 80, height: 80)
                
                Text("Ebay")
                    .font(.title)
                    .padding(.top,10)
                
                Text("Backend Developer")
                    .foregroundColor(Color("Color"))
                
                Text("3 Days Ago")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical)
            // half screen - spacing - two side paddings = 60
            .frame(width: (UIScreen.main.bounds.width - 60) / 2)
            .background(Color("Color1"))
            .cornerRadius(15)
            // shadows...
            
            VStack(spacing: 12){
                
                Image("adobe")
                .resizable()
                .frame(width: 80, height: 80)
                
                Text("Adobe")
                    .font(.title)
                    .padding(.top,10)
                
                Text("Fullstack Developer")
                    .foregroundColor(Color("Color"))
                
                Text("4 Days Ago")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical)
            // half screen - spacing - two side paddings = 60
            .frame(width: (UIScreen.main.bounds.width - 60) / 2)
            .background(Color("Color1"))
            .cornerRadius(15)
            // shadows...
            
        }
        .padding(.top,20)
        
        HStack(spacing: 20){
            
            VStack(spacing: 12){
                
                Image("android")
                .resizable()
                .frame(width: 80, height: 80)
                
                Text("Android")
                    .font(.title)
                    .padding(.top,10)
                
                Text("Software Engineer")
                    .foregroundColor(Color("Color"))
                
                Text("1 Week Ago")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical)
            // half screen - spacing - two side paddings = 60
            .frame(width: (UIScreen.main.bounds.width - 60) / 2)
            .background(Color("Color1"))
            .cornerRadius(15)
            // shadows...
            
            VStack(spacing: 12){
                
                Image("amd")
                .resizable()
                .frame(width: 80, height: 80)
                
                Text("AMD")
                    .font(.title)
                    .padding(.top,10)
                
                Text("Hardware Engineer")
                    .foregroundColor(Color("Color"))
                
                Text("2 Weeks Ago")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical)
            // half screen - spacing - two side paddings = 60
            .frame(width: (UIScreen.main.bounds.width - 60) / 2)
            .background(Color("Color1"))
            .cornerRadius(15)
            // shadows...
            
        }
        .padding(.top,20)
        
        Spacer(minLength: 0)
        }
    }
}


#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewRouter: ViewRouter())
    }
}
#endif
