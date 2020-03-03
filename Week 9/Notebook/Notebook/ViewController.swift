//
//  ViewController.swift
//  Notebook
//
//  Created by Anna Maria on 03/03/2020.
//  Copyright © 2020 Anna Maria. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var TextView: UITextView!
    @IBOutlet weak var SaveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func saveButton(_ sender: UIButton) {
        //get text from TextField and TextView
        let head = TextField.text ?? ""
        let body = TextView.text ?? ""
        
        CloudStorage.newNote(head: head, body: body)
    }

}
