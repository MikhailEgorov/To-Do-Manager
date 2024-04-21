//
//  TaskTypeController.swift
//  To-Do Manager
//
//  Created by Mikhail Egorov on 11.07.2023.
//

import UIKit

class TaskTypeController: UITableViewController {
    
    //кортеж, описывающий тип задачи
    typealias TypeCellDescription = (type: TaskPriority, title: String, description: String)
    
    //Выбранные приоритет
    var selectedType: TaskPriority = .normal
    
    //обработчик выбора типа
    var doAfterTypeSelected: ((TaskPriority) -> Void)?
    
    //коллекция доступных типов задач с их описанием
    private var taskTypeInformation: [TypeCellDescription] = [
        (type: .important, title: "Важная", description: "Такой тип задач является наиболее приоритетным для выполнения. Все важные задачи выводятся в самом верху списка задач"),
        (type: .normal, title: "Текущая", description: "Задача с обычным приоритетом")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. получение значения типа UINib, соответсвующее xib-файлу кастомной ячейки
        let cellTypeNib = UINib(nibName: "TaskTypeCell", bundle: nil)
        // 2. регистрация кастомной ячейки в табличном представлении
        tableView.register(cellTypeNib, forCellReuseIdentifier: "TaskTypeCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskTypeInformation.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1. получение переиспользуемой кастомной ячейки по ее итендефикатору
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTypeCell", for: indexPath) as! TaskTypeCell
        
        // 2. получаем текущий элемент, информация о котором должна быть выведена в строке
        let typeDescription = taskTypeInformation[indexPath.row]
        
        // 3. заполняем ячейку данными
        cell.typeTitle.text = typeDescription.title
        cell.typeDescription.text = typeDescription.description
        
        // 4. если тип является выбранным, то отмечаем галочкой
        if selectedType == typeDescription.type {
            cell.accessoryType = .checkmark
        // иначе снимаем отметку
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // получаем выбранный тип
        let selectedType = taskTypeInformation[indexPath.row].type
        // выбор обработчика
        doAfterTypeSelected?(selectedType)
        // переход к предыдущему экрану
        navigationController?.popViewController(animated: true)
    }
}
