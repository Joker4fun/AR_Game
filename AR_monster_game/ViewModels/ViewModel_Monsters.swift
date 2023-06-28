//
//  ViewModel_Monsters.swift
//  AR_monster_game
//
//  Created by Антон Казеннов on 19.06.2023.
//

import Foundation
import MapKit
import Combine

protocol MonstersInMapDelegate {
    func createRandomCoord() -> CLLocationCoordinate2D
    func createMonsters(_ monstersValue: Int) -> [Mobs]
    func createSpin(count: Int) -> [MKAnnotation]
    func startTimer()
    var locationManager:GeoRequestViewModel {get set}
    
}

class MonstersInMap: MonstersInMapDelegate {
    
    var locationManager:GeoRequestViewModel
    let defaults = UserDefaults.standard
    var startTimerBool: Bool
    private var store:[AnyCancellable] = []
    var mosterAnnotations: [MKAnnotation] = []
    
    required init(locationManager: GeoRequestViewModel) {
        self.locationManager = locationManager
        self.startTimerBool = defaults.bool(forKey: "startTrue")
        self.mosterAnnotations = createSpin(count: 30)
    }
    
    let currentPossition = GeoRequestViewModel()
    lazy var lat:CLLocationDegrees = {
        var lat = CLLocationDegrees()
        lat = currentPossition.locationManager.location?.coordinate.latitude ?? 55.7522200
        return lat
    }()
    lazy var lon: CLLocationDegrees = {
        var lon = CLLocationDegrees()
        lon = currentPossition.locationManager.location?.coordinate.longitude ?? 37.6155600
        return lon
    }()
    
    func startTimer() {
        if self.mosterAnnotations.count != 0 && self.mosterAnnotations.count > 31 {
            for (index, _) in mosterAnnotations.enumerated() {
                let num = Int.random(in: 0...100)
                if num >= 20 {
                    self.mosterAnnotations.remove(at: index)
                }
            }
        }
        if !startTimerBool {
            Timer.publish(every: 300, on: .main, in: .default)
                .autoconnect()
                .receive(on: RunLoop.main)
                .sink { _ in
                    self.mosterAnnotations.append(contentsOf: self.createSpin(count: 6))
                }
                .store(in: &store)
        }
        defaults.set(true, forKey: "startTrue")
        startTimerBool = defaults.bool(forKey: "starTrue")
    }
    
    
    
    func createRandomCoord() -> CLLocationCoordinate2D {
        let meterCord = 0.00900900900901
        let neLat = Double.random(in: lat - meterCord...lat + meterCord)
        let neLon = Double.random(in: lon - meterCord...lon + meterCord)
        return CLLocationCoordinate2D(latitude: neLat, longitude: neLon)
    }
    
    func createMonsters(_ monstersValue: Int) -> [Mobs] {
        var mobs = [Mobs]()
        for _ in 0...monstersValue {
            let monst = Mobs(coords: createRandomCoord())
            mobs.append(monst)
        }
        return mobs
    }
    
    func createSpin(count: Int) -> [MKAnnotation] {
        let array = createMonsters(count)
        var arrayOfAnnotations = [MKAnnotation]()
        for i in array {
            let new = MKPointAnnotation()
            new.title = i.name
            new.coordinate = CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude)
            let coordinate1 = CLLocation(latitude: lat, longitude: lon)
            let distanceInMeters = coordinate1.distance(from: CLLocation(latitude: new.coordinate.latitude, longitude: new.coordinate.longitude))
            new.subtitle = "Level: \(i.level), \(Int(distanceInMeters))м - до монстра! "
            
            arrayOfAnnotations.append(new)
        }
        return arrayOfAnnotations
    }
    
    func checkDistance(_ annotation: MKAnnotationView) -> Int {
        
        let coordinate1 = CLLocation(latitude: (annotation.annotation?.coordinate.latitude)!, longitude: (annotation.annotation?.coordinate.longitude)!)
        let curr = CLLocation(latitude: lat, longitude: lon)
        let distanceInMeters = coordinate1.distance(from: curr)
        return Int(distanceInMeters)
    }
    
    func checkDistanceInMap(_ annotation: MKAnnotation) -> Int {
        
        let coordinate1 = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        let curr = CLLocation(latitude: lat, longitude: lon)
        let distanceInMeters = coordinate1.distance(from: curr)
        return Int(distanceInMeters)
    }
}
