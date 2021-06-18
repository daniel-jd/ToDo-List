//
//  ToDoViewController.swift
//  ToDo-List
//
//  Created by Daniel Yamrak on 01.06.2021.
//

import UIKit

class ToDoViewController: UIViewController {
    
    private let defaults = UserDefaults.standard
    private let todoCellID = "todoCellID"

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var tasks = [Task]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // dummy data
//        tasks.append(Task(title: "Walk the dog", description: "At least for an hour"))
//        tasks.append(Task(title: "Buy milk", description: "With the discount only"))
//        tasks.append(Task(title: "Make coffe for your wife", description: "Milk, no sugar"))
        
        readTasksFromUserDefaults()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    private func saveTasksToUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tasks) {
            defaults.set(encoded, forKey: "SavedTasks")
        }
    }
    
    private func readTasksFromUserDefaults() {
        if let savedTasks = defaults.object(forKey: "SavedTasks") as? Data {
            let decoder = JSONDecoder()
            if let loadedTasks = try? decoder.decode([Task].self, from: savedTasks) {
                tasks = loadedTasks
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? AddTaskViewController else {
            return
        }
        vc.view.setNeedsDisplay()
        vc.delegate = self
    }
        
}

// MARK: Add Task Delegate

extension ToDoViewController: AddTaskDelegate {
    func addTask(_ task: Task) {
        tasks.insert(task, at: 0)
        saveTasksToUserDefaults()
        tableView.reloadData()
    }
}

extension ToDoViewController: EditTaskDelegate {
    func editTask(_ currentTask: Task, _ editedTask: Task) {
        var i = 0
        if let index = tasks.firstIndex(where: { $0 == currentTask }) {
            i = index
        }
        tasks.remove(at: i)
        tasks.insert(editedTask, at: i)
        saveTasksToUserDefaults()
        tableView.reloadData()
    }
}


// MARK: Delegate & Data Source

extension ToDoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: todoCellID)! as UITableViewCell
        
        cell.textLabel?.text = tasks[indexPath.row].title
        cell.detailTextLabel?.text = tasks[indexPath.row].description
        if tasks[indexPath.row].isDone == true {
            cell.accessoryType = .none
            cell.textLabel?.alpha = 0.33
            cell.detailTextLabel?.alpha = 0.33
        } else {
            cell.accessoryType = .checkmark
            cell.textLabel?.alpha = 1.0
            cell.detailTextLabel?.alpha = 1.0
        }
        return cell
    }
    
}

extension ToDoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                tasks[indexPath.row].isDone = true
                cell.textLabel?.alpha = 0.33
                cell.detailTextLabel?.alpha = 0.33
                saveTasksToUserDefaults()
            } else {
                cell.accessoryType = .checkmark
                tasks[indexPath.row].isDone = false
                cell.textLabel?.alpha = 1
                cell.detailTextLabel?.alpha = 1
                saveTasksToUserDefaults()
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: Edit task
    
    func tableView(_ tableView: UITableView,
      leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
      ->   UISwipeActionsConfiguration? {

      let action = UIContextualAction(style: .normal, title: "Edit",
        handler: { [weak self] (action, view, completionHandler) in
        // go to edit screen
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "EditTaskViewController") as EditTaskViewController
            vc.delegate = self
            vc.currentTask = self?.tasks[indexPath.row]
            self?.navigationController?.pushViewController(vc, animated: true)
        completionHandler(true)
      })
        action.backgroundColor = .systemOrange
      let configuration = UISwipeActionsConfiguration(actions: [action])
      return configuration
    }
    
    // MARK: Delete task
    
    func tableView(_ tableView: UITableView,
      trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
      ->   UISwipeActionsConfiguration? {

      let action = UIContextualAction(style: .destructive, title: "Delete",
        handler: { (action, view, completionHandler) in
            self.tasks.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.saveTasksToUserDefaults()
        completionHandler(true)
      })

      let configuration = UISwipeActionsConfiguration(actions: [action])
      return configuration
    }
    
}
