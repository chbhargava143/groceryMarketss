//
//  Downloader.swift
//  groceryMarket
//
//  Created by bhargava on 08/02/21.
//  Copyright © 2021 bhargava. All rights reserved.
//

import Foundation
import FirebaseStorage
let storage = Storage.storage()
func uploadImages(_ images : [UIImage?],_ itemId : String ,completion : @escaping (_ imagelinks : [String])-> Void){
    if Reachability.isConnectedToNetwork(){
        var uploadImagesCount = 0
        var imagewLinkArray : [String] = []
        var nameSuffix = 0
        for image in images{
            let fileName = "ItemImages/" + itemId + "/" + "\(nameSuffix)" + ".jpg"
            guard let imageData = image!.jpegData(compressionQuality: 0.5) else { return }
            saveImgaeInFirebase(imageData: imageData, filename: fileName) { (imageLink) in
                if imageLink != nil{
                    imagewLinkArray.append(imageLink!)
                    uploadImagesCount += 1
                    if uploadImagesCount == images.count{
                        completion(imagewLinkArray)
                    }
                }
            }
            nameSuffix += 1
        }
        
    }else{
        print("No Internet Connection")
    }
    
}


func saveImgaeInFirebase(imageData:Data,filename:String,completion : @escaping (_ imageLink:String?)-> Void){
    var task : StorageUploadTask!
    let storageRef = storage.reference(forURL: KFILEREFERENCE).child(filename)
    task = storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
        task.removeAllObservers()
        if error != nil{
            print("Error uploading Image",error?.localizedDescription)
            completion(nil)
            return
        }
        storageRef.downloadURL { (url, err) in
            guard let downloadUrl = url else { completion(nil)
                return}
            completion(downloadUrl.absoluteString)
        }
        
    })
}
func downloadImages(_ imageURl:[String],_ completion : @escaping (_ images:[UIImage?] )->Void){
    var imageArray : [UIImage] = []
    var downloadCounter = 0
    for link in imageURl {
        let url = NSURL(string: link)
        let downloadQue = DispatchQueue(label: "imageDownloadQue")
        downloadQue.async {
            downloadCounter += 1
            guard let url = url else {return }
            guard let data = NSData(contentsOf: url as URL) else {return}
            if data != nil{
                imageArray.append(UIImage(data: data as Data)!)
                
                if downloadCounter == imageArray.count{
                    DispatchQueue.main.async {
                        
                        completion(imageArray)
                    }
                }
            } else {
                print("Couldn't Download image")
                completion(imageArray)
            }
        }
    }
    
}
