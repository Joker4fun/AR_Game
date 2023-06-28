//
//  GeoRequestViewModel.swift
//  AR_monster_game
//
//  Created by Антон Казеннов on 14.06.2023.
//

import MapKit

protocol GeoRequestViewModelProtocol {
  func checkAvailableGeo()
  func zoomIn(mapView: MKMapView)
  func zoomOut(mapView: MKMapView)
  func findMe(mapView: MKMapView)
}

class GeoRequestViewModel: NSObject, GeoRequestViewModelProtocol {
  
  let locationManager = CLLocationManager()
  let corRegion = MKCoordinateRegion()
  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.startUpdatingLocation()
  }
  
  func checkAvailableGeo() {
    locationManager.requestAlwaysAuthorization()
  }
  
  func zoomIn(mapView: MKMapView) {
    let newLat = mapView.region.span.latitudeDelta * 0.25
    let newLon = mapView.region.span.latitudeDelta * 0.25
    let coordinateSpan = MKCoordinateSpan(latitudeDelta: newLat, longitudeDelta: newLon)
    let region = MKCoordinateRegion(center: mapView.region.center, span: coordinateSpan)
    mapView.setRegion(region, animated: true)
  }
  
  func zoomOut(mapView: MKMapView) {
    let newLat = mapView.region.span.latitudeDelta / 0.25
    let newLon = mapView.region.span.latitudeDelta / 0.25
    if CLLocationCoordinate2DIsValid(CLLocationCoordinate2D(latitude: newLat, longitude: newLon)) {
      let coordinateSpan = MKCoordinateSpan(latitudeDelta: newLat, longitudeDelta: newLon)
      let region = MKCoordinateRegion(center: mapView.region.center, span: coordinateSpan)
      mapView.setRegion(region, animated: true)
    }
  }
  
  func findMe(mapView: MKMapView) {
    if let userLocation = locationManager.location?.coordinate {
      let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 200, longitudinalMeters: 200)
      mapView.setRegion(region, animated: false)
    }
  }
}

extension GeoRequestViewModel: CLLocationManagerDelegate {

  
}




