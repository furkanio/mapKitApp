//
//  VC_Add_Location.swift
//  mapKitApp
//
//  Created by Furkan Yıldız on 31.01.2022.
//

import UIKit
import MapKit

class VC_Add_Location: UIViewController,MKMapViewDelegate,UIGestureRecognizerDelegate {
    
    var coord : CLLocationCoordinate2D?
    var titleOfPin : String?
    var typeValueP : String?
    
    @IBOutlet var mvMapp: MKMapView!
    @IBOutlet var txtPinTitle: UITextField!
    
    @IBOutlet var btn_Cami: UIButton!
    @IBOutlet var btn_Okul: UIButton!
    @IBOutlet var btn_Postahane: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mvMapp.delegate = self
        configureMap()
        
        let oLongTapGesture = UILongPressGestureRecognizer(target: self, action:#selector(handleLongtapGesture(gestureRecognizer:)) )
        
        self.mvMapp.addGestureRecognizer(oLongTapGesture)
    }
    

    
    func configureMap() {
        let center = CLLocationCoordinate2D(latitude: 39.9791032, longitude: 32.8624661)
        let span = MKCoordinateSpan(latitudeDelta: 0.125, longitudeDelta: 0.125)
        let region = MKCoordinateRegion(center: center, span: span)
        mvMapp.setRegion(region, animated: true)
    }
    
        
    
    @objc func handleLongtapGesture(gestureRecognizer : UILongPressGestureRecognizer){
        
        
        if gestureRecognizer.state != UIGestureRecognizer.State.ended{
            
            let touchLocation = gestureRecognizer.location(in: mvMapp)
            
            let locationCoordinate = mvMapp.convert(touchLocation, toCoordinateFrom: mvMapp)
            let an = MKPointAnnotation()
            an.coordinate = locationCoordinate
            coord = locationCoordinate
            
            mvMapp.addAnnotation(an)

        }
        
        if gestureRecognizer.state != UIGestureRecognizer.State.began {
            return
        }
        
    }
    
    @IBAction func radioButtons(_ sender: UIButton) {
        
        if sender.tag == 1 {
            btn_Cami.isSelected = true
            btn_Okul.isSelected = false
            btn_Postahane.isSelected = false
            typeValueP = "cami"
            
        } else if sender.tag == 2 {
            btn_Cami.isSelected = false
            btn_Okul.isSelected = true
            btn_Postahane.isSelected = false
            typeValueP = "okul"
            
        } else if sender.tag == 3 {
            btn_Cami.isSelected = false
            btn_Okul.isSelected = false
            btn_Postahane.isSelected = true
            typeValueP = "posthane"
            
        }
    }
    
    
    @IBAction func btn_Save_Pin_TUI(_ sender: Any) {
        
        if txtPinTitle.text != "" && typeValueP != nil && coord != nil {
            
            titleOfPin = txtPinTitle.text
            performSegue(withIdentifier: "sg2to1", sender: nil)

        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        if segue.identifier == "sg2to1" {
            let vc = segue.destination as! ViewController
            vc.coordValue = coord
            vc.titleValue = titleOfPin
            vc.typeValue = typeValueP
            
        }
        
    }
    

}
