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
                    Text("BiKU")
                        .font(.system(size: 48,
                                      weight: .heavy))

                    VStack(spacing: 24) {
                        TextField("Mail address", text: $inputEmail)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: 280)

                        SecureField("Password", text: $inputPassword)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: 280)

                    }
                    .frame(height: 200)
                    
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
