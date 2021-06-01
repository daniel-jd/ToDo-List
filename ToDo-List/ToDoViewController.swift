//
//  ToDoViewController.swift
//  ToDo-List
//
//  Created by Daniel Yamrak on 01.06.2021.
//

import UIKit

class ToDoViewController: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
    }
    


    @IBAction func addDidTap(_ sender: UIButton) {
        //let segue = performSegue(withIdentifier: "toAddScreen", sender: addButton)
        //prepare(for: segue, sender: addButton)
    }
    
}

extension ToDoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCellID")! as UITableViewCell
        
        cell.textLabel?.text = "Task #1"
        cell.detailTextLabel?.text = "Do this and that"
        
        return cell
    }
    
    
}

extension ToDoViewController: UITableViewDelegate {
    
}
