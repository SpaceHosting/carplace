//
//  MapController.swift
//  Maps
//
//  Created by hassoun on 23/05/2023.
//

import MapKit


class MapController: ObservableObject {
    var searchTerm = String()
    @Published var isBusinessViewShowing = false
    @Published private(set) var businesses = [Business]()
    @Published private(set) var selectedBusiness: Business?
    @Published private(set) var actions = [Action]()
 
    var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 45.466480, longitude: 9.188970), latitudinalMeters: 1600, longitudinalMeters: 1600)
    
    var selectedBusinessName: String {
        guard let selectedBusiness = selectedBusiness else { return "" }
        return selectedBusiness.name
    }
    
    var selectedBusinessPlacemark: String {
        guard let selectedBusiness = selectedBusiness else { return "" }
        return selectedBusiness.placemark.title ?? "??"
    }
    
    func search() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTerm
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else { return }
            DispatchQueue.main.async {
                self.businesses = response.mapItems.map { item in
                    Business(name: item.name ?? "", placemark: item.placemark, placedinate: item.placemark.coordinate, phoneNumber: item.phoneNumber ?? "", website: item.url)
                }
            }
        }
        createActions()
    }
    
    func openMap(coordinate: CLLocationCoordinate2D) {
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        mapItem.openInMaps()
    }
    
    func setSelectedBusiness(for business: Business) {
        selectedBusiness = business
        isBusinessViewShowing.toggle()
    }
    
    func createActions() {
        actions = [
            Action(title: "Directions", image: "car.fill") { [weak self] in
                guard let self = self else { return }
                self.openMap(coordinate: self.selectedBusiness!.coordinate)
            },
            Action(title: "Call", image: "Phone.fill") { [weak self] in
                guard let self = self else { return }
                guard let phoneNumber = self.selectedBusiness?.phoneNumber else { return }
                guard let url = URL(string: self.convertPhoneNumberFormat(phoneNumber: phoneNumber)) else { return }
                UIApplication.shared.open(url)
            },
            Action(title: "Website", image: "safari.fill") { [weak self] in
                guard let self = self else { return }
                guard let website = self.selectedBusiness?.website else { return }
                UIApplication.shared.open(website)
            }
        ]
    }
    
    func convertPhoneNumberFormat(phoneNumber: String) -> String {
        let strippedPhoneNumber = phoneNumber
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
        return "tel://\(strippedPhoneNumber)"
    }
    
    
    
}
