//
//  AddRestaurantController.swift
//  FoodPin
//
//  Created by KlayThompson on 2017/3/15.
//  Copyright © 2017年 AppCoda. All rights reserved.
//

import UIKit
import CoreData

class AddRestaurantController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var typeTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var yesButton: UIButton!
    
    @IBOutlet weak var noButton: UIButton!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    var restaurant:RestaurantMO!
    var isVisited = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
   
    @IBAction func saveButtonClick(_ sender: UIBarButtonItem) {
        
        var tipMessageString = ""
        
        if phoneTextField.text == "" {
            tipMessageString = "We can't proceed because one of the fields is blank. Please note that all fields are required."
        }
        
        if locationTextField.text == "" {
            tipMessageString = "We can't proceed because one of the fields is blank. Please note that all fields are required."
        }
        
        if typeTextField.text == "" {
            tipMessageString = "We can't proceed because one of the fields is blank. Please note that all fields are required."
        }
        
        if nameTextField.text == "" {
            tipMessageString = "We can't proceed because one of the fields is blank. Please note that all fields are required."
        }
        
        if tipMessageString != "" {
            let alertTip = UIAlertController (title: "Oops", message: tipMessageString, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction (title: "OK", style: .cancel, handler: nil)
            
            alertTip.addAction(cancelAction)
            
            self.present(alertTip, animated: true, completion: nil)
            
            return
        }
        
        
       self.saveRestaruantData()
        
        
        performSegue(withIdentifier: "unwindToHomeScreen", sender: self)
    }

    
    func saveRestaruantData() {
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            
            restaurant = RestaurantMO (context: appDelegate.persistentContainer.viewContext)
            restaurant.name = nameTextField.text
            restaurant.location = locationTextField.text
            restaurant.type = typeTextField.text
            restaurant.isVisited = isVisited
            restaurant.phone = phoneTextField.text
            
            if let restaruantImage = photoImageView.image {
                if let imageData = UIImagePNGRepresentation(restaruantImage) {
                    restaurant.image = NSData (data: imageData)
                }
            }
            
            print("Saving data to context ...")
            appDelegate.saveContext()
        }
        
    }
    
    @IBAction func toggleBeenHereButton(_ sender: UIButton) {
        
        
        
        if sender == yesButton {
            isVisited = true
            yesButton.backgroundColor = UIColor.red
            noButton.backgroundColor = UIColor.lightGray
        } else if sender == noButton {
            isVisited = false
            yesButton.backgroundColor = UIColor.lightGray
            noButton.backgroundColor = UIColor.red
        }
    
    }
    
    
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                present(imagePicker, animated: true, completion: nil)
            }
        }
    }

   //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let selectImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoImageView.image = selectImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        
        
        let leadingConstraint = NSLayoutConstraint (item: photoImageView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        leadingConstraint.isActive = true
        
        let trailingConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal,
        toItem: photoImageView.superview, attribute: NSLayoutAttribute.trailing,
        multiplier: 1, constant: 0)
        trailingConstraint.isActive = true
        let topConstraint = NSLayoutConstraint(item: photoImageView, attribute:
            NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem:
            photoImageView.superview, attribute: NSLayoutAttribute.top, multiplier: 1,
                                      constant: 0)
        topConstraint.isActive = true
        let bottomConstraint = NSLayoutConstraint(item: photoImageView, attribute:
            NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem:
            photoImageView.superview, attribute: NSLayoutAttribute.bottom, multiplier: 1,
                                      constant: 0)
        bottomConstraint.isActive = true
        
        dismiss(animated: true, completion: nil)
    }
    
}
