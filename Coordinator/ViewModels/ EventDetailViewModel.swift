//
//   EventDetailViewModel.swift
//  Coordinator
//
//  Created by Tradesocio on 23/05/22.
//

import Foundation
import CoreData
import UIKit

final class  EventDetailViewModel {
    private let eventID: NSManagedObjectID
    private let coreDataManager : CoreDataManager
    private var event: Event?
    private let date = Date()
    var onUpdate = {}
    
    var image: UIImage? {
        guard let imageData = event?.image else {return nil}
        return UIImage(data: imageData)
    }
    var timeRemainingViewModel:TimeRemainingViewModel? {
        guard let eventDate = event?.date , let timeRemainingParts = date.timeRemaning(until: eventDate)?.components(separatedBy: ",") else { return nil }
       
        return TimeRemainingViewModel(timeRemainingParts: timeRemainingParts, mode: .detail)
    }
    
    init(eventID: NSManagedObjectID, coreDataManger: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManger
        self.eventID = eventID
    }
    
    func viwDidLoad() {
        event = coreDataManager.getEvent(eventID)
        onUpdate()
    }
}
