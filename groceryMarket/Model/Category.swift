//
//  Category.swift
//  grocery
//
//  Created by bhargava on 04/02/21.
//

import Foundation
import Firebase
import UIKit
class Category {
    var id : String
    var name : String
    var image : UIImage?
    var imageName : String?
    init(_name:String,_imageName:String) {
        self.id = ""
        self.name = _name
        self.imageName = _imageName
        self.image = UIImage(named:_imageName )
        
    }
    init(_dictionary:NSDictionary) {
        id = _dictionary[KOBJECTID] as! String
        name = _dictionary[KNAME] as! String
        image = UIImage(named:_dictionary[KIMAGENAME] as? String ?? "")
        
    }
}
// MARK :- Download data From Storage.
func downloadcategoriesFromFirebase(_ completion : @escaping (_ categoryArray:[Category]) -> Void){
    var categoryArray:[Category] = []
    FirebaseReference(.Category).getDocuments { (snapShot, error) in
        guard let snapshot = snapShot else {
            completion(categoryArray)
            return
        }
        if !snapshot.isEmpty {
            for categoryDict in snapshot.documents{
               // print("New category with name ")
                categoryArray.append(Category(_dictionary: categoryDict.data() as NSDictionary))
                
            }
            
        }
        completion(categoryArray)
    }
}
//MARK :- Save category Functions
func saveCategoryToFirebase(_ category:Category){
    let id = UUID().uuidString
   
    category.id = id
    FirebaseReference(.Category).document(id).setData(categoryDictFrom(category) as! [String : Any])
//    FirebaseReference(.Category).document(id).setData(categoryDictionaryFrom(category) as! [String : Any])
}

// Helpers
func categoryDictFrom(_ category:Category) -> NSDictionary{
    return NSDictionary(objects: [category.id,category.name,category.imageName as Any], forKeys: [KOBJECTID as NSCopying ,KNAME as NSCopying,KIMAGENAME as NSCopying])
}

/*
 func categoryDictionaryFrom(_ category:Category) -> NSDictionary{
     return NSDictionary(object: [category.id,category.name,category.imageName], forKey: [KOBJECTID as NSCopying ,KNAME as NSCopying,KIMAGENAME as NSCopying]  as NSCopying )
     
 }
 */

// only once for insert categories in firebase database
func createCategorySet(){
    let womenClothing = Category(_name: "Women clothing and Accessories", _imageName: "WomenClothe")
    let footWear = Category(_name: "Foot Wear", _imageName: "Foot Wear")
    let electronics = Category(_name: "electronics", _imageName: "Electronics")
    let menClothing = Category(_name: "Men clothing and Accessories", _imageName: "MenClothe")
    let health = Category(_name: "Health & Beauty", _imageName: "Health")
    let baby = Category(_name: "Baby Stuff", _imageName: "Baby")
    let home = Category(_name: "Home & Kitchen", _imageName: "Home")
    let car = Category(_name: "Auto Mobies & MotorCycles", _imageName: "Car")
    let luggage = Category(_name: "Luggage & Bags", _imageName: "Luggage")
    let jewelery = Category(_name: "Jewelery", _imageName: "Jewelery")
    let hobby = Category(_name: "Hobby, Sport , Travelling", _imageName: "Hobby")
    let pet = Category(_name: "Pet Products", _imageName: "Pet")
    let garden = Category(_name: "Garden Supplies", _imageName: "Garden")
    let industry = Category(_name: "Industry & Business", _imageName: "Inustry")
    let camera = Category(_name: "Camera & Optics", _imageName: "Camera")
    let arrayOfCategories = [womenClothing,footWear,electronics,menClothing,health,baby,home,car,luggage,jewelery,hobby,pet,garden,industry,camera]
    for category in arrayOfCategories{
        saveCategoryToFirebase(category)
    }
}
