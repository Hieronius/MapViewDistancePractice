//
//  ViewController.swift
//  MapViewNavigationPractice
//
//  Created by Арсентий Халимовский on 15.04.2023.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    let customPinOne = CLLocationCoordinate2D(latitude: 55.746854, longitude: 37.536791)
    let customPinTwo = CLLocationCoordinate2D(latitude: 55.750457, longitude: 37.536018)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.delegate = self
        
        getDistance()
    }
    
    func getDistance() {
        let sourceCoordinate = customPinOne
        let destinationCoordinate = customPinTwo
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionsRequest = MKDirections.Request()
        directionsRequest.source = sourceMapItem
        directionsRequest.destination = destinationMapItem
        directionsRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionsRequest)
        
        directions.calculate { (response, error) in
            guard let response = response else { return }
            
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
        }
    }


}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .purple
            renderer.lineWidth = 5
            return renderer
        }
        return MKOverlayRenderer()
    }
}

