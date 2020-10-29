//
//  SignupView.swift
//  Simlan
//
//  Created by Jio Buenviaje on 10/22/20.
//

import SwiftUI
import FirebaseAuth

struct SignupView : View {
    
    @ObservedObject var viewRouter: ViewRouter
    
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var pass = ""
    @State var repass = ""
    @State var visible = false
    @State var revisible = false
    @State var alert = false
    @State var error = ""
    
    var body: some View{
        
        ZStack{
            
            ZStack(alignment: .topLeading) {
                
                GeometryReader{ geo in
                    
                    VStack{
                        
                        Image("logo")
                        
                        Text("Make your account")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                            .padding(.top, 35)
                        
                        TextField("Email", text: self.$email)
                            .autocapitalization(.none)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color,lineWidth: 2))
                            .padding(.top, 25)
                        
                        HStack(spacing: 15){
                            
                            VStack{
                                
                                if self.visible{
                                    
                                    TextField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                }
                                else{
                                    
                                    SecureField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                }
                            }
                            
                            Button(action: {
                                
                                self.visible.toggle()
                                
                            }) {
                                
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                            
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color("Color") : self.color,lineWidth: 2))
                        .padding(.top, 25)
                        
                        HStack(spacing: 15){
                            
                            VStack{
                                
                                if self.revisible{
                                    
                                    TextField("Re-enter", text: self.$repass)
                                        .autocapitalization(.none)
                                }
                                else{
                                    
                                    SecureField("Re-enter", text: self.$repass)
                                        .autocapitalization(.none)
                                }
                            }
                            
                            Button(action: {
                                
                                self.revisible.toggle()
                                
                            }) {
                                
                                Image(systemName: self.revisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                            
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.repass != "" ? Color("Color") : self.color,lineWidth: 2))
                        .padding(.top, 25)
                        
                        Button(action: {
                            
                            self.register()
                        }) {
                            
                            Text("Register")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("Color"))
                        .cornerRadius(10)
                        .padding(.top, 25)
                        
                        Button(action: {
                            self.viewRouter.currentView = "login"
                        }) {
                            HStack {
                                Text("Have an account already?").foregroundColor(self.color)
                                Text("Log In")
                                    .fontWeight(.bold).foregroundColor(Color("Color"))
                            }
                            .padding(.top, 8)
                        }
                        .padding()
                        
                    }
                    .padding(.horizontal, 25).offset(y: -50)
                }
            }
            
            if self.alert{
                
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func register(){
        
        if self.email != ""{
            
            if self.pass == self.repass{
                
                Auth.auth().createUser(withEmail: self.email, password: self.pass) { (res, err) in
                    
                    if err != nil{
                        
                        self.error = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    
                    print("success")
                    self.viewRouter.currentView = "home"
                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                }
            }
            else{
                
                self.error = "Passwords do not match"
                self.alert.toggle()
            }
        }
        else{
            
            self.error = "Please fill all the info properly"
            self.alert.toggle()
        }
    }
}

#if DEBUG
struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(viewRouter: ViewRouter())
    }
}
#endif
