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
                Text("Kyoto Univercity Map")
                MapView().edgesIgnoringSafeArea(.top).frame(height: 300)
            }
            List(parkingData) { parking in
                        ParkingRow(parking: parking)
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
