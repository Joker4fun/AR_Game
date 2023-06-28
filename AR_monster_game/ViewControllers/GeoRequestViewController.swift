//
//  GeoRequestViewController.swift
//  AR_monster_game
//
//  Created by Антон Казеннов on 14.06.2023.
//

import UIKit
import MapKit
import Combine


@available(iOS 14.0, *)
class GeoRequestViewController: UIViewController {
    
    @IBOutlet weak var AcceptButton: UIButton!
    @IBOutlet weak var warningText: UILabel!
    private var locationManager:CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    private func makeAlertView() {
        warningText.layer.borderWidth = 2.0
        warningText.layer.cornerRadius = 15
        warningText.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        warningText.backgroundColor = UIColor.black
        warningText.layer.masksToBounds = true
        
        AcceptButton.layer.borderWidth = 2.0
        AcceptButton.layer.cornerRadius = 15
        AcceptButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        AcceptButton.backgroundColor = UIColor.black
        AcceptButton.layer.masksToBounds = true
    }
    
    @IBAction func AcsessGEO(_ sender: Any) {
        locationManager?.requestWhenInUseAuthorization()
    }
}

@available(iOS 14.0, *)
extension GeoRequestViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    switch CLLocationManager.authorizationStatus() {
                    case .authorizedWhenInUse, .authorizedAlways:
                        let map = ModelBuilder.createMapView()
                      navigationController?.pushViewController(map, animated: true)
                        break
                    case .restricted, .denied:
                        performSegue(withIdentifier: "toSettingsView", sender: nil)
                        break
                    default:
                        break
                    }
                }
            }
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager?.authorizationStatus {
        case .authorized, .authorizedAlways, .authorizedWhenInUse:
            let map = ModelBuilder.createMapView()
            navigationController?.pushViewController(map, animated: true)
            break
        case .restricted, .denied:
            performSegue(withIdentifier: "toSettingsView", sender: nil)
            break
        default:
            break
        }
    }
}


