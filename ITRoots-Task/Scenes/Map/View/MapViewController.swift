//
//  MapViewController.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 29/01/2025.
//

import UIKit
import MapKit
import CoreLocation

final class MapViewController: BaseViewController {

    @IBOutlet private weak var mapView: MKMapView!
    
    private var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Map".localize
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLocationManager()
    }
    
    private func setLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        locationManager.startUpdatingLocation()
    }
}

// MARK: CLLocationManager Delegate
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else { return }
        let region = MKCoordinateRegion(
            center: currentLocation.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
        )
        mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = currentLocation.coordinate
        annotation.title = "You are here".localize
        mapView.addAnnotation(annotation)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}
