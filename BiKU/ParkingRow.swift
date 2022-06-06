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
    
    @Binding var parking_id: Optional<Int>
    
    var body: some View {
        HStack {
            Text(parking.name)
            Spacer()
            Text(String(parking.amount))
            if parking.id == self.parking_id {
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
            ParkingRow(parking: parkingData[0], parking_id: .constant(1002))
            ParkingRow(parking: parkingData[1], parking_id: .constant(1002))
            ParkingRow(parking: parkingData[2], parking_id: .constant(1002))
        }
        .previewLayout(.fixed(width: 400, height: 70))
    }
}
