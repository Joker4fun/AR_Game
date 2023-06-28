//
//  AppSettingsViewController.swift
//  AR_monster_game
//
//  Created by Антон Казеннов on 14.06.2023.
//

import UIKit
import CoreLocation

class AppSettingsViewController: UIViewController {
  
  var lmViewModel: GeoRequestViewModel?
  @IBOutlet weak var settingsButton: UIButton!
    
  override func viewDidLoad() {
    super.viewDidLoad()
      lmViewModel = GeoRequestViewModel()
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(handleAppDidBecomeActiveNotification(notification:)),
                                           name: UIApplication.didBecomeActiveNotification,
                                           object: nil)
  }
  
  @objc func handleAppDidBecomeActiveNotification(notification: Notification) {
    if #available(iOS 14.0, *) {
      switch lmViewModel?.locationManager.authorizationStatus {
      case .authorizedAlways, .authorized, .authorizedWhenInUse:
        performSegue(withIdentifier: "fromSettingsToMap", sender: nil)
      case .denied, .notDetermined, .restricted:
        popUp()
      default:
        performSegue(withIdentifier: "fromSettingsToMap", sender: nil)
      }
    } else {
      let authStatus = CLLocationManager.authorizationStatus()
      switch authStatus {
      case .authorizedAlways, .authorizedWhenInUse:
        performSegue(withIdentifier: "fromSettingsToMap", sender: nil)
      case .denied, .notDetermined, .restricted:
        popUp()
      default:
        performSegue(withIdentifier: "fromSettingsToMap", sender: nil)
      }
    }
  }
  
  func popUp() {
    let alert = UIAlertController(title: "У Вас выключенна служба геолокации", message: "Хотите включить ?", preferredStyle: .alert)
    let settingsButton = UIAlertAction(title: "Настройки", style: .default) { alert in
      if #available(iOS 16.0, *) {
        if let url = URL(string: UIApplication.openNotificationSettingsURLString) {
          UIApplication.shared.open(url)
        }
      } else {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
      }
    }
    let cancellButton = UIAlertAction(title: "Отмена", style: .cancel)
    alert.addAction(settingsButton)
    alert.addAction(cancellButton)
    self.present(alert, animated: true, completion: nil)
  }
 
  @IBAction func openSettigns(_ sender: Any) {
    if #available(iOS 16.0, *) {
      if let url = URL(string: UIApplication.openSettingsURLString)  {
        UIApplication.shared.open(url)
      }
    } else {
      if let url = URL(string: UIApplication.openSettingsURLString) {
        UIApplication.shared.open(url)
      }
    }
  }
}
