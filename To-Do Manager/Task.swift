//
//  Task.swift
//  To-Do Manager
//
//  Created by Mikhail Egorov on 04.07.2023.
//

import Foundation

// требования к типу, описывающему сущность
protocol TaskProtocol {
    // название
    var title: String { get set }
    // тип
    var type: TaskPriority { get set }
    // статус
    var status: TaskStatus { get set }
}
// сущность "Задача"
struct Task: TaskProtocol {
    var title: String
    var type: TaskPriority
    var status: TaskStatus
}

// тип задачи
enum TaskPriority {
    //текущая
    case normal
    // важная
    case important
}

// состояние задачи
enum TaskStatus: Int {
    // запланированная
    case planned
    // завершенная
    case completed
}
