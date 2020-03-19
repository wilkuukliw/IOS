//
//  ViewController.swift
//  Notebook
//
//  Created by Anna Maria on 03/03/2020.
//  Copyright © 2020 Anna Maria. All rights reserved.
//

import UIKit
import FirebaseStorage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    let imagePicker = UIImagePickerController()
    var images = [String]()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var btnGallery: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        imagePicker.delegate = self
    }
        
    @IBAction func galleryPressed(_ sender: AnyObject) {
        print("Gallery")
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
            
    }
    
    @IBAction func pickImageBtnClicked(_ sender: Any) {
     imagePicker.allowsEditing = false
     imagePicker.sourceType = .photoLibrary
         
     present(imagePicker, animated: true, completion: nil)
     
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            CloudStorage.uploadImage(image: pickedImage)
            
            }
        
            dismiss(animated: true, completion: nil)
        
    }
            
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
            }
    
}
