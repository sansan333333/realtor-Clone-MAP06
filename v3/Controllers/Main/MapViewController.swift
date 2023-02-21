//
//  MapViewController.swift
//  v3
//
//  Created by Jun on 2023-02-07.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    var pins: [Pin] = [Pin]()
    var results: [Result] = [Result]()
    
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    var showCurrentLocationButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Map"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        setMapKitContrains()
        
        mapView.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startUpdatingLocation()
        
        
        addShowCurrentLocationButton()
        gpsAnotationsApiCall()
    }
    
    
    
    func setMapKitContrains() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    
    func addShowCurrentLocationButton() {
        showCurrentLocationButton = UIButton(type: .system)
        showCurrentLocationButton.setTitle("Show My Current Location", for: .normal)
        showCurrentLocationButton.tintColor = .label
        showCurrentLocationButton.addTarget(self, action: #selector(showCurrentLocation), for: .touchUpInside)
        view.addSubview(showCurrentLocationButton)
        
        showCurrentLocationButton.translatesAutoresizingMaskIntoConstraints = false
        showCurrentLocationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        showCurrentLocationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    @objc func showCurrentLocation() {
        guard let location = locationManager.location?.coordinate else { return }
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
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
    
    var mls = ""
    
    func c() {
        
        for result in results {
            for pin in pins {
                
                while pin.propertyId == result.Id {
                    mls = result.MlsNumber!
                }
            }
        }
    }
    
}


extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
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
        guard let annotation = view.annotation as? MKPointAnnotation else {
            return
        }

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
                                                             agentCompany: propertyDetail.Individual?[0].Organization.Name ?? ""
                                                            ))
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print("error from didSelect" + error.localizedDescription)
            }
        }
    }
    

    
}




















//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//           if status == .authorizedWhenInUse {
//               locationManager.startUpdatingLocation()
//           }
//       }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = locations.last!
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//        mapView.setRegion(region, animated: true)
//    }


//        locationManager.delegate = self
//        locationManager.startUpdatingLocation()






//        showCurrentLocationButton = UIButton(type: .system)
//        showCurrentLocationButton.setTitle("Show Current Location", for: .normal)
//        showCurrentLocationButton.translatesAutoresizingMaskIntoConstraints = false
//        showCurrentLocationButton.addTarget(self, action: #selector(showCurrentLocation), for: .touchUpInside)
//
//        view.addSubview(showCurrentLocationButton)
//
//        NSLayoutConstraint.activate([
//                    showCurrentLocationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
//                    showCurrentLocationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//                ])
