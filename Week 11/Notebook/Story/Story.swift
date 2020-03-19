//
//  Story.swift
//  CustomCellDemo
//
//  Created by Anna Maria on 13/03/2020.
//  Copyright © 2020 Anna Maria. All rights reserved.
//

import Foundation
class Story {
    
    var text:String = ""
    var image:String = ""
    
    init(txt:String, img:String){
        text = txt
        image = img
    }
    
    func hasImage() -> Bool {
        return image.count > 0 // returns true if there is some image string
    }
}
