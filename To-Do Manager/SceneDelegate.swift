//
//  SceneDelegate.swift
//  To-Do Manager
//
//  Created by Mikhail Egorov on 04.07.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        guard let window = window else { return }
        
        // загрузка задач
        // ее необходимо выполнить до создания экземпляра класса TaskListController
        // иначе данные будут перезаписаны
        let tasks = TasksStorage().loadTasks()
        
        // загрузка сцены со списком задач
        let taskListController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TaskListController") as! TaskListController
        
        //передача списка задач в контроллер
        taskListController.setTasks(tasks)
        
        //создание навигационного контроллера
        let navigationController = UINavigationController(rootViewController: taskListController)
        
        //отображение сцен
        self.window?.windowScene = windowScene
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

