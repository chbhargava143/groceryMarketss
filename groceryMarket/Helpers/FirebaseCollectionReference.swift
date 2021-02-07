//
//  FirebaseCollectionReference.swift
//  grocery
//
//  Created by bhargava on 04/02/21.
//

import Foundation
import FirebaseFirestore

enum FcollectionReference:String{
    case User
    case Category
    case Items
    case Basket
}

func FirebaseReference(_ collectionReference:FcollectionReference) -> CollectionReference{
    
    return Firestore.firestore().collection(collectionReference.rawValue)
}
