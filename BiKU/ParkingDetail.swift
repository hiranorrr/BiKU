//
//  ParkingDetail.swift
//  BiKU
//
//  Created by 中島悠奎 on 2022/05/24.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation

struct ParkingDetail: View {
    var body: some View {
        VStack{
            VStack(alignment: .leading) {
                Text("parking lot 1").bold().underline().font(.largeTitle)
                MapView().edgesIgnoringSafeArea(.top).frame(height: 300).padding()
            }
//            List(parkingData) { parking in
//                        ParkingRow(parking: parking)
//            }
            Text("12 bikes").bold().font(.title)
            Spacer()
            //TODO:actionにデータベースの値更新処理を書く
            Button(action: {}){
                Text("Park").font(.largeTitle).foregroundColor(Color.white).padding(.horizontal).background(Color.blue)
            }
            Spacer()
        }
    }
}

struct ParkingView_Previews: PreviewProvider {
    static var previews: some View {
        ParkingDetail()
    }
}
