//
//  MapViewController.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Map"
        self.configureMapView()
    }

    private func configureMapView() {
        let mapView = MKMapView()
        mapView.isZoomEnabled = true
        mapView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)

        // Calculado latitud y longitud (RAMDON) en algun lugar de Peru...
        let latitude = Double.random(in: 3..<20)*(-1.0)
        let longitude = Double.random(in: 70..<80)*(-1.0)

        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 12.0, longitudeDelta: 12.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)

        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        pin.title = "En algún lugar"
        mapView.addAnnotation(pin)

        self.mapView = mapView
        self.view.addSubview(mapView)
    }

}
