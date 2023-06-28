//
//  MapViewController.swift
//  AR_monster_game
//
//  Created by Антон Казеннов on 14.06.2023.
//

import UIKit
import MapKit
import Combine

final class MapViewController: UIViewController {
    
    var viewModel:MonstersInMap!
    let defaults = UserDefaults.standard
    let mapView = MKMapView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.delegate = self
        mapView.showsUserLocation = true
        viewModel.startTimer()
        viewModel.locationManager.locationManager.delegate = self
        viewModel.locationManager.locationManager.startUpdatingLocation()
        mapView.removeAnnotations(viewModel.mosterAnnotations)
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.locationManager.findMe(mapView: mapView)
        viewModel.mosterAnnotations.forEach({mapView.addAnnotation($0)})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstarints()
        navigationItem.hidesBackButton = true
        makeButtonsBordered()
    }
    
    lazy var zoomInButton = {
        let button = UIButton()
        button.titleLabel?.text = ""
        button.setImage(UIImage(systemName: "plus.magnifyingglass"), for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.addTarget(self, action: #selector(zoomInButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var zoomOutButton = {
        let button = UIButton()
        button.titleLabel?.text = ""
        button.setImage(UIImage(systemName: "minus.magnifyingglass"), for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.addTarget(self, action: #selector(zoomOutButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var locationButton = {
        let button = UIButton()
        button.titleLabel?.text = ""
        button.setImage(UIImage(systemName: "dot.arrowtriangles.up.right.down.left.circle"), for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.addTarget(self, action: #selector(meInMapButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var myTeamButton = {
        let button = UIButton()
        button.setTitle("Моя команда", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(myTeamButtonAction), for: .touchUpInside)
        return button
    }()
    
    private func makeConstarints() {
        view.addSubview(mapView)
        view.addSubview(zoomInButton)
        view.addSubview(zoomOutButton)
        view.addSubview(locationButton)
        view.addSubview(myTeamButton)
        
        zoomInButton.translatesAutoresizingMaskIntoConstraints = false
        zoomInButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        zoomInButton.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        zoomInButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        zoomInButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        zoomOutButton.translatesAutoresizingMaskIntoConstraints = false
        zoomOutButton.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        zoomOutButton.topAnchor.constraint(equalTo: zoomInButton.bottomAnchor, constant: 5).isActive = true
        zoomOutButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        zoomOutButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        locationButton.topAnchor.constraint(equalTo: zoomOutButton.bottomAnchor, constant: 30).isActive = true
        locationButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        locationButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        myTeamButton.translatesAutoresizingMaskIntoConstraints = false
        myTeamButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        myTeamButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        myTeamButton.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        myTeamButton.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true

        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    private func makeButtonsBordered() {
        zoomInButton.layer.cornerRadius = 15
        zoomInButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        zoomOutButton.layer.cornerRadius = 15
        zoomOutButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        locationButton.layer.cornerRadius = 15
        locationButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        myTeamButton.layer.cornerRadius = 15
        myTeamButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    @objc func zoomInButtonAction() {
        mapView.userTrackingMode = .none
        viewModel.locationManager.zoomIn(mapView: mapView)
    }
    
    @objc func zoomOutButtonAction() {
        mapView.userTrackingMode = .none
        viewModel.locationManager.zoomOut(mapView: mapView)
    }
    
    @objc func meInMapButtonAction() {
        viewModel.locationManager.findMe(mapView: mapView)
        mapView.userTrackingMode = .follow
    }
    
    @objc func myTeamButtonAction() {
        let tableVC = MyTeamViewController()
        navigationController?.pushViewController(tableVC, animated: false)
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let ident = "custom"
        var anotationView = mapView.dequeueReusableAnnotationView(withIdentifier: ident)
        if anotationView == nil {
            anotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: ident)
            anotationView?.canShowCallout = true
        }
        anotationView?.canShowCallout = true
        anotationView?.sizeToFit()
        let image = UIImage(named: (annotation.title ?? nil) ?? "Anna")
        anotationView?.image = image
        return anotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation {
            return
        }
        
        if viewModel.checkDistance(view) < 100 {
            let vc = ARCatchMonsterViewController()
            vc.monster = view.annotation
            if let index = viewModel?.mosterAnnotations.firstIndex(where: { $0 === view.annotation }) {
                viewModel?.mosterAnnotations.remove(at: index)
                print("\(viewModel.mosterAnnotations.count) monster after remove")
            }
            mapView.removeAnnotation(view.annotation!)
            navigationController?.pushViewController(vc, animated: true)
        }else {
            let alert = UIAlertController(title: "Слишком далеко!", message: "Вы находитесь слишком далеко от этого монстра - \(Int(viewModel.checkDistance(view)))м . Подберитесь ближе!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Хорошо", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        for annotation in mapView.annotations {
            guard let annotationView = self.mapView.view(for: annotation) else { continue }
            let scale = -1 * sqrt(1 - pow(mapView.zoomLevel / 19, 2.0)) + 1.3
            annotationView.transform = CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale))
        }
    }
}

extension MKMapView {
    var zoomLevel: Double {
        return log2(360 * ((Double(self.frame.size.width) / 256) / self.region.span.longitudeDelta)) - 1
    }
}

extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 500) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        for annotation in mapView.annotations {
            if viewModel.checkDistanceInMap(annotation) > 300 {
                mapView.view(for: annotation)?.isHidden = true
            } else  {
                mapView.view(for: annotation)?.isHidden = false
            }
        }
    }
}
