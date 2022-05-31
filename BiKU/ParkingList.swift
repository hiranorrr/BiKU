//
//  ParkingList.swift
//  BiKU
//
//  Created by 中島悠奎 on 2022/05/24.
//

import Foundation
import SwiftUI
 
struct ParkingList: View {
    var parking: Parking
    var body: some View {
        VStack {
            Text(parking.name).bold().underline().font(.largeTitle)
            MapView()
                .edgesIgnoringSafeArea(.top)
                .frame(height: 300).padding()
            
            // DB処理　駐輪台数を取得してほしい
            Text("12 bikes").bold().font(.title)
            Spacer()
            
            //　DB処理　新しい駐輪台数を書き込む
            Button(action: {}){
                Text("Park").font(.largeTitle).foregroundColor(Color.white).padding(.horizontal).background(Color.blue)
            }
            Spacer()
        }
    }
    
    
}
 
struct ParkingList_Previews: PreviewProvider {
    static var previews: some View {
        ParkingList(parking: parkingData[0])
    }
}
