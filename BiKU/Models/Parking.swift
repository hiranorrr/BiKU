//
//  Parking.swift
//  BiKU
//
//  Created by 中島悠奎 on 2022/05/24.
//

import Foundation
import SwiftUI
import CoreLocation

struct Parking: Hashable, Codable, Identifiable{
    var id: Int
    var name: String
    fileprivate var coordinates: Coordinates
    var isFavorite: Bool
    
    var locationCoordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(
                latitude: coordinates.latitude,
                longitude: coordinates.longitude)
    }
}

struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}
