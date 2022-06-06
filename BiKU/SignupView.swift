//
//  SignupView.swift
//  BiKU
//
//  Created by 中島悠奎 on 2022/05/26.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignupView: View {
    @State var inputEmail: String = ""
    @State var inputPassword: String = ""
    @State public var errorMessage:String = ""
    @State private var isLogin = true

    var body: some View {
        if (isLogin) {
            NavigationView {
                VStack(alignment: .center) {
                                Spacer()
                                Image(systemName : "bicycle.circle")
                                    .font(Font.system(size: 70, weight: .black))
                                Text("Sign up")
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
                    
                            // DB処理 サインアップ
                            Button(action:{
                                if(self.inputEmail == ""){
                                    self.errorMessage = "メールアドレスが入力されていません"
                                } else if(self.inputPassword == ""){
                                    self.errorMessage = "パスワードが入力されていません"
                                } else {
                                    Auth.auth().createUser(withEmail: self.inputEmail, password: self.inputPassword) { authResult, error in
                                        print(authResult)
                                        
                                        if (authResult?.user != nil) {
                                            let uid: String = authResult?.user.uid ?? ""
                                            addUser(id: uid)
                                        }
                                    }
                                }
                            },
                            label: {
                                Text("Sign up")
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

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

func addUser(id: String) {
    let db = Firestore.firestore()

    db.collection("users").document(id).setData([
        "name": "Sakamoto2"
    ]) { err in
        if let err = err {
            // FIXME: エラーハンドリング
            print("Error adding document: \(err)")
        } else {
            print("Document added")
        }
    }
}
