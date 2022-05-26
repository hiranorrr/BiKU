//
//  ContentView.swift
//  BiKU
//
//  Created by 平野瑠登 on 2022/05/17.
//

import SwiftUI
import UIKit

struct LoginView: View {
    @State var inputEmail: String = ""
    @State var inputPassword: String = ""
    @State private var isLogin = true
    @State private var isSignup = true

    var body: some View {
        if (isLogin && isSignup) {
            NavigationView {
                VStack(alignment: .center) {
                    //Spacer()
                    Image(systemName : "bicycle.circle")
                        .font(Font.system(size: 70, weight: .black))
                    Text("Login")
                        .font(.system(size: 48,weight: .heavy))
                    Text("Please enter your mail address and password.")
                        .font(.system(size:16))

                    VStack(spacing: 24) {
                        TextField("Mail address", text: $inputEmail)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: 280)

                    SecureField("Password", text: $inputPassword)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: 280)
                    }
                    .frame(height: 140)
                    
                    Button(action: {
                        print("Login処理")
                        isLogin = false
                        
                    },label: {
                        Text("Login")
                            .fontWeight(.medium)
                            .frame(minWidth: 160)
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.accentColor)
                            .cornerRadius(8)
                    })
                    Button(action: {
                        print("Signup処理")
                        isSignup = false
                    }){
                        Text("Sign up")
                            .fontWeight(.medium)
                    }
                }
            }
        } else if (isLogin && !isSignup) {
            SignupView()
        }else {
            ParkingDetail()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
