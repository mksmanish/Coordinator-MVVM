//
//  AddEventCoordinator.swift
//  Coordinator
//
//  Created by Tradesocio on 13/05/22.
//

import Foundation
import UIKit

final class AddEventCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    private var modelNavigationController : UINavigationController?
    private var complition: (UIImage) -> Void = { _ in}
    
    var parentCooedinator: EventListCordinator?
    
    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {

        self.modelNavigationController = UINavigationController()
        let addEventViewController: AddEventViewController = .instantiate()
        modelNavigationController?.setViewControllers([addEventViewController], animated: true)
        let addEventViewModel = AddEventViewModel(cellBuilder: EventCellBuilder(), coreDataManager: CoreDataManager())
        addEventViewModel.coodinator =  self
        addEventViewController.viewModel = addEventViewModel
        if let modelNavigationController = modelNavigationController {
            navigationController.present(modelNavigationController , animated: true)
        }
      
    }
    
    func didFinish() {
        parentCooedinator?.childDidFinish(self)
    }
    
    func didFinishSaveEvent() {
        parentCooedinator?.onSaveEvent()
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    func showImagePicker(complition: @escaping (UIImage) -> Void) {
        guard let modelNavigationController = modelNavigationController else {
            return
        }
        self.complition = complition
        let imagePickerCoordinator = ImagePickerCoordinator(navigationController: modelNavigationController)
        childCoordinators.append(imagePickerCoordinator)
        imagePickerCoordinator.parentCoordinator = self
        imagePickerCoordinator.start()

    }
    
    func didFinishPicking(_ image : UIImage) {
        complition(image)
        modelNavigationController?.dismiss(animated: true, completion: nil)
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
