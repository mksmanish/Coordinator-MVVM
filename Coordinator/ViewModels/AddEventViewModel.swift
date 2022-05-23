//
//  AddEventViewModel.swift
//  Coordinator
//
//  Created by Tradesocio on 16/05/22.
//

import Foundation
import UIKit

final class AddEventViewModel {
    weak var coodinator: AddEventCoordinator?
    var title = "Add Events"
    var onUpdate: () -> Void = {}
    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
        
    }
    private(set) var cells = [AddEventViewModel.Cell]()
    
    private var nameCellViewModel: TitleSubtitleCellViewModel?
    private var dateCellViewModel: TitleSubtitleCellViewModel?
    private var backgroundCellViewModel: TitleSubtitleCellViewModel?
    private let cellBuilder: EventCellBuilder
    private let coreDataManager:CoreDataManager
    
    lazy var dateFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyy"
        return dateFormatter
    }()
    init(cellBuilder:EventCellBuilder,coreDataManager:CoreDataManager){
        self.cellBuilder = cellBuilder
        self.coreDataManager = coreDataManager
    }
    
    func viewDidLoad() {
        
        setupCells()
        onUpdate()
    }
    func viewDidDisappear() {
        coodinator?.didFinish()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    func tappedDone() {
        print("tapped")
        guard let name = nameCellViewModel?.subtitle,let dateString = dateCellViewModel?.subtitle,let image = backgroundCellViewModel?.image ,let date = dateFormatter.date(from: dateString) else {return}
        coreDataManager.saveEvent(name: name, date: date, image: image)
        coodinator?.didFinishSaveEvent()
        //etract info  form cell view model and save in core data
        //tell the cooedinator to dismiss
    }
    
    func updateCell(indexPath: IndexPath,subtitle:String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            titleSubtitleCellViewModel.update(subtitle)
        }
    }
    
    func didSelectRow(at indexPath:IndexPath) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            guard titleSubtitleCellViewModel.type == .image else {
                return
            }
            coodinator?.showImagePicker { image in
                titleSubtitleCellViewModel.update(image)
            }
        }
    }
    
    deinit {
        print("add event view model has been deallocated")
    }
}
private extension AddEventViewModel {
    func setupCells(){
        
        nameCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.text)
        dateCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.date) { [weak self] in
            self?.onUpdate()
            
        }
        backgroundCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.image){ [weak self] in
            self?.onUpdate()
        }
        
        guard let  nameCellViewModel =  nameCellViewModel,let dateCellViewModel = dateCellViewModel,let backgroundCellViewModel = backgroundCellViewModel else{
            return
        }
        
        cells = [
            .titleSubtitle(nameCellViewModel),
            .titleSubtitle(dateCellViewModel),
            .titleSubtitle(backgroundCellViewModel),
            
        ]
    }
}
