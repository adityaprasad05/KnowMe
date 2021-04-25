//
//  ViewController.swift
//  Add & Delete Cells
//
//  Created by Kyle Lee on 10/8/17.
//  Copyright © 2017 Kilo Loco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var desserts = [String]()

    @IBAction func onAddTapped() {
        let alert = UIAlertController(title: "Add Dessert", message: nil, preferredStyle: .alert)
        alert.addTextField { (dessertTF) in
            dessertTF.placeholder = "Enter Dessert"
        }
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let dessert = alert.textFields?.first?.text else { return }
            print(dessert)
            self.add(dessert)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func add(_ dessert: String) {
        let index = 0
        desserts.insert(dessert, at: index)
        
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)
    }

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return desserts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let dessert = desserts[indexPath.row]
        cell.textLabel?.text = dessert
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        desserts.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

