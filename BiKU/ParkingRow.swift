//
//  ParkingRow.swift
//  BiKU
//
//  Created by 中島悠奎 on 2022/05/24.
//

import Foundation
import SwiftUI
 
struct ParkingRow: View {
    var parking: Parking
    
    var body: some View {
        HStack {
            Text(parking.name)
            Spacer()
            if parking.isFavorite {
                Image(systemName: "bicycle.circle.fill")
                    .imageScale(.medium)
                    .foregroundColor(.blue)
            }
        }
    }
}
 
struct ParkingkRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ParkingRow(parking: parkingData[0])
            ParkingRow(parking: parkingData[1])
            ParkingRow(parking: parkingData[2])
        }
        .previewLayout(.fixed(width: 400, height: 70))
    }
}
