
import SwiftUI
import MapKit

struct MapItem: Identifiable {
    var id = UUID().uuidString
    var coordinate = CLLocationCoordinate2D()
    var color = Color.red
}
