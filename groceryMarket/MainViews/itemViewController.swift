//
//  itemViewController.swift
//  groceryMarket
//
//  Created by bhargava on 09/02/21.
//  Copyright © 2021 bhargava. All rights reserved.
//

import UIKit

class itemViewController: UIViewController {
    var items:Item!
    @IBOutlet weak var itemTextView: UITextView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = items.name
        itemDetial(items)
        
    }
    
    func itemDetial(_ item:Item){
           
        titleLbl.text = item.name ?? ""
          priceLbl.text = convertTocurrency(item.price)
          priceLbl.adjustsFontSizeToFitWidth = true
              //String(item.price)
          descriptionLbl.text = item.description
//          if item.imageLinks != nil && item.imageLinks.count > 0{
//              downloadImages([item.imageLinks.first!]) { (allImages) in
//                  self.itemImage.image = allImages.first as? UIImage
//              }
//          }
         }

}
