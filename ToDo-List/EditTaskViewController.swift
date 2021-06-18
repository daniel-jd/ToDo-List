//
//  EditTaskViewController.swift
//  ToDo-List
//
//  Created by Daniel Yamrak on 17.06.2021.
//

import UIKit

protocol EditTaskDelegate: AnyObject {
    func editTask(_ currentTask: Task, _ editedTask: Task)
}

class EditTaskViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    weak var delegate: EditTaskDelegate?
    var currentTask: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let task = currentTask else {
            return
        }
        titleTextField.text = task.title
        descriptionTextField.text = task.description

    }
    
    @IBAction func saveDidTap(_ sender: UIButton) {
        guard let title = titleTextField.text,
              let desc = descriptionTextField.text,
              let currentTask = currentTask else {
            return
        }
        let editedTask = Task(title: title, description: desc, isDone: currentTask.isDone)
        delegate?.editTask(currentTask, editedTask)
        navigationController?.popViewController(animated: true)
    }
    
}
