//
//  ContentView.swift
//  BiKU
//
//  Created by 平野瑠登 on 2022/05/17.
//

import SwiftUI
import FirebaseAuth
//import UIKit

struct LoginView: View {
    @State var inputEmail: String = ""
    @State var inputPassword: String = ""
    @State var errorMessage: String = ""
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
                        if(self.inputEmail == ""){
                            self.errorMessage = "メールアドレスが入力されていません"
                            print(self.errorMessage)
                        }else if(self.inputPassword == ""){
                            self.errorMessage = "パスワードが入力されていません"
                            print(self.errorMessage)
                        }else{
                            Auth.auth().signIn(withEmail: inputEmail, password: inputPassword) { authResult, error in
                                if authResult?.user != nil {
                                    // ログイン成功処理
                                    print("success")
                                } else {
                                    // ログイン失敗処理
                                    if let error = error as NSError?, let errorCode = AuthErrorCode.Code(rawValue: error._code) {
                                        switch errorCode {
                                        case .invalidEmail:
                                            self.errorMessage = "メールアドレスの形式が正しくありません"
                                        case .userNotFound, .wrongPassword:
                                            self.errorMessage = "メールアドレス、またはパスワードが間違っています"
                                        case .userDisabled:
                                            self.errorMessage = "このユーザーアカウントは無効化されています"
                                        default:
                                            self.errorMessage = error.domain
                                        }
                                    }
                                    print(self.errorMessage)
                                }
                            }
                        }
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
