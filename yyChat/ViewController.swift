//
//  ViewController.swift
//  yyChat
//
//  Created by 濱田裕史 on 2018/08/12.
//  Copyright © 2018年 濱田裕史. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var send: UIButton!
    @IBOutlet weak var messages: UITextView!
    var database: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        database = Database.database().reference().child("messages")
        
        database.observe(.childAdded, with: { [weak self] snapshot in
            if let data = snapshot.value as? Dictionary<String, AnyObject> {
                if let name = data["name"], let message = data["message"] {
                    self?.messages.text.append("\(name): \(message)\n")
                    return
                }
            }
        })
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func send(_ sender: Any) {
        guard let name = nameTextField.text else {
            return
        }
        
        guard let message = messageTextField.text else {
            return
        }
        
        let data = ["name": name, "message": message]
        database.childByAutoId().setValue(data)
        messageTextField.text = ""
    }
    
}

