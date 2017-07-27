//
//  DiscoveryTableViewCell.swift
//  FoodPin
//
//  Created by KlayThompson on 2017/3/23.
//  Copyright © 2017年 AppCoda. All rights reserved.
//

import UIKit

class DiscoveryTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var adressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCellDataWithRestaurantMO(restaurantMO: RestaurantMO) {
        
        restaurantImageView.image = UIImage (data: restaurantMO.image! as Data)
        nameLabel.text = restaurantMO.name
        typeLabel.text = restaurantMO.type
        adressLabel.text = restaurantMO.location
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
