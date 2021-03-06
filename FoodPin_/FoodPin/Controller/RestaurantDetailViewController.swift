//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Simon Ng on 20/7/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import MapKit
import ZYBannerView

class RestaurantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
//    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var tableView:UITableView!
    @IBOutlet weak var bannerView: ZYBannerView!
    
    
    var restaurant:RestaurantMO!
    var localImages: [UIImage]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.dataSource = self

        localImages = restaurant.images as? [UIImage]
        
//        restaurantImageView.image = UIImage(data: restaurant.image! as Data)
        
        tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        
        title = restaurant.name
        
        navigationController?.hidesBarsOnSwipe = false
        
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let tapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(showMap))
        mapView.addGestureRecognizer(tapGestureRecognizer)
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location!, completionHandler: {
            placemarks, error in
            if error != nil {
                print(error ?? "")
                return
            }
            if placemarks != nil {
                
                // Get the first placemark
                let placemark = placemarks?[0]
                
                // Add annotation
                let annotation = MKPointAnnotation()
                
                if let location = placemark?.location {
                    
                    // Display the annotation
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    
                    // Set the zoom level
                    let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 250, 250)
                    self.mapView.setRegion(region, animated: true)
                }
            }
            
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - UITableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantDetailTableViewCell
        
        // Configure the cell...
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = NSLocalizedString("Name", comment: "Name Field")
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurant.location
        case 3:
            cell.fieldLabel.text = "Phone"
            cell.valueLabel.text = restaurant.phone
        case 4:
            cell.fieldLabel.text = "Been here"
            cell.valueLabel.text = (restaurant.isVisited) ? "Yes, I've been here before. \(String(describing: restaurant.rating))" : "No"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    } 
    
    @IBAction func close(segue: UIStoryboardSegue) {
    
        
        
    }
    
    @IBAction func ratingButtonTapped(segue:UIStoryboardSegue) {
        
        if let rating = segue.identifier {
            
            restaurant.isVisited = true
            switch rating {
            case "great": restaurant.rating = "Absolutely love it! Must try."
            case "good": restaurant.rating = "Pretty good."
            case "dislike": restaurant.rating = "I don't like it."
            default: break
                
            }
            
        }
        
        if let app = (UIApplication.shared.delegate as? AppDelegate) {
            app.saveContext()
        }
        
        tableView.reloadData()
    }
    
    func showMap() {
        performSegue(withIdentifier: "showMap", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReview" {
            let destinationController = segue.destination as! ReviewViewController
            destinationController.restaurant = restaurant
        } else if segue.identifier == "showMap" {
            let destinationController = segue.destination as! MapViewController
            destinationController.restaurant = restaurant
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RestaurantDetailViewController: ZYBannerViewDataSource {

    func numberOfItems(inBanner banner: ZYBannerView!) -> Int {
        return localImages?.count ?? 0
    }
    
    func banner(_ banner: ZYBannerView!, viewForItemAt index: Int) -> UIView! {
        
        guard let image = localImages?[index] else {
            return UIView()
        }
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }
    
    func banner(_ banner: ZYBannerView!, titleForFooterWith footerState: ZYBannerFooterState) -> String! {
        return "别扯了，扯坏了"
    }
    
}
