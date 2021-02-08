//
//  item.swift
//  groceryMarket
//
//  Created by bhargava on 07/02/21.
//  Copyright © 2021 bhargava. All rights reserved.
//

import Foundation
import UIKit


class Item{
    var id : String!
    var categoryId : String!
    var name : String!
    var description : String!
    var price : Double!
    var imageLinks : [String]!
    init() {
        
    }
    init(_ dictionary:NSDictionary) {
        id = dictionary[KOBJECTID] as? String
        categoryId = dictionary[KCATEGORYID] as? String
        description = dictionary[KDESCRIPTION] as? String
        name = dictionary[KNAME] as? String
        price = dictionary[KPRICE] as? Double
        imageLinks = dictionary[KIMAGELINKS] as? [String]
    }
     
}
// MARK: - save items func
func saveItemToFirestore(_ item : Item){
    FirebaseReference(.Items).document(item.id).setData(itemDictionaryFrom(item) as! [String:Any])
}

// MARK:- Helper functions

func itemDictionaryFrom(_ item : Item) -> NSDictionary{
    return NSDictionary(objects: [item.id as Any,item.categoryId as Any,item.name as Any,item.description as Any,item.price as Any,item.imageLinks as Any], forKeys: [KOBJECTID as NSCopying, KCATEGORYID as NSCopying, KNAME as NSCopying, KDESCRIPTION as NSCopying,KPRICE as NSCopying, KIMAGELINKS as NSCopying])
}

// MARK:- download func
func downloadItemsFromFirebase( withCategoryId:String,completion : @escaping(_ itemsArray:[Item])->Void){
    var itemArray :[Item] = []
    FirebaseReference(.Items).whereField(KCATEGORYID, arrayContains: withCategoryId).getDocuments { (snapshot, error) in
        guard let snapshot = snapshot else {
            completion(itemArray)
            return
        }
        if !snapshot.isEmpty {
            for itemDict in snapshot.documents{
                itemArray.append(Item(itemDict.data() as NSDictionary))
            }
        }
        completion(itemArray)
    }
    
    
    
}
