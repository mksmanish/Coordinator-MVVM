//
//  AddEventViewController.swift
//  Coordinator
//
//  Created by Tradesocio on 13/05/22.
//

import UIKit

class AddEventViewController: UIViewController {
    
    @IBOutlet weak var tblViewAddEvent: UITableView!
    
    var viewModel: AddEventViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onUpdate = { [weak self] in
            self?.tblViewAddEvent.reloadData()
        }
        viewModel.viewDidLoad()
        setupViews()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        viewModel.viewDidDisappear()
    }
    @objc func tappedDone() {
        
        viewModel.tappedDone()
    }
    
    private func setupViews() {
        // Do any additional setup after loading the view.
        tblViewAddEvent.dataSource = self
        tblViewAddEvent.delegate =  self
        tblViewAddEvent.register(TitleSubtitleCell.self, forCellReuseIdentifier: "TitleSubtitleCell")
        tblViewAddEvent.tableFooterView = UIView()
        
        
        navigationItem.title  = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
        navigationController?.navigationBar.tintColor = .red
        
        
        //to force large titles
        tblViewAddEvent.contentInsetAdjustmentBehavior = .never
        tblViewAddEvent.setContentOffset(.init(x: 0, y: -1), animated: false)
        
        
    }
   
    
}

extension AddEventViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel =  viewModel.cell(for: indexPath)
        switch cellViewModel {
        case .titleSubtitle(let titleSubtitleViewModel):
            let cell = tblViewAddEvent.dequeueReusableCell(withIdentifier: "TitleSubtitleCell", for: indexPath) as! TitleSubtitleCell
            cell.update(with:  titleSubtitleViewModel)
            cell.subtitleTextField.delegate = self
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
       
    }
    
}
extension AddEventViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return false }
        let text = currentText  + string
        let point = textField.convert(textField.bounds.origin, to: tblViewAddEvent)
        if let indexPath = tblViewAddEvent.indexPathForRow(at: point){
            viewModel.updateCell(indexPath:indexPath,subtitle:text)
        }
        return true
    }
}
