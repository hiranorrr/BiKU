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
        NavigationView{
            VStack{
                MapView(latitude: 0, longitude: 0, place: "null").edgesIgnoringSafeArea(.top).frame(height: 300).padding(.vertical)
                
                
                    List(parkingData) { parking in
                                NavigationLink(
                                    destination:ParkingList(parking: parking)
                                ){
                                ParkingRow(parking: parking)
                                }
                    }
    
            }.navigationBarTitle(Text("Kyoto Unversity Map"))
        }
    }
}

struct ParkingView_Previews: PreviewProvider {
    static var previews: some View {
        ParkingDetail()
    }
}
