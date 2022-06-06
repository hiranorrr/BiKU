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
import FirebaseFirestore

struct ParkingDetail: View {
    @State var parkings: [Parking] = []
    var body: some View {
        NavigationView{
            VStack{
                MapView(latitude: 0, longitude: 0, place: "null").edgesIgnoringSafeArea(.top).frame(height: 300).padding(.vertical)
                
                
                List(self.parkings) { parking in
                    NavigationLink(
                        destination:ParkingList(parking: parking, parkings: $parkings)
                    ){
                        ParkingRow(parking: parking)
                    }
                }
    
            }.navigationBarTitle(Text("Kyoto Unversity Map"))
        }.onAppear {
            self.getParkingLots()
        }
    }

    func getParkingLots() -> Void {
        let db = Firestore.firestore()
        var parkings: [Parking] = []

        print("in getParkingLots")
        db.collection("parking_lots").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
    //                print("\(document.documentID) => \(document.data())")
                    parkings.append(
                        Parking(
                            id: Int(document.documentID)!,
                            name: document.data()["name"] as! String,
                            amount: document.data()["amount"] as! Int,
                            coordinates: Coordinates(
                                latitude: (document.data()["coordinates"] as! NSDictionary)["latitude"] as! Double,
                                longitude: (document.data()["coordinates"] as! NSDictionary)["longitude"] as! Double
                            ),
                            isParking: false
                        )
                    )
                }

                print(parkings)
                self.parkings = parkings
            }
        }
    }
}

struct ParkingView_Previews: PreviewProvider {
    static var previews: some View {
        ParkingDetail()
    }
}
