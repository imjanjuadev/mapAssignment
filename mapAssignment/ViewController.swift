//
//  ViewController.swift
//  mapAssignment
//
//  Created by Macbook Pro on 19/04/2022.
//
import CoreLocation
import GooglePlaces
import GoogleMaps
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate  {
    
    @IBOutlet weak var mapView: GMSMapView!
//    var mapView : GMSMapView?
    @IBOutlet var viewController: UIView!
    @IBOutlet weak var distanceResult: UILabel!
    let manger = CLLocationManager()
    var selectedDriver = ""
    override func viewDidLoad() {
//        self.view.isUserInteractionEnabled = false
//        mapView = GMSMapView()
        super.viewDidLoad()
        manger.delegate = self
        manger.requestWhenInUseAuthorization()
        manger.startUpdatingLocation()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondViewController = segue.destination as! FormViewController

        // Set a variable in the second view controller with the String to pass
        secondViewController.recieveRiderName = selectedDriver

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        let coordinate = location.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 20.0)
        mapView.animate(to: camera)
//        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
//        view.addSubview(mapView)
        
        //My location
        let myLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        //My First Destination
        let myFirsttDestination = CLLocation(latitude: 13.068500, longitude: 80.234938)
        //Finding my distanceA to my next destination (in km)
        let distance_A = myLocation.distance(from: myFirsttDestination)/1000
        
        
        //My Second Destination
        let mySecondtDestination = CLLocation(latitude: 13.062306, longitude:  80.231172)
        //Finding my distance2 to my next destination (in km)
        let distance_B = myLocation.distance(from: mySecondtDestination)/1000
        
        
        //My Third Destination
        let myThirdtDestination = CLLocation(latitude: 13.071086, longitude: 80.234938)
        //Finding my distance3 to my next destination (in km)
        let distance_C = myLocation.distance(from: myThirdtDestination)/1000
        
        if (distance_A <= 6432) {
            self.view.isUserInteractionEnabled = true
            distanceResult.text = "\(distance_A)"
            selectedDriver = "Driver A"
        }
        else if(distance_B <= 6432){
            self.view.isUserInteractionEnabled = true
            distanceResult.text = "\(distance_B)"
            selectedDriver = "Driver B"
        }
        else if(distance_C <= 6432){
            self.view.isUserInteractionEnabled = true
            distanceResult.text = "\(distance_C)"
            selectedDriver = "Driver C"
        }
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude,longitude: coordinate.longitude)
        marker.title = "Your Current Location"
        marker.snippet = ""
        marker.map = mapView
    }
}

