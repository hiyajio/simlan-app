//
//  ErrorView.swift
//  Simlan
//
//  Created by Jio Buenviaje on 10/22/20.
//

import SwiftUI

struct ErrorView : View {
    
    @State var color = Color.black.opacity(0.7)
    @Binding var alert : Bool
    @Binding var error : String
    
    var body: some View{
        
        GeometryReader{ geo in
            
            VStack{
                
                HStack{
                    
                    Text(self.error == "RESET" ? "Message" : "Error")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                    
                    Spacer()
                }
                .padding(.horizontal, 25)
                
                Text(self.error == "RESET" ? "Password reset link sent successfully" : self.error)
                    .foregroundColor(self.color)
                    .padding(.top)
                    .padding(.horizontal, 25)
                
                Button(action: {
                    
                    self.alert.toggle()
                    
                }) {
                    
                    Text(self.error == "RESET" ? "Ok" : "Cancel")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 120)
                }
                .background(Color("Color"))
                .cornerRadius(10)
                .padding(.top, 25)
                
            }
            .padding(.vertical, 25)
            .frame(width: UIScreen.main.bounds.width - 70)
            .background(Color.white)
            .cornerRadius(15)
            .frame(width: geo.size.width,
                   height: geo.size.height,
                   alignment: .center)
        }
        .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
    }
}

#if DEBUG
struct ErrorView_Previews: PreviewProvider {
    @State static var error = "Kindly verify email to be able to log in"
    @State static var alert = false
    
    static var previews: some View {
        ErrorView(alert: $alert, error: $error)
    }
}
#endif
