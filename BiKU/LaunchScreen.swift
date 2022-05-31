//
//  LaunchScreen.swift
//  BiKU
//
//  Created by 中島悠奎 on 2022/05/24.
//

import Foundation
import SwiftUI

struct LaunchScreen: View {
    @State private var isLoading = true

    var body: some View {
        if isLoading {
            ZStack {
                Color(red: 187.0/255, green: 214/255, blue: 21/255)
                    .ignoresSafeArea() // ステータスバーまで塗り潰すために必要
                VStack{
                Text("BiKU")
                    .font(Font.system(size: 100, weight: .black))
                Image(systemName : "bicycle.circle")
                    .font(Font.system(size: 200, weight: .black))
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.linear(duration: 0.3)) {
                        isLoading = false
                    }
                }
            }
        } else {
            //print(isLoading)
            LoginView()
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
