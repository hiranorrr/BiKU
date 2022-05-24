//
//  ContentView.swift
//  BiKU
//
//  Created by 平野瑠登 on 2022/05/17.
//

import SwiftUI

struct LoginView: View {
    @State var inputEmail: String = ""
    @State var inputPassword: String = ""
    @State private var isLogin = true

    var body: some View {
        if (isLogin) {
            NavigationView {
                VStack(alignment: .center) {
                                Spacer()
                                Image(systemName : "bicycle.circle")
                                    .font(Font.system(size: 70, weight: .black))
                                Text("Login")
                                    .font(.system(size: 48,
                                                  weight: .heavy))
                                Text("")
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
                                .frame(height: 160)
                    
                            Button(action: {
                                print("Login処理")
                                isLogin = false
                            },
                            label: {
                                Text("Login")
                                    .fontWeight(.medium)
                                    .frame(minWidth: 160)
                                    .foregroundColor(.white)
                                    .padding(12)
                                    .background(Color.accentColor)
                                    .cornerRadius(8)
                            })
                    Spacer()
                }
            }
        } else {
            ParkingDetail()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
