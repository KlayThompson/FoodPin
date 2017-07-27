//
//  WalkthroughContentViewController.swift
//  FoodPin
//
//  Created by KlayThompson on 2017/3/18.
//  Copyright © 2017年 AppCoda. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var headingLabel: UILabel!
    
    @IBOutlet weak var contentImageView: UIImageView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    var index = 0
    var heading = ""
    var imageFile = ""
    var content = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        headingLabel.text = heading
        contentLabel.text = content
        contentImageView.image = UIImage (named: imageFile)
        
        pageControl.currentPage = index
        
        switch index {
        case 0...1:
            forwardButton.setTitle("NEXT", for: .normal)
        case 2:
            forwardButton.setTitle("DONE", for: .normal)
        default:
            break
        }
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        switch index {
        case 0...1:
            let pageViewController = parent as! WalkthroughPageViewController
            pageViewController.forward(index: index)
        case 2:
            UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
            
            // Add Quick Actions
            if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                let bundleIdentifier = Bundle.main.bundleIdentifier
                
                let shortcutItem1 = UIApplicationShortcutItem (type: "\(String(describing: bundleIdentifier)).OpenFavorites", localizedTitle: "Show Favorites", localizedSubtitle: nil, icon: UIApplicationShortcutIcon (templateImageName: "favorite-shortcut"), userInfo: nil)
                let shortcutItem2 = UIApplicationShortcutItem(type: "\(String(describing: bundleIdentifier)).OpenDiscover", localizedTitle: "Discover restaurants",
                    localizedSubtitle: nil, icon: UIApplicationShortcutIcon(templateImageName:
                        "discover-shortcut"), userInfo: nil)
                let shortcutItem3 = UIApplicationShortcutItem (type: "\(String(describing: bundleIdentifier)).NewRestaurant", localizedTitle: "NewRestaurant", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(type:.add), userInfo: nil)
                
                UIApplication.shared.shortcutItems = [shortcutItem1,shortcutItem2,shortcutItem3]
            }
            
            dismiss(animated: true, completion: nil)
        default:
            break
        }
        
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
