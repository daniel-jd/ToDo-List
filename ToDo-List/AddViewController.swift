//
//  AddViewController.swift
//  ToDo-List
//
//  Created by Daniel Yamrak on 01.06.2021.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descTextField: UITextField!
    
    let todoVC = ToDoViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addDidTap(_ sender: Any) {
        guard let title = titleTextField.text,
              let desc = descTextField.text else {
            return
        }
        let newTask = Task(title: title, description: desc)
        todoVC.tasks.append(newTask)
        navigationController?.popViewController(animated: true)
    }
}
