//
//  MapViewController.swift
//  GrupoFlecha
//
//  Created by Davi Rodrigues on 05/03/16.
//  Copyright © 2016 Davi Rodrigues. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

let kSavedItemsKey = "savedItems"

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var mosquitoImageView: UIImageView!
    
    var locationManager = CLLocationManager()
    
    var geotifications = [Geotification]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.map.showsUserLocation = true
        self.map.zoomEnabled = true
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest//kCLLocationAccuracyNearestTenMeters
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.requestAlwaysAuthorization()
        
        self.mosquitoImageView.hidden = true
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let maxx = self.view.frame.size.width
        let maxy = self.view.frame.size.height
        
        UIView.animateWithDuration(3, delay: 0, options: .Repeat, animations: {
            
            let xoffset = CGFloat(arc4random_uniform(UInt32((maxx) + 1)))
            let yoffset = CGFloat(arc4random_uniform(UInt32((maxy) + 1)))
            
            self.mosquitoImageView.layer.frame.origin.x = xoffset
            self.mosquitoImageView.layer.frame.origin.y = yoffset
            
            }, completion: {(completion) -> Void in
                //self.mosquitoImageView.layer.frame.origin.x += xoffset
                //self.mosquitoImageView.layer.frame.origin.y += yoffset
        
        })
        
        AlertSource.getData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(manager: CLLocationManager, didFinishDeferredUpdatesWithError error: NSError?) {
        
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
        let coor = self.map.userLocation.location?.coordinate
        let region = MKCoordinateRegionMakeWithDistance(coor!, 1000, 1000)
        self.map.setRegion(region, animated: true)
        
        self.updateAnnotations()
        
    }
    
    func updateAnnotations() {
        self.map.removeAnnotations(map.annotations)
        self.map.removeOverlays(map.overlays)
        
        let annotation = MKCircle(centerCoordinate: map.userLocation.coordinate, radius: 300)
        annotation.title = "Casos de dengue"
        annotation.subtitle = "ahhhh"
        map.addOverlay(annotation)
        
        var coord1 = map.userLocation.coordinate
        coord1.latitude += 0.010/5
        coord1.longitude += 0.010/5
        var coord2 = map.userLocation.coordinate
        coord2.latitude += 0.007/5
        coord2.longitude -= 0.003/5
        AlertSource.pinCoordinates = [coord1, coord2]
        
        self.addPinCoordinates()
        
    }
    
    func addPinCoordinates() {
        for coord in AlertSource.pinCoordinates {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coord
            annotation.title = "Dengue próximo da sua casa!"
            annotation.subtitle = "Temos denuncia de um foco de dengue próximo a sua residencia"
            map.addAnnotation(annotation)
        }
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


