
import SwiftUI
import MapKit
import Combine


final class MapViewModel: NSObject, ObservableObject {
    
    private let manager = CLLocationManager()
    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    // 初期表示の座標.
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 35.681236,
            longitude: 139.767125
        ),
        latitudinalMeters: 10_000,
        longitudinalMeters: 10_000
    )
    @Published var location = CLLocation()
    var locationManager: CLLocationManager!
    var my_latitude: CLLocationDegrees!
    var my_longitude: CLLocationDegrees!
    @IBOutlet weak var mpsTextField: UITextField!
    @IBOutlet weak var kphTextField: UITextField!
    @Published var trackingMode: MapUserTrackingMode = .follow
    
    @Published var items: [MapItem] = []

    private var cancellable = Set<AnyCancellable>()
  //  @Published var A = [Double]()
  //  @Published var B = [Double]()
    
    override init() {
        
        super.init()
        manager.delegate = self
       // locationManager.allowsBackgroundLocationUpdates = true
        $region
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] region in
                
                let annotation = MapItem(coordinate: region.center, color: .blue)
                self?.items.append(annotation)
                let coordinate = CLLocationCoordinate2DMake(annotation.coordinate.latitude, annotation.coordinate.longitude)
                let placemark = MKPlacemark(coordinate:coordinate, addressDictionary:nil)
                let mapItem = MKMapItem(placemark: placemark)
                print(mapItem)// func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
                    //アノテーションの緯度と経度を取得
                 //   self.destLocation = CLLocationCoordinate2D(latitude: annotation!.coordinate.latitude,longitude: annotation!.coordinate.longitude)
                     
                    // 現在地の取得を開始
                    //self.locationManager.startUpdatingLocation()
                     
                    // 現在地から目的地への経路を検索
                    //getRoute()
                     
                //}
               // print(annotation.first)
                //var lineLocation:[CLLocationCoordinate2D] = [CLLocationCoordinate2D(latitude: annotation.coordinate.latitude, longitude: /annotation.coordinate.longitude),
                     //                                        CLLocationCoordinate2D(latitude: region.center.coordinate.latitude, longitude: region.center.coordinate.longitude)]
                
                
                //位置アップデート
                //locationManager = CLLocationManager()
                //locationManager.delegate = self
                //let location = CLLocationManager().first
                //my_latitude = locationManager.location?.coordinate.latitude
                //my_latitude = locationManager.location?.coordinate.latitude
                
             
                //print(annotation.coordinate.latitude,annotation.coordinate.longitude)
               // print(my_longitude)
                //self?.location.append(items.coordinate.latitude,items.coordinate.longitude)
                //let distance = CLLocation(latitude:region.center.latitude ,
                                        //  longitude:region.center.longitude).distance(from: CLLocation(latitude: latitude,
                                          //                                                  longitude: longitude))
                    // print(distance)
                //print(locationManager.location?.coordinate.latitude)
                //B = self?.A.append(contentsOf: region.span.latitudeDelta,region.span.longitudeDelta,])
                //let Delta:[Double] = [region.span.latitudeDelta,region.span.longitudeDelta]
               // let TarLon = region.center.longitude
              //  let TarLat = region.center.latitude
                let CurLon = region.center.longitude
                let CurLat = region.center.latitude

                //ここから移動距離の算出
               // let currentLa   = CurLat * Double.pi / 180
                //let currentLo   = CurLon * Double.pi / 180
                //let targetLa    = TarLat * Double.pi / 180
                //let targetLo    = TarLon * Double.pi / 180
                        // 赤道半径
                //let equatorRadius = 6378137.0;
                        
                        // 算出
                //let averageLat = (currentLa - targetLa) / 2
                //let averageLon = (currentLo - targetLo) / 2
                //let distance = equatorRadius * 2 * asin(sqrt(pow(sin(averageLat), 2) + cos(currentLa) * cos(targetLa) * pow(sin(averageLon), 2)))
                //let distancekm = distance/1000
                //print("distance:",distancekm)
                //print("Delta:",Delta)
                print("CurrentLocation:",CurLat,CurLon)
                //print("TargetLocation:",TarLat,TarLon)
               
                }
            .store(in: &cancellable)
        
    }
   
    /// 位置情報のリクエスト.
    func requestUserLocation() {
        manager.startUpdatingLocation()
    }
    
    /// MapItemをクリア.
   func removeItems() {
        items.removeAll()
    }
}


extension MapViewModel: CLLocationManagerDelegate {
    
    // 位置情報関連の権限に変更があったら呼び出される.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        
        if manager.authorizationStatus == .authorizedWhenInUse {
            print(#function, "権限があるので位置情報をリクエスト.")
            
            // 正確な位置情報を利用する権限があるかどうか.
            if manager.accuracyAuthorization != .fullAccuracy {
                // 正確な位置情報をリクエスト.
                manager.requestTemporaryFullAccuracyAuthorization(withPurposeKey: "full_accuracy_message")
            }
            manager.distanceFilter = 10
            manager.startUpdatingLocation()
        } else {
            print(#function, "権限がないので権限をリクエスト.")
            manager.requestWhenInUseAuthorization()
            
            //locationManager.requestAlwaysAuthorization()
            
        }
    }
    
  // 位置情報が更新されたら呼び出される.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        
        manager.stopUpdatingLocation()
        withAnimation {
            //region.center = location.coordinate
            region.center = location.coordinate
        }
        let newLocation = locations.last
      //        CLLocationCoordinate2DIsValid(newLocation.coordinate) else {
                     //       self.mpsTextField.text = "Error"
                   //         self.kphTextField.text = "Error"
                 //           return
               //     }
             //       self.mpsTextField.text="".appendingFormat("%.2f",newLocation.speed)
           //         self.kphTextField.text = "".appendingFormat("%.2f", newLocation.speed * 3.6)
                }
        //print(latitude,longitude)
       // let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
     
        //print(location.coordinate.latitude,location.coordinate.longitude)
        //print(region.center.latitude,region.center.longitude)
      // print(latitude,longitude)
        // func Mapdiff(){
          //  print("latitude",region.center.latitude)
            //print("longitude",region.center.longitude)
            //print(region.span.latitudeDelta)
            //print(region.span.longitudeDelta)
        //}
        //Mapdiff()
        }
        


