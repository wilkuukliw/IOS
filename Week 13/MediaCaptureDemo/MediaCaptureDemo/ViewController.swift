//
//  ViewController.swift
//  MediaCaptureDemo
//
//  Created by Anna Maria on 27/03/2020.
//  Copyright © 2020 Anna Maria. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    var imagePicker = UIImagePickerController() // will handle task of fetching an image from the iOS system
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self // assign the OBJECT from this class to handle imae picking events
     
    }

    @IBAction func photosBtnPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary  // what type of tast: camera of photoalbum
        imagePicker.allowsEditing = true // should user be able to zoom in before getting the image
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraPhotoBtnPressed(_ sender: UIButton) {
        imagePicker.sourceType = .camera
        imagePicker.showsCameraControls = true
        imagePicker.allowsEditing = true
         present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraVideoBtnPressed(_ sender: UIButton) {
        imagePicker.mediaTypes = ["public.movie"] // will launch the video in the camera app
        imagePicker.videoQuality = .typeMedium
        launchCamera()
    }
    
    @IBAction func addTextBtnPressed(_ sender: Any) {
        let input = textField.text!
        let output = NSAttributedString(string: input, attributes: [.font:UIFont(name: "Arial", size: 100)!, .foregroundColor: UIColor.systemPink])
        imageView.image = UIGraphicsImageRenderer(size:imageView.image!.size).image {
            _ in
            imageView.image!.draw(at:.zero)
            output.draw(at:CGPoint(x:30, y:imageView.image!.size.height-150))
        }
    }
    
    fileprivate func launchCamera() {
        imagePicker.sourceType = .camera
        imagePicker.showsCameraControls = true
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        if imageView.image != nil {
        UIImageWriteToSavedPhotosAlbum(imageView.image!, nil, nil, nil);
        print("Image saved!")
        }
    }

    @IBAction func resizeBtnPressed(_ sender: UIButton) {
        if imageView.image != nil {
            imageView.image = resizeImage(image: imageView.image!, targetSize: CGSize(width:150, height: 150))
            print("Image resized!")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("returned from image picking")
        // we either have an image, or a video
        // 1. if this is a video, do this
        if let url = info[.mediaURL] as? URL {  // this will only be true, if there is a video
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path) {
            UISaveVideoAtPathToSavedPhotosAlbum(url.path, nil, nil, nil)  //minimal version of save
            }
        }else{ //2.if we have image
    
            let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            //UIImageWriteToSavedPhotosAlbum(imageView.image!, nil, nil, nil);
            imageView.image = image
        }
        picker.dismiss(animated: true, completion:nil)
    }
    
    // register touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch began ")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let p = touches.first?.location(in: view){
                print("moved to: \(p)")
            // get the difference of your finger movement
            imageView.transform = CGAffineTransform(translationX: p.x, y: 0)
        }
    }
    
    //resize image
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize : CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        }else{
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}

