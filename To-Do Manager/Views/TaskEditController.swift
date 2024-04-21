//
//  TaskEditController.swift
//  To-Do Manager
//
//  Created by Mikhail Egorov on 10.07.2023.
//

import UIKit

class TaskEditController: UITableViewController {

    @IBOutlet var taskTitle: UITextField!
    
    @IBOutlet var taskTypeLabel: UILabel!
    
    @IBOutlet var taskStatusSwitch: UISwitch!
    
    var taskText: String = ""
    var taskType: TaskPriority = .normal
    var taskStatus: TaskStatus = .planned
    
    // замыкание для передачи данных
    var doAfterEdit: ((String, TaskPriority, TaskStatus) -> Void)?
    
    private var taskTitles: [TaskPriority : String] = [
        .important: "Важная",
        .normal: "Текущая"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTitle.text = taskText
        taskTypeLabel.text = taskTitles[taskType]
        
        if taskStatus == .completed {
            taskStatusSwitch.isOn = true
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigations
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskTypeScreen" {
            // ссылка на контроллер назначения
            let destination = segue.destination as! TaskTypeController
            //передача выбранного типа
            destination.selectedType = taskType
            // передача обработчика выбора типа
            destination.doAfterTypeSelected = { [unowned self] selectedType in
                taskType = selectedType
                // обновляем метку с текущим типом
                taskTypeLabel.text = taskTitles[taskType]
            }
        }
    }

    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        // получаем актуальные значения
        let title = taskTitle.text ?? " "
        let titleTrim = title.trimmingCharacters(in: .whitespaces)
        if titleTrim.isEmpty || titleTrim.first == " " {
            emptyFieldAlert()
            return
        }
        let type = taskType
        let status: TaskStatus = taskStatusSwitch.isOn ? .completed : .planned
        // вызываем обработчик
        doAfterEdit?(titleTrim, type, status)
        // возвращаемся к предыдущему экрану
        navigationController?.popViewController(animated: true)
    }
}

extension TaskEditController {
    private func emptyFieldAlert () {
        let alertController = UIAlertController(title: "Задача отсутсвует", message: "Введите корректное название задачи", preferredStyle: .alert)
        
        let alertButton = UIAlertAction(title: "Окей", style: .cancel)
        
        alertController.addAction(alertButton)
        self.present(alertController, animated: true)
    }
}
