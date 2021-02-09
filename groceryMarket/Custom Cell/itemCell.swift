//
//  itemCell.swift
//  groceryMarket
//
//  Created by bhargava on 09/02/21.
//  Copyright © 2021 bhargava. All rights reserved.
//

import UIKit

class itemCell: UITableViewCell {
    @IBOutlet weak var nameLbl:UILabel!
    @IBOutlet weak var priceLbl:UILabel!
    @IBOutlet weak var descriptionLbl:UILabel!
    @IBOutlet weak var itemImage:UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func generateCell(_ item:Item){
         
           nameLbl.text = item.name
        priceLbl.text = convertTocurrency(item.price)
        priceLbl.adjustsFontSizeToFitWidth = true
            //String(item.price)
        descriptionLbl.text = item.description
        if item.imageLinks != nil && item.imageLinks.count > 0{
            downloadImages([item.imageLinks.first!]) { (allImages) in
                self.itemImage.image = allImages.first as? UIImage
            }
        }
       }
}
