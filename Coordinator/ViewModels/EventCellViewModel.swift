//
//  EventCellViewModel.swift
//  Coordinator
//
//  Created by Tradesocio on 19/05/22.
//

import UIKit
import CoreData

struct EventCellViewModel {
    
  
    private static let imageCache = NSCache<NSString,UIImage>()
    private let imageQueue = DispatchQueue(label: "imageQueue",qos: .background)
    var onSelect : (NSManagedObjectID) -> Void = { _ in  }
    private let date = Date()
    private var cacheKey:String {
        event.objectID.description
    }
    var timeRemainingStrings: [String] {
        guard let eventDate = event.date else { return [] }
        return date.timeRemaning(until: eventDate)?.components(separatedBy: ",") ?? [""]
    }
    var dateText: String? {
        guard let eventDate = event.date else {return nil}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: eventDate)
    }
    
    var eventName: String? {
        event.name
    }
    
    var timeRememaingigViewModel: TimeRemainingViewModel? {
        
        guard let eventDate = event.date , let timeRemainingParts = date.timeRemaning(until: eventDate)?.components(separatedBy: ",") else {return nil}
       
        return TimeRemainingViewModel(timeRemainingParts: timeRemainingParts, mode: .cell)
        
        
    }
    
    func loadImage(complition:@escaping(UIImage?) -> Void) {
        if let image = Self.imageCache.object(forKey: cacheKey as NSString) {
            complition(image)
        }else{
            
            imageQueue.async {
                guard let imageData = self.event.image,let image = UIImage(data: imageData) else {
                    complition(nil)
                    return
                }
                Self.imageCache.setObject(image, forKey: self.cacheKey as NSString)
                DispatchQueue.main.async {
                    complition(image)
                }
              
            }
            
        }
       
    }
    
    func didSelect() {
        onSelect(event.objectID)
    }
    
    
    private let event: Event
    init(_ event: Event) {
        self.event = event
    }
    
}
