//
//  AlertController.swift
//  GrupoFlecha
//
//  Created by Davi Rodrigues on 05/03/16.
//  Copyright © 2016 Davi Rodrigues. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class AlertController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Inicializa mapa a partir da posição do usuário
        self.map.showsUserLocation = true
        self.map.zoomEnabled = true
        
        //Configura CLLocationManager
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.requestAlwaysAuthorization()
        
        //Inicializa texto da UITextView
        if(AlertSource.casosDeDengue > 0) {
            self.textView.text = AlertSource.alertaSimples
        }
        
        //Configura propriedades da UITextView
        textView.font = UIFont(name: "Helvetica", size: 20)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        //Zoom no mapa para posição do usuário
        if let coordinate = map.userLocation.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000)
            map.setRegion(region, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: MapKit
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
        let coor = self.map.userLocation.location?.coordinate
        let region = MKCoordinateRegionMakeWithDistance(coor!, 1000, 1000)
        self.map.setRegion(region, animated: true)
        
        self.updateAnnotations()
        
    }
    
    func updateAnnotations() {
        self.map.removeAnnotations(map.annotations)
        self.map.removeOverlays(map.overlays)
        
        let anotation2 = MKPointAnnotation()
        anotation2.coordinate = map.userLocation.coordinate
        anotation2.title = "The Location"
        anotation2.subtitle = "This is the location !!!"
        map.addAnnotation(anotation2)
        
        
        let annotation = MKCircle(centerCoordinate: map.userLocation.coordinate, radius: 300)
        
        annotation.title = "Casos de dengue"
        annotation.subtitle = "ahhhh"
        map.addOverlay(annotation)
        
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let circleRenderer = MKCircleRenderer(overlay: overlay)
            circleRenderer.lineWidth = 1.0
            //Cor do circulo
            if(AlertSource.casosDeDengue == 0) {
                circleRenderer.strokeColor = UIColor.greenColor()
                circleRenderer.fillColor = UIColor.greenColor().colorWithAlphaComponent(0.4)
            } else if(AlertSource.casosDeDengue == 1) {
                circleRenderer.strokeColor = UIColor.yellowColor()
                circleRenderer.fillColor = UIColor.yellowColor().colorWithAlphaComponent(0.4)
            } else {
                circleRenderer.strokeColor = UIColor.redColor()
                circleRenderer.fillColor = UIColor.redColor().colorWithAlphaComponent(0.4)
            }
            return circleRenderer
        }
        //Possivel bug
        return MKOverlayRenderer()
    }
}
