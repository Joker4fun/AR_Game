//
//  ModuleBuilder.swift
//  AR_monster_game
//
//  Created by Антон Казеннов on 24.06.2023.
//

import UIKit
import MapKit

protocol Builder {
  static func createMapView() -> UIViewController


}


class ModelBuilder: Builder{
    
    static func createMapView() -> UIViewController {
        let geoManager = GeoRequestViewModel()
        let model = MonstersInMap(locationManager: geoManager)
        let mapView = MapViewController()
        mapView.viewModel = model
        return mapView
    }
}
