//
//  MapViewController.swift
//  bikeStops
//
//  Created by James Rochabrun on 08-04-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate  {
    
    let locationManager = CLLocationManager()
    var bikeAnotation  = MKPointAnnotation()
    var bikeStop = NSDictionary()

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
     print(bikeStop)
        
        //1 creates alert to request access from the user
        locationManager.requestWhenInUseAuthorization()
        
        // 2 sets the location managers delegates to this VC
        locationManager.delegate = self
        //4 start tracking user
        locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
        let x = bikeStop.objectForKey("latitude") as! Int
        let y = bikeStop.objectForKey("longitude") as! Int
        
        let latitude = Double(x)
        let longitude = Double(y)
        
        let annotation = MKPointAnnotation()

        annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        
        annotation.title = bikeStop.objectForKey("stationName") as? String
//        annotation.subtitle = bikeStop.objectForKey("") as? String
        
        self.mapView.addAnnotation(annotation)
        
//        self.zoomMap()
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print(error)
    }
    
    func mapView(mapView: MKMapView,viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        //userlocation
        if annotation is MKUserLocation{
            return nil
        }
        
        let pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pinView.image = UIImage(named:"bike")
        pinView.canShowCallout = true
        let calloutButton = UIButton(type: .DetailDisclosure) as UIButton
        pinView.rightCalloutAccessoryView = calloutButton
        
        return pinView
    }
    
    func zoomMap()
    {
        let x = bikeStop.objectForKey("latitude") as! Int
        let y = bikeStop.objectForKey("longitude") as! Int
        let latitude = Double(x)
        let longitude = Double(y)
        let span = MKCoordinateSpanMake(0.5, 0.5)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude , longitude: longitude), span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


    


}
