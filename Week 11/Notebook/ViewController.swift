//
//  ViewController.swift
//  Notebook
//
//  Created by Anna Maria on 03/03/2020.
//  Copyright © 2020 Anna Maria. All rights reserved.
//

import UIKit
import FirebaseStorage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource{

    let imagePicker = UIImagePickerController()
    var images = [String]()
    var stories = [Story]()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var btnGallery: UIButton!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        stories.append(Story(txt: "hi!", img: ""))
        stories.append(Story(txt: "bye", img: "Cat1"))
        tableView.dataSource = self //assign this class to handle data for the tableView
        tableView.delegate = self
        
    }
    
    @IBAction func galleryPressed(_ sender: Any) {
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if stories[indexPath.row].hasImage() { //handle the case with image
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? TableViewCellTextAndImage {
                cell.myLabel.text = stories[indexPath.row].text
                cell.myImgeView.image = UIImage(named: stories[indexPath.row].image)
                return cell
            }
            
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? TableViewCellTextOnly {
                
                cell.myLabel.text = stories[indexPath.row].text
                return cell
            }
        }
            return UITableViewCell()
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return stories[indexPath.row].hasImage() ? 250 : 80 // ternary operator - just if statement in one line
    }
}
