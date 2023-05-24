//
//  ContentView.swift
//  Maps
//
//  Created by hassoun on 23/05/2023.
//
// Apple Map & Google Map same as design of parkopedia
import SwiftUI

struct ContentView: View {
    //https://en.parkopedia.com/parking/locations/milano_città_metropolitana_di_milano_italia_1h9iu0nd9h6ysvt7b2/?arriving=202305241030&leaving=202305241230
    
    @StateObject var mapController = MapController()
    var body: some View {
        NavigationStack{
            MapView(mapController: mapController)
            
        }
        .searchable(text: $mapController.searchTerm)
        .onSubmit(of: .search) {
            mapController.search()
        }
        
        

        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
