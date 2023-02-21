//
//  MapUIView.swift
//  v3
//
//  Created by Jun on 2023-02-21.
//

import UIKit
import MapKit

class MapUIView: UIView {

    let mapView: MKMapView = {
        let mapView = MKMapView()
        let location = CLLocationCoordinate2D(latitude: 45.5080401, longitude: -73.634295)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Apple Inc."
//        mapView.addAnnotation(annotation)
        
        return mapView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mapView)
        addGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mapView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.systemBackground.cgColor]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
}
