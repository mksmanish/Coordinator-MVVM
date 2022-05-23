//
//  AppCoordinator.swift
//  Coordinator
//
//  Created by Tradesocio on 13/05/22.
//

import Foundation
import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get }
    func start()
    
}

final class AppCoordinator : Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    
    private let window:UIWindow
    
    init(window:UIWindow){
        self.window = window
    }
    
    func start() {
        
        let navigationController = UINavigationController()
        
        let eventListCoordinator = EventListCordinator(navigationController: navigationController)
        childCoordinators.append(eventListCoordinator)
        
        eventListCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    
}
