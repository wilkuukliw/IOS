//
//  ViewController.swift
//  MyNoteBook
//
//  Created by Anna Maria on 14/02/2020.
//  Copyright © 2020 Anna Maria. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var theText = "Starting here.."
    var textArray = [String]() // we initialize an empty String array
    var currentRowToEdit = -1 // -1 means no editing
    //var fileName = "theString.txt"
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() { //will only get called once, at launch
        super.viewDidLoad()
        textArray.append("hello")
        textArray.append("how are you")
        tableView.dataSource = self
        tableView.delegate = self
    
    }
    override func viewWillAppear(_ animated: Bool) {
        textView.text = theText
    }

    @IBAction func saveView(_ sender: UIButton) {
        theText = textView.text
        if currentRowToEdit > -1 {
            textArray[currentRowToEdit] = theText
            currentRowToEdit = -1
        } else {
            textArray.append(theText) //add the new text to the array
            
        }
        tableView.reloadData()
        textView.text = ""
       // saveStringToFile(str: theText, fileName: fileName)
       // print(readStringFromFile(fileName: fileName))
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")   //reuse cells
        cell?.textLabel?.text = textArray[indexPath.row]  //assign new String
        return cell! //unwrap the box around it, for sure there will be a value . if could be used here instead of '!'
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you clicked \(indexPath.row)")
        currentRowToEdit = indexPath.row
        textView.text = textArray[currentRowToEdit]
    }
    
   // func  saveStringToFile(str:String, fileName:String) {
    //    let filePath = getDocumentDir().appendingPathComponent(fileName)
      //  do {
        //    try str.write(to: filePath, atomically: true, encoding: .utf8)
            
           // print("OK writing string \(str)")
        //}catch{
          //  print("error writing string\(str)")
        //}
    //}
    
    //func getDocumentDir() -> URL{
       // let documentDir = FileManager.default.urls(for: .documentDirectory, in: //.userDomainMask)
       //     return documentDir[0]
        
  //  }
}



