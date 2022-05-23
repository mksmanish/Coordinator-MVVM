//
//  EventListController.swift
//  Coordinator
//
//  Created by Tradesocio on 13/05/22.
//

import Foundation
import UIKit
import CoreData

final class EventListCordinator:Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    var onSaveEvent =  {}
    
    private let navigationController: UINavigationController
    
    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let eventListViewController : EventListViewController = .instantiate()
        let eventListViewModel = EventListViewModel()
        eventListViewModel.coordinator = self
        onSaveEvent = eventListViewModel.reload
        eventListViewController.viewModel = eventListViewModel
        navigationController.setViewControllers([eventListViewController], animated: false)
    }
    
    func startAddEvent() {
        print("adding tapped")
        let addEventCoordinator  = AddEventCoordinator(navigationController: navigationController)
         addEventCoordinator.parentCooedinator = self
         childCoordinators.append(addEventCoordinator)
         addEventCoordinator.start()
    }
    
    func onSelect(_ id: NSManagedObjectID) {
        let eventDetailCoordinator = EventDetailCoordinator(eventID: id, navigationController: navigationController)
        childCoordinators.append(eventDetailCoordinator)
        eventDetailCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        
        if let index = childCoordinators.firstIndex(where: { coordinator in

           return childCoordinator === coordinator
        //    return true

        }) {
            childCoordinators.remove(at: index)
        }
            
    }
    
}
