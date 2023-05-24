//
//  Business.swift
//  Maps
//
//  Created by hassoun on 23/05/2023.
//

import Foundation
import MapKit

struct Business:Identifiable{
    let id = UUID()
    let name: String
    let placemark: MKPlacemark
    let placedinate: CLLocationCoordinate2D
    let phoneNumber: String
    let website: URL?
    var coordinate: CLLocationCoordinate2D {
            return placemark.coordinate
        }
}
