

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    
    @StateObject private var viewModel = MapViewModel()
    
    @State private var showModal = false
    @State private var selectedItem = MapItem()
    //@EnvironmentObject var locationViewModel: LocationViewModel
    @Namespace var namespace
    
    var body: some View {
    
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            
            Map(
                coordinateRegion: $viewModel.region,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: $viewModel.trackingMode,
                annotationItems: viewModel.items
            ) { item in
                MapAnnotation(
                    coordinate: item.coordinate,
                    anchorPoint: CGPoint(x: 0.5, y: 1.0)
                ) {
                    MapAnnotationView(item: item, namespace: namespace)
                        .onTapGesture {
                            withAnimation {
                                showModal.toggle()
                                selectedItem = item
                            }
                        }
                }
            }
            .ignoresSafeArea()
            
            HStack(spacing: 24.0) {
                
                // MapItemのクリアボタン.
                Button(action: {
                    viewModel.removeItems()
                }, label: {
                    Image(systemName: "mappin.slash")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44.0, height: 44.0)
                })
                
                // 位置情報リクエストボタン.
                Button(action: {
                    viewModel.requestUserLocation()
                }, label: {
                    Image(systemName: "dot.circle.and.cursorarrow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44.0)
                })
            }
            .padding(24.0)
            
            // アノテーションが選択されたら、詳細画面を前面に表示する.
            if showModal {
                DetailView(
                    mapItem: $selectedItem,
                    showModal: $showModal,
                    namespace: namespace
                )
            }
        }
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
