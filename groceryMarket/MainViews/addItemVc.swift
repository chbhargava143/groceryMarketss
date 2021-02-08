//
//  addItemVc.swift
//  groceryMarket
//
//  Created by bhargava on 07/02/21.
//  Copyright © 2021 bhargava. All rights reserved.
//

import UIKit
import Gallery
import JGProgressHUD
import NVActivityIndicatorView
class addItemVc: UIViewController {
    @IBOutlet weak var titleText_Field:UITextField!
    @IBOutlet weak var priceText_Field:UITextField!
    @IBOutlet weak var descriptionText_View:UITextView!
    
    
    // MARK :- vars
    var category:Category!
    var gallery : GalleryController!
    var hud = JGProgressHUD(style: .dark)
    var activityIndicator : NVActivityIndicatorView?
    
    var itemImages : [UIImage?] = []
    // MARK: - life cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width / 2 - 30, y: self.view.frame.height / 2 - 30, width: 60, height: 60), type: .ballPulse, color: #colorLiteral(red:0.9999,green:0.4941,blue:0.4734,alpha:1)  , padding: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
print(category?.id ?? "")
        // Do any additional setup after loading the view.
    }
    @IBAction func CameraBtnPressed(_ sender:Any){
        itemImages = []
        showImageGallery()
    }
    @IBAction func doneBarBtnPressed(_ sender:Any){
           dissmissKeyBoard()
        if fieldsAreCmpltd(){
            saveToFirebase()
            print("we have values")
        }else {
            print("Error all fields are required")
            // show error to the User
            
        }
       }

    @IBAction func didTapDismiss(_ sender: Any) {
        dissmissKeyBoard()
    }
    // MARK: - Activity Indicator
    private func showLoadingIndicator(){
        guard let ActIndicator = activityIndicator else {
            return
        }
        if ActIndicator != nil{
            self.view.addSubview(ActIndicator)
            ActIndicator.startAnimating()
        }
        
    }
    private func hideLoadingIndicator(){
        guard let ActIndicator = activityIndicator else {
            return
        }
        if ActIndicator != nil{
                   self.view.addSubview(ActIndicator)
                   ActIndicator.stopAnimating()
               }
        ActIndicator.removeFromSuperview()
        ActIndicator.stopAnimating()
        
    }
    
    // MARK: -
    private func dissmissKeyBoard(){
        self.view.endEditing(true)
    }
    private func fieldsAreCmpltd() -> Bool{
        
        return (titleText_Field.text != "" && priceText_Field.text != "" && descriptionText_View.text != "")
    }
    private func popTheView(){
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - save item
    private func saveToFirebase() {
        showLoadingIndicator()
        let item = Item()
        item.id = UUID().uuidString
        item.name = titleText_Field.text!
        item.categoryId = category.id
        item.description = descriptionText_View.text
        item.price = Double(priceText_Field.text!)
        if itemImages.count > 0 {
            uploadImages(itemImages, item.id) { (imageLinkArray) in
                item.imageLinks = imageLinkArray
                saveItemToFirestore(item)
                self.popTheView()
                self.hideLoadingIndicator()
            }
        } else {
            saveItemToFirestore(item)
            popTheView()
        }
    }
    // MARk: - gallery
    private func showImageGallery(){
        self.gallery = GalleryController()
        self.gallery.delegate = self
        Config.tabsToShow = [.imageTab,.cameraTab]
        Config.Camera.imageLimit = 6
        self.present(self.gallery, animated: true, completion: nil)
    }
}
extension addItemVc:GalleryControllerDelegate{
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        if images.count > 0{
            Image.resolve(images: images) { (resultImages) in
                self.itemImages = resultImages
            }
        }
        
        
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
