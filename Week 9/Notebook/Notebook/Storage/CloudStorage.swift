//
//  CloudStorage.swift
//  FirebaseHelloWorld
//
//  Created by Anna Maria on 28/02/2020.
//  Copyright © 2020 Anna Maria. All rights reserved.
//

import Foundation
import FirebaseFirestore

class CloudStorage {
    
    
    private static var list = [Note]()
    private static let db = Firestore.firestore()
    private static let notes = "notes"
    
    
    
    static func startListener(){
        
        db.collection(notes).addSnapshotListener { (snap,error) in
            if error == nil {
                self.list.removeAll()
                for note in snap!.documents {
                    let map = note.data()
                    let head = map["head"] as!String
                    let body = map["body"] as!String
                    let newNote = Note(id: note.documentID, head: head, body: body)
                    self.list.append(newNote)
                }
                
            }
        }
            
    }
    static func deleteNote(id:String) {
        let docRef = db.collection(notes).document(id)
        docRef.delete()
    }
    
    static func updateNote(index:Int, head:String, body:String){
        let note = list[index]
        //let newNote = Note(id: note.id, head: head, body: body)
        let docRef = db.collection(notes).document(note.id)
        var map = [String:String]()
        map["head"] = head
        map["body"] = body
        docRef.setData(map)
        
    }
    static func newNote(head: String, body: String){
        let docRef = db.collection(notes).document() //returns a new unique document id
        var map = [String: String]()
        map["head"] = head
        map["body"] = body
        docRef.setData(map)
    }
}
