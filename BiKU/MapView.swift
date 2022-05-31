//
//  MapView.swift
//  BiKU
//
//  Created by 中島悠奎 on 2022/05/24.
//

import Foundation
import SwiftUI
import UIKit
import MapKit
import CoreLocation

struct MapView: UIViewRepresentable {
    //@IBOutlet weak var mapView: MKMapView!
    var latitude : Double
    var longitude : Double
    var place : String
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(
            latitude: 35.02705, longitude: 135.7815)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
        
        
        //let pin = MKPointAnnotation()
        //pin.title = "parking"
        //pin.coordinate = coordinate
        //mapView.addAnnotation(pin)
        //ピンを生成
         let myPin = MKPointAnnotation()

         //ピンの座標設定
         myPin.coordinate = CLLocationCoordinate2D(
            latitude: latitude, longitude: longitude)

         //タイトル、サブタイトルを設定
         myPin.title = place

         //mapViewにピンを追加
        if(place != "null"){
            uiView.addAnnotation(myPin)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(latitude: 35.02705, longitude: 135.7815, place: "京大の真ん中")
    }
}
