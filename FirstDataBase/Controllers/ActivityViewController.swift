//
//  ViewController.swift
//  FirstDataBase
//
//  Created by Aditya Prasad on 6/17/20.
//  Copyright © 2020 Aditya Prasad. All rights reserved.
//

import UIKit
import Firebase
class ActivitiesViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var activities = [String]()
    var activityGlobal = ""
    //let cellId = "cellID"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.register(TimeTableViewCell.self, forCellReuseIdentifier: cellId)
        loadData()
        self.view.backgroundColor = UIColor.init(red: 0/255, green: 191/255, blue: 200/255, alpha: 1)
        self.tableView.backgroundColor = UIColor.init(red: 0/255, green: 191/255, blue: 200/255, alpha: 1)

    }
    @IBAction func addButtonTapped() {

        let alert = UIAlertController(title: "Add Activity", message: nil, preferredStyle: .alert)
                alert.addTextField { (dessertTF) in
                    dessertTF.placeholder = "Enter Activity"
                }
                let action = UIAlertAction(title: "Add", style: .default) { (_) in
                    guard let activity = alert.textFields?.first?.text else { return }

                    print(activity)
                    let db = Firestore.firestore()
                    let uid = Auth.auth().currentUser!.uid
                    db.document("users/\(uid)/activities/\(activity)").setData(["activity":activity])
                    self.activities.append(activity)
                    self.tableView.reloadData()
                   // self.add(activity)
                }
                alert.addAction(action)
                present(alert, animated: true)
    
            }
            
           /* func add(_ activity: String) {
                let index = 0
                activities.insert(activity, at: index)
                
                let indexPath = IndexPath(row: index, section: 0)
                tableView.insertRows(at: [indexPath], with: .left)
            }
*/
     
    @IBAction func backPressed(_ sender: Any) {
       
        transitionToWelcome()

    }
    @IBAction func nextPressed(_ sender: Any) {
        transitionToTime()
    }
    func transitionToWelcome() {
               let welcomeNavigationController = self.storyboard?.instantiateViewController(identifier: LogInConstants.storyboard.welcomeNavigationController)
                                  self.view.window?.rootViewController = welcomeNavigationController
                                  self.view.window?.makeKeyAndVisible()
           }
    func transitionToTime() {
    
    let timeNavigationViewController = storyboard?.instantiateViewController(identifier: TimeConstants.storyboard.timeNavigationViewController)
                   
                   view.window?.rootViewController = timeNavigationViewController
                   view.window?.makeKeyAndVisible()
                   
               }
    
    func loadData() {
       let db = Firestore.firestore()
       let userID = Auth.auth().currentUser!.uid

       db.collection("users/\(userID)/activities").getDocuments() { (QuerySnapshot, err) in
           if let err = err {
               print("Error getting documents : \(err)")
           }
           else {
               for document in QuerySnapshot!.documents {
                   let documentID = document.documentID
                   self.activities.append(documentID)
                   }
               self.tableView.reloadData()
               }
           }
       }
    
}
extension ActivitiesViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()
               let dessert = activities[indexPath.row]
               cell.textLabel?.text = dessert
               return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let name = activities[indexPath.row]
        activities.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser!.uid
                 
        print("indexPath:",indexPath, "name:", name)
        db.collection("users/\(uid)/activities/").whereField("activity", isEqualTo: name).getDocuments() { (querySnapshot, error) in
        
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
            }
            else{
                db.document("users/\(uid)/activities/\(name)").delete()
                }
            }
        }

}


    
