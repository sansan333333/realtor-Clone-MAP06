//
//  MapUIView.swift
//  v3
//
//  Created by Jun on 2023-02-21.
//

import UIKit
import MapKit

class MapUIView: UIView, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var pins: [Pin] = [Pin]()
    var results: [Result] = [Result]()
    let locationManager = CLLocationManager()
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        let location = CLLocationCoordinate2D(latitude: 45.5080401, longitude: -73.634295)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        return mapView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mapView)
        
        mapView.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startUpdatingLocation()
        
        gpsAnotationsApiCall()
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
    
    
    func gpsAnotationsApiCall() {
        APICaller.shared.getGPSAnotations(for: 1) { [weak self] result in
            switch result {
            case.success(let results):
                self?.pins = results
                DispatchQueue.main.async {
                    self?.addPins()
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func addPins() {
        
        if pins.count != 0 {
            
            for pin in pins {
                let propertyPins = MKPointAnnotation()
                
                propertyPins.title = pin.propertyId
                propertyPins.coordinate = CLLocationCoordinate2D(
                    latitude: Double(pin.latitude!)!, longitude: Double(pin.longitude!)!
                )
                mapView.addAnnotation(propertyPins)
            }
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            // create view
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "custom")
        } else {
            // assign annotation
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        // Redo the API call and update the annotations
        // ...
        let region = mapView.region
        let latitudeMax = region.center.latitude + region.span.latitudeDelta / 2
        let latitudeMin = region.center.latitude - region.span.latitudeDelta / 2
        let longitudeMax = region.center.longitude + region.span.longitudeDelta / 2
        let longitudeMin = region.center.longitude - region.span.longitudeDelta / 2
        print(region)
        
        //         Redo the API call and update the annotations
        APICaller.shared.getHomePageListByUpdateGPSWithPinResult(for: 1, LatitudeMax: latitudeMax, LatitudeMin: latitudeMin, LongitudeMax: longitudeMax, LongitudeMin: longitudeMin) { [weak self] result in
            switch result {
            case.success(let results):
                self?.pins = results.Pins!
                self?.results = results.Results!
                
                DispatchQueue.main.async {
                    self?.mapView.removeAnnotations(self!.mapView.annotations)
                    self?.addPins()
                }
                
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? MKPointAnnotation else { return }
        
        let propertyId = annotation.title ?? ""
        var mls = ""
        
        for result in results {
            if result.Id == propertyId {
                mls = result.MlsNumber!
            }
        }
        
        APICaller.shared.getPropertyDetail(for: mls, PropertyID: propertyId) { result in
            switch result {
            case.success(let propertyDetail):
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    vc.configure(with: TitlePreviewViewModel(favouriteIcon: "heart",
                                                             shareIcon: "heart",
                                                             propertyImage: (propertyDetail.Property?.Photo![0].HighResPath)!,
                                                             price: (propertyDetail.Property?.Price)!,
                                                             address: (propertyDetail.Property?.Address?.AddressText)!,
                                                             bedroomNum: (propertyDetail.Building?.Bedrooms ?? "0"),
                                                             propertyInfoDetailes: propertyDetail.PublicRemarks!,
                                                             MlsNumber: propertyDetail.MlsNumber!,
                                                             bathroom: (propertyDetail.Building?.BathroomTotal ?? "0"),
                                                             agentImage: propertyDetail.Individual?[0].PhotoHighRes ?? "",
                                                             agentName: propertyDetail.Individual?[0].Name ?? "",
                                                             agentPhone: propertyDetail.Individual?[0].Phones?[0].PhoneNumber ?? "",
                                                             agentCompanyLogo: propertyDetail.Individual?[0].Organization.Logo ?? "",
                                                             agentCompany: propertyDetail.Individual?[0].Organization.Name ?? "",
                                                             areaCode: propertyDetail.Individual?[0].Phones?[0].AreaCode ?? ""
                                                            )
                    )
                }
            case .failure(let error):
                print("error from didSelect" + error.localizedDescription)
            }
        }
    }
}
