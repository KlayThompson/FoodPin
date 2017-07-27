//
//  MapViewController.swift
//  FoodPin
//
//  Created by KlayThompson on 2017/3/14.
//  Copyright © 2017年 AppCoda. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var restaurant: RestaurantMO!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView.delegate = self
        
        let geoCode = CLGeocoder()
        geoCode.geocodeAddressString(restaurant.location!, completionHandler: {placemarks, error in
        
            if error != nil {
                print(error ?? "")
                return
            }
            
            if placemarks != nil {
                
                let placemark = placemarks?[0]
                
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                
                if let location = placemark?.location {
                    
                    annotation.coordinate = location.coordinate
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
            
        })
        
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
        
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "MyPin"
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        
        // Reuse the annotation if possible
        var annotataionView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotataionView == nil {
            annotataionView = MKPinAnnotationView (annotation: annotation, reuseIdentifier: identifier)
            annotataionView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView (frame: CGRect.init(x: 0.0, y: 0.0, width: 53, height: 53))
        leftIconView.image  = UIImage (data: restaurant.image! as Data)
        annotataionView?.leftCalloutAccessoryView = leftIconView
        
        annotataionView?.pinTintColor = UIColor.orange
        
        return annotataionView
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
