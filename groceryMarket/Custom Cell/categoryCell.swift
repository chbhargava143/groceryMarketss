//
//  categoryCell.swift
//  grocery
//
//  Created by bhargava on 04/02/21.
//

import UIKit

class categoryCell: UICollectionViewCell {
    @IBOutlet weak var categoryImage:UIImageView!
    @IBOutlet weak var categoryNameLbl:UILabel!
    func generateCell(_ category:Category){
        DispatchQueue.main.async {
            self.categoryImage.image = category.image
        }
        categoryNameLbl.text = category.name
        
    }
    
}
extension categoryCell{
    func shadowDecorate(radius:CGFloat) {
        
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.layer.masksToBounds = true
    
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
}
