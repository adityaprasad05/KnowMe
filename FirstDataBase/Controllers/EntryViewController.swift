//
//  EntryViewController.swift
//  FirstDataBase
//
//  Created by Aditya Prasad on 6/16/20.
//  Copyright © 2020 Aditya Prasad. All rights reserved.
//

import UIKit
import Firebase

class EntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var entryField: UITextField!
        
    var update : (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entryField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
        // Do any additional setup after loading the view.
        
    } 
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        saveTask()
        
        return true
        
    }
   
     @objc func saveTask() {
        
        guard let text = entryField.text, !text.isEmpty else {return}
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else{return}
        
        let newCount = count + 1
        
        UserDefaults().set(newCount, forKey: "count")
        
        UserDefaults().set(text, forKey: "task_\(newCount)")

        update?()
        navigationController?.popViewController(animated: true)
        
    }
}
