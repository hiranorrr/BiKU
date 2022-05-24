
import SwiftUI

struct MapAnnotationView: View {
    
    var item: MapItem
    var namespace: Namespace.ID
    
    var body: some View {
        
        Image(systemName: "bubble.middle.bottom.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .matchedGeometryEffect(id: item.id, in: namespace)
            .frame(width: 44.0)
            .foregroundColor(item.color)
            .shadow(color: Color.black.opacity(0.5), radius: 5, x: 5, y: 5)
    }
}

struct MapAnnotationView_Previews: PreviewProvider {
    
    @Namespace static var namespace
    
    static var previews: some View {
        MapAnnotationView(item: MapItem(), namespace: namespace)
            .previewLayout(.fixed(width: 200.0, height: 200.0))
    }
}
