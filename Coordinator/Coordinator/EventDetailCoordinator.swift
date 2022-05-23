//
//  EventDetailCoordinator.swift
//  Coordinator
//
//  Created by Tradesocio on 23/05/22.
//

import Foundation
import UIKit
import CoreData

final class EventDetailCoordinator : Coordinator{
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let eventID: NSManagedObjectID
    
    init(eventID: NSManagedObjectID,  navigationController:UINavigationController) {
        self.navigationController = navigationController
        self.eventID = eventID
    }
    
    
    func start() {
        //create
        let detailViewController: EventDetailViewController = .instantiate()
        detailViewController.viewModel = EventDetailViewModel(eventID: eventID)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    
}
