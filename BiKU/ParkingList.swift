//
//  ParkingList.swift
//  BiKU
//
//  Created by 中島悠奎 on 2022/05/24.
//

import Foundation
import SwiftUI
 
struct ParkingList: View {
    var body: some View {
        List(parkingData) { parking in
                    ParkingRow(parking: parking)
        }
    }
}
 
struct ParkingList_Previews: PreviewProvider {
    static var previews: some View {
        ParkingList()
    }
}
