//
//  mapView.swift
//  Maps
//
//  Created by hassoun on 24/05/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var mapController: MapController
    
    var body: some View {
        Map(coordinateRegion: $mapController.region, annotationItems: mapController.businesses){ business in
            MapAnnotation(coordinate: business.coordinate){
                Image(systemName: "mappin.and.ellipse")
                    .font(.title)
                    .foregroundColor(.pink)
                    .onTapGesture {
                        mapController.setSelectedBusiness(for: business)
                        
                    }
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .edgesIgnoringSafeArea(.top)
        .sheet(isPresented: $mapController.isBusinessViewShowing){
            BusinessView(mapController: mapController)
                .presentationDetents([.fraction(0.27), .large])
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(mapController: MapController())
    }
}
