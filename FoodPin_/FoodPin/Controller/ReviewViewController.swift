//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by KlayThompson on 2017/3/14.
//  Copyright © 2017年 AppCoda. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    var restaurant:RestaurantMO!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        backgroundImageView.image = UIImage (data: restaurant.image! as Data)
        topImageView.image = UIImage (data: restaurant.image! as Data)
        
        let blurEffect = UIBlurEffect (style: .dark)
        let blurEffectView = UIVisualEffectView (effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
//        containerView.transform = CGAffineTransform.init(scaleX: 0, y: 0)
//        containerView.transform = CGAffineTransform.init(translationX: 0, y: -1000)
        
        let scaleTransform = CGAffineTransform.init(scaleX: 0, y: 0)
        let translateTransform = CGAffineTransform.init(translationX: 0, y: -1000)
        let combineTransform = translateTransform.concatenating(scaleTransform)
        containerView.transform = combineTransform
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        UIView.animate(withDuration: 0.3) {
//            self.containerView.transform = CGAffineTransform.identity
//        }
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: { 
            self.containerView.transform = CGAffineTransform.identity
        }, completion: nil)
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
