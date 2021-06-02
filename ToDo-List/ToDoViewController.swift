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
    
    var tasks = [Task]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // dummy data
        tasks.append(Task(title: "Walk the dog", description: "At least for an hour"))
        tasks.append(Task(title: "Buy milk", description: "With the discount only"))
        tasks.append(Task(title: "Make coffe for your wife", description: "Milk, no sugar"))

        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    


    @IBAction func addDidTap(_ sender: UIButton) {
        //let segue = performSegue(withIdentifier: "toAddScreen", sender: addButton)
        //prepare(for: segue, sender: addButton)
    }
    
}

// MARK: - Delegate & Data Source

extension ToDoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCellID")! as UITableViewCell
        
        cell.textLabel?.text = tasks[indexPath.row].title
        cell.detailTextLabel?.text = tasks[indexPath.row].description
        
        return cell
    }
    
    
}

extension ToDoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                cell.textLabel?.alpha = 0.33
                cell.detailTextLabel?.alpha = 0.33
            } else {
                cell.accessoryType = .checkmark
                cell.textLabel?.alpha = 1
                cell.detailTextLabel?.alpha = 1
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
