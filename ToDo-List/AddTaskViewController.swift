//
//  AddViewController.swift
//  ToDo-List
//
//  Created by Daniel Yamrak on 01.06.2021.
//

protocol AddTaskDelegate: AnyObject {
    func addTask(_ task: Task)
}

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descTextField: UITextField!
    
    weak var delegate: AddTaskDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func addDidTap(_ sender: Any) {
        guard let title = titleTextField.text,
              let desc = descTextField.text else {
            return
        }
        let newTask = Task(title: title, description: desc, isDone: false)
        delegate?.addTask(newTask)
        navigationController?.popViewController(animated: true)
    }
}
