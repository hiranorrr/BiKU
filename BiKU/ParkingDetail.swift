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
import FirebaseAuth

struct ParkingDetail: View {
    @State var parkings: [Parking] = []
    @State var parking_id: Optional<Int> = nil
    var body: some View {
        NavigationView{
            VStack{
                MapView(latitude: 0, longitude: 0, place: "null").edgesIgnoringSafeArea(.top).frame(height: 300).padding(.vertical)
                
                
                List(self.parkings) { parking in
                    NavigationLink(
                        destination:ParkingList(parking: parking, parkings: $parkings, parking_id: $parking_id)
                    ){
                        ParkingRow(parking: parking, parking_id: $parking_id)
                    }
                }
    
            }.navigationBarTitle(Text("Kyoto Unversity Map"))
        }.onAppear {
            self.getParkingLots()
            self.getParkingId()
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
    
    func getParkingId() {
        let db = Firestore.firestore()
        if let currentUser = Auth.auth().currentUser {
            db.collection("users").document(currentUser.uid).getDocument { snapshot, err in
                if let err = err {
                    // FIXME: エラーハンドリング
                    print("Error adding document: \(err)")
                } else {
                    print("Document added")
                    print(snapshot!.data() ?? "")
                    self.parking_id = snapshot!.data()?["parking_id"] as? Int
                }
            }
        }
    }
}

struct ParkingView_Previews: PreviewProvider {
    static var previews: some View {
        ParkingDetail()
    }
}
