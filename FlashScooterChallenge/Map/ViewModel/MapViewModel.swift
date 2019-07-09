//
//  MapViewModel.swift
//  FlashScooterChallenge
//
//  Created by Munib Siddiqui on 09/07/2019.
//  Copyright © 2019 Munib Siddiqui. All rights reserved.
//

import MapKit

class MapViewModel: NSObject {
   
    var vehicles: [Vehicle] = []
    var error: Error?
    var refreshing = false

    func fetchAllVehicles(completion: @escaping () -> Void) {
        refreshing = true
        
        NetworkManager.sharedInstance.getAllVehical(onSuccess: { (vehicles) in
            self.vehicles = vehicles
            self.refreshing = false
            completion()

        }) { (error) in
            self.error = error
            self.refreshing = false
            completion()

        }

    }

}

class MapPin : NSObject, MKAnnotation {
    var vehicle : Vehicle
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(vehicle:Vehicle) {
        
        let coordinate = CLLocationCoordinate2D(latitude: vehicle.latitude,
                                                longitude: vehicle.longitude)
        let name = vehicle.name
        let price = vehicle.price
        
        self.vehicle = vehicle
        self.coordinate = coordinate
        self.title = name
        self.subtitle = String(price)
    }
}



