//
//  EventListViewController.swift
//  Coordinator
//
//  Created by Tradesocio on 13/05/22.
//

import UIKit
import CoreData

class EventListViewController: UIViewController {

    @IBOutlet weak var tblEventList: UITableView!
    
   let coreDataManager = CoreDataManager()
   var viewModel = EventListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblEventList.dataSource =  self
        tblEventList.delegate = self
        tblEventList.register(EventCell.self, forCellReuseIdentifier: "EventCell")
        setupView()
        viewModel.onUpdate = { [weak self] in
            self?.tblEventList.reloadData()
        }
        viewModel.viewDidLoad()
    }
    func setupView(){
        let plusImage = UIImage(systemName: "plus.circle.fill")
        let barButtonItem = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(tappedAddEventButton))
        barButtonItem.tintColor = .primary
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles =  true
    }
    
    @objc  func tappedAddEventButton() {
        viewModel.tappedAddEvent()
    }

}
extension EventListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.cell(at:indexPath) {
        case .event(let eventCellViewModel):
            let cell = tblEventList.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
            cell.update(with: eventCellViewModel)
            return cell
        }
    }
    
    
}
extension EventListViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath
        )
    }
}
