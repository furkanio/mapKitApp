//
//  ViewController.swift
//  mapKitApp
//
//  Created by Furkan Yıldız on 30.01.2022.
//

import UIKit
import MapKit

class ViewController: UIViewController,MKMapViewDelegate {
    
    var coords : [CLLocationCoordinate2D] = [CLLocationCoordinate2D(latitude: 39.9791032, longitude: 32.8624661)]
    var titles : [String] = ["Home"]
    var types : [String] = ["tümü"]
    
    
    var segmentedControlValue : String?
    
    
    var coordValue : CLLocationCoordinate2D?
    var titleValue : String?
    var typeValue : String?
    
    @IBOutlet var mvMap: MKMapView!
    @IBOutlet var segmentControlOutlet: UISegmentedControl!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        mvMap.delegate = self
        
        self.configureMap()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        placePins()

    }
    
    func configureMap() {
        let center = CLLocationCoordinate2D(latitude: 39.9791032, longitude: 32.8624661)
        let span = MKCoordinateSpan(latitudeDelta: 0.125, longitudeDelta: 0.125)
        let region = MKCoordinateRegion(center: center, span: span)
        mvMap.setRegion(region, animated: true)
    }
    
    func placePins() {

        for i in coords.indices {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coords[i]
            annotation.title = titles[i]
            annotation.subtitle = types[i]
            
            mvMap.addAnnotation(annotation)
        }
    }
    
    
    func placePins(segmentedControlValue : String) {

        
        for i in types.indices {
            let an = MKPointAnnotation()

            if types[i] == segmentedControlValue {
                an.coordinate = coords[i]
                an.title = titles[i]
                an.subtitle = types[i]
                mvMap.addAnnotation(an)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "MyMarker")
        
        switch annotation.subtitle! {
            case "okul":
                annotationView.markerTintColor = UIColor(red: (69.0/255), green: (95.0/255), blue: (170.0/255), alpha: 1.0)
                annotationView.glyphImage = UIImage(named: "okul")

            case "cami":
                annotationView.markerTintColor = UIColor(red: (52.0/255), green: (114.0/255), blue: (1.0/255), alpha: 1.0)
                annotationView.glyphImage = UIImage(named: "cami")

            case "posthane":
                annotationView.markerTintColor = UIColor(red: (246.0/255), green: (233.0/255), blue: (212.0/255), alpha: 1.0)
                annotationView.glyphImage = UIImage(named: "posthane")
             
            default:
                annotationView.markerTintColor = UIColor.blue
        }
        return annotationView
    }
    
    
    
    
    @IBAction func btn_Add_Action_TUI(_ sender: Any) {
        
    }
    
    
    @IBAction func sc_Selected_Type(_ sender: Any) {
        
        switch segmentControlOutlet.selectedSegmentIndex {
        case 0:
            segmentedControlValue = "tümü"
            mvMap.removeAnnotations(mvMap.annotations)
            placePins()
        case 1:
            segmentedControlValue = "cami"
            mvMap.removeAnnotations(mvMap.annotations)
            placePins(segmentedControlValue: segmentedControlValue!)
        case 2:
            segmentedControlValue = "okul"
            mvMap.removeAnnotations(mvMap.annotations)
            placePins(segmentedControlValue: segmentedControlValue!)
        case 3:
            segmentedControlValue = "posthane"
            mvMap.removeAnnotations(mvMap.annotations)
            placePins(segmentedControlValue: segmentedControlValue!)
            
        default:
            break
        }
    }
    

    
    @IBAction func windSegue(segue : UIStoryboardSegue) {
        
        coords.append(coordValue!)
        titles.append(titleValue!)
        types.append(typeValue!)
                
    }
    
}

