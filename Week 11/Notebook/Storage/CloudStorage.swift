//
//  CloudStorage.swift
//  FirebaseHelloWorld
//
//  Created by Anna Maria on 28/02/2020.
//  Copyright © 2020 Anna Maria. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class CloudStorage {
    
    private static let storage = Storage.storage()
    private static let db = Firestore.firestore()
    private static var imageCounter = 0
    
    // Week 10 code - upload & download image Firebase
    static func downloadImage(name:String, vc:ViewController){
        let imgRef = storage.reference(withPath: name)
            imgRef.getData(maxSize: 4000000) { (data, error) in
                if error == nil{
                print("Sucess downloading image")
                let img = UIImage(data: data!)
                    DispatchQueue.main.async {  //prevent secondary thread to interrupt main thread
                        vc.imageView.image = img }
                    }else{
                    print("Error")
                }
            }
    }
    
    static func uploadImage(image: UIImage){
        let rawData = image.cgImage?.dataProvider?.data as Data?
        //create reference to the image to be uploaded
        let riversRef = storage.reference().child(String(imageCounter) + ".jpg")
        let uploadTask = riversRef.putData(rawData!, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                print("error uploading image")
                return
            }
            print("image uploaded succesfully!")
            }
            imageCounter += 1
    }
    
}
