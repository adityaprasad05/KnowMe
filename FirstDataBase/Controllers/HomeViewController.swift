//
//  ViewController.swift
//  FirstDataBase
//
//  Created by Aditya Prasad on 6/4/20.
//  Copyright © 2020 Aditya Prasad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
class HomeViewController: UIViewController {

    @IBOutlet var uiView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var activity1: UITextField!
    @IBOutlet weak var activity2: UITextField!
    @IBOutlet weak var activity3: UITextField!
    @IBOutlet weak var timeOwnerLabel: UILabel!
    
   var docRef: DocumentReference!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 0/255, green: 191/255, blue: 255/255, alpha: 1)
        // Do any additional setup after loading the view.
        
        setUpElements()
       // let userId = Auth.auth().currentUser!.uid
        //docRef = Firestore.firestore().document("users/\(userId)")
        // newDocument.setData(["Chemistry":3, "Basketball":2, "Volunteering":1, "Activities":newDocument.documentID])
        //db.collection("users").document("activities")
    
      
    }
    func setUpElements() {
        Utilities.styleHollowButton(saveButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    /*func setUpElements() {
        errorLabel.alpha = 0
    }
    */
    
   @IBAction func saveButtonPressed(_ sender: UIButton) {
      
   /* guard let name = nameTextFIeld.text, !name.isEmpty else {return}
    guard let homework = homeworkTextField.text, !homework.isEmpty else {return}
    guard let extracurricular = extracurricularTextField.text, !extracurricular.isEmpty else {return}
    
    let dataToSave : [String: Any] = ["name" : name,"homework": homework, "extracurricular": extracurricular]
    
        docRef.setData(dataToSave) { (error) in
            if let error = error {
               print("Oh no! Got an Error: \(error.localizedDescription)")
           }
           else {
               print("Data Saved")
            }
            
      */
    
    let act1 = activity1.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let act2 = activity2.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let act3 = activity3.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let db = Firestore.firestore()
    let userId = Auth.auth().currentUser!.uid
    //let newDocument = db.collection("users").document(userId)
    db.collection("users").document(userId).collection("activities").document("activity 1").setData(["activityName":act1])
    db.collection("users").document(userId).collection("activities").document("activity 2").setData(["activityName":act2])
    db.collection("users").document(userId).collection("activities").document("activity 3").setData(["activityName":act3])
    }

    
    @IBAction func toDoList(_ sender: UIButton) {
        
        transitionToToDoList()
    }
    
    func transitionToToDoList() {
        let activityNavigationViewController = storyboard?.instantiateViewController(identifier: ActivityyConstants.storyboard.activityNavigationController)
        
        view.window?.rootViewController = activityNavigationViewController
        view.window?.makeKeyAndVisible()
        
    }

}
    
    
    


