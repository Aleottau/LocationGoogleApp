//
//  ViewController.swift
//  LocationGoogleApp
//
//  Created by alejandro on 27/01/23.
//

import UIKit
import GoogleMaps
import SnapKit

class ViewController: UIViewController {
    
    let mapView = GMSMapView()
    let locationManager = LocationManager()
    var currentUserLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMap()
    }
    override func viewWillAppear(_ animated: Bool) {
        locationManager.validateStatusAuthorization()
        locationManager.delegate = self
    }
    func setUpMap() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func cameraPositonConfig(location: CLLocation) {
        let cameraPosition = GMSCameraPosition(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 10.0)
//        mapView.camera = cameraPosition
        mapView.animate(to: cameraPosition)
//        mapView.animate(toZoom: 10.0)
    }
    func showLocation(location: CLLocation, placemark: CLPlacemark) {
        guard let area = placemark.administrativeArea, let city = placemark.locality, let country = placemark.country, let address = placemark.name else {
            return
        }
        cameraPositonConfig(location: location)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        marker.title = address
        marker.snippet = "\(city), \(area), \(country)"
        marker.map = mapView
    }

}

extension ViewController: LocationManagerDelegate {
    func currentLocation(location: CLLocation, placeMark: CLPlacemark) {
        showLocation(location: location, placemark: placeMark)
    }
}
