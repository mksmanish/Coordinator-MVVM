//
//  EventListModel.swift
//  Coordinator
//
//  Created by Tradesocio on 13/05/22.
//

import Foundation
final class EventListViewModel  {
    
    let title = "Events"
    var coordinator:EventListCordinator?
    var onUpdate = {}
    enum Cell {
        case event(EventCellViewModel)
    }
    
    private(set) var cells: [Cell] = []
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    func tappedAddEvent(){
        
        coordinator?.startAddEvent
        
    }
    func viewDidLoad() {
        
      reload()
    }
    
    func reload() {
        let events = coreDataManager.fetchEvents()
        cells = events.map {
            var eventCellViewModel = EventCellViewModel($0)
            if let coordinator = coordinator {
                eventCellViewModel.onSelect = coordinator.onSelect
            }
          
            return .event(eventCellViewModel)
        }
        onUpdate()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    func cell(at indexPath :IndexPath) -> Cell {
        
        return cells[indexPath.row]
    }
    
    func didSelectRow(at indexPath:IndexPath) {
        switch  cells[indexPath.row] {
        case .event(let eventCellVieewModel):
            eventCellVieewModel.didSelect()
        }
    }
}
