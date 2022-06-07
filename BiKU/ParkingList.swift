//
//  ParkingList.swift
//  BiKU
//
//  Created by 中島悠奎 on 2022/05/24.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth
 
struct ParkingList: View {
    var parking: Parking
    @Binding var parkings: [Parking]
    @Binding var parking_id: Optional<Int>
    
    var body: some View {
        VStack {
            Text(parking.name).bold().underline().font(.largeTitle)
            MapView(latitude: parking.coordinates.latitude, longitude: parking.coordinates.longitude, place: parking.name)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 300).padding(.vertical)
            // DB処理　駐輪台数を取得してほしい
            Text("\(parking.amount) bikes").bold().font(.title)
            Spacer()
            
            //　DB処理　新しい駐輪台数を書き込む
            if (parking_id != nil) && parking_id == parking.id {
                Button(action: {
                    depart()
                }){
                    Text("Depart").font(.largeTitle).foregroundColor(Color.white).padding(.horizontal).background(Color.blue)
                }
            } else {
                Button(action: {
                    park()
                }){
                    Text("Park").font(.largeTitle).foregroundColor(Color.white).padding(.horizontal).background(Color.blue)
                }
            }
            Spacer()
        }
    }
    
    func park() {
        let db = Firestore.firestore()
        if let currentUser = Auth.auth().currentUser {
            db.collection("users").document(currentUser.uid).setData([
                "parking_id": parking.id
            ]) { err in
                if let err = err {
                    // FIXME: エラーハンドリング
                    print("Error adding document: \(err)")
                } else {
                    print("Document added")
                }
            }

            let newParking = Parking(
                id: parking.id,
                name: parking.name,
                amount: parking.amount + 1,
                coordinates: parking.coordinates,
                isParking: parking.isParking
            )

            db.collection("parking_lots").document(String(newParking.id)).setData([
                "amount": newParking.amount,
                "name": newParking.name,
                "coordinates": [
                    "latitude": newParking.coordinates.latitude,
                    "longitude": newParking.coordinates.latitude
                ]
            ]) { err in
                if let err = err {
                    // FIXME: エラーハンドリング
                    print("Error adding document: \(err)")
                } else {
                    print("Document added")
                }
            }
            
            let newParkings = parkings.map { p -> Parking in
                if (p.id == parking.id) {
                    return newParking
                } else {
                    return p
                }
            }
            
            self.parkings = newParkings
            
            self.parking_id = newParking.id
        }
    }
    
    func depart() {
        let db = Firestore.firestore()
        if let currentUser = Auth.auth().currentUser {
            db.collection("users").document(currentUser.uid).setData([
                "parking_id": 10000000
            ]) { err in
                if let err = err {
                    // FIXME: エラーハンドリング
                    print("Error adding document: \(err)")
                } else {
                    print("Document added")
                }
            }

            let newParking = Parking(
                id: parking.id,
                name: parking.name,
                amount: parking.amount - 1,
                coordinates: parking.coordinates,
                isParking: parking.isParking
            )

            db.collection("parking_lots").document(String(newParking.id)).setData([
                "amount": newParking.amount,
                "name": newParking.name,
                "coordinates": [
                    "latitude": newParking.coordinates.latitude,
                    "longitude": newParking.coordinates.latitude
                ]
            ]) { err in
                if let err = err {
                    // FIXME: エラーハンドリング
                    print("Error adding document: \(err)")
                } else {
                    print("Document added")
                }
            }
            
            let newParkings = parkings.map { p -> Parking in
                if (p.id == parking.id) {
                    return newParking
                } else {
                    return p
                }
            }
            
            self.parkings = newParkings
            
            self.parking_id = 1000000
        }
    }
}
 
struct ParkingList_Previews: PreviewProvider {
    static var previews: some View {
        ParkingList(parking: parkingData[0], parkings: .constant(parkingData), parking_id: .constant(1001))
    }
}

