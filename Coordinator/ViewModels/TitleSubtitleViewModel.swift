//
//  TitleSubtitleViewModel.swift
//  Coordinator
//
//  Created by Tradesocio on 17/05/22.
//

import Foundation
import UIKit

final class TitleSubtitleCellViewModel {
    
    enum CellType{
        case text
        case date
        case image
    }
    let title:String
    private(set) var  subtitle:String
    let placeHolder: String
    let type: CellType
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyy"
        return dateFormatter
    }()
    private(set) var image : UIImage?
    private(set) var onUpdate: (() -> Void)?
    
    init(title:String,subtitle:String,placeHolder:String,type:CellType,onUpdate: (() -> Void)?) {
        self.title = title
        self.subtitle = subtitle
        self.placeHolder = placeHolder
        self.type =  type
        self.onUpdate = onUpdate
    }
    
    func update(_ subtitle:String){
        self.subtitle = subtitle
    }
    
    func update(_ date: Date) {
        let dateString = dateFormatter.string(from: date)
        self.subtitle =  dateString
        onUpdate?()
    }
    
    func update(_ image:UIImage) {
        self.image = image
        onUpdate?()
    }
}
