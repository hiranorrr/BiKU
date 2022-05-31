

import SwiftUI
import MapKit

struct DetailView: View {
    
    @Binding var mapItem: MapItem
    @Binding var showModal: Bool
    
    var namespace: Namespace.ID
    
    var body: some View {
        
        ZStack {
            // 背景色
            Color.black.opacity(0.2).ignoresSafeArea()
            
            // MapItemの画像.
            Image(systemName: "bubble.middle.bottom.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .matchedGeometryEffect(id: mapItem.id, in: namespace)
                .frame(width: UIScreen.main.bounds.width - 100.0)
                .foregroundColor(mapItem.color)
                .shadow(color: Color.black.opacity(0.5), radius: 5, x: 5, y: 5)
        }
        // タップしたら閉じる.
        .onTapGesture {
            withAnimation {
                showModal.toggle()
                mapItem = MapItem()
            }
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    
    @Namespace static var namespace
    
    static var previews: some View {
        DetailView(
            mapItem: .constant(MapItem(coordinate: CLLocationCoordinate2D(), color: .red)),
            showModal: .constant(true),
            namespace: namespace
        )
    }
}
