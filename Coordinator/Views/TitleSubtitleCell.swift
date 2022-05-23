//
//  TitleSubtitleCell.swift
//  Coordinator
//
//  Created by Tradesocio on 17/05/22.
//

import Foundation
import UIKit

final class TitleSubtitleCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    let subtitleTextField = UITextField()
    private let verticalStackView = UIStackView()
    private let constant: CFloat = 15
    private let datePickerView = UIDatePicker()
    private let toolbar = UIToolbar(frame: .init(x: 0, y: 0, width: 100, height: 100))
    lazy var doneButton:UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappadDone))
    }()

    private let photoImageView = UIImageView()
    private var viewModel: TitleSubtitleCellViewModel?
    
    override init(style:UITableViewCell.CellStyle, reuseIdentifier:String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupHierarchy()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with viewModel: TitleSubtitleCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        subtitleTextField.text = viewModel.subtitle
        subtitleTextField.placeholder = viewModel.placeHolder
        
        subtitleTextField.inputView = viewModel.type == .text ? nil : datePickerView
        subtitleTextField.inputAccessoryView = viewModel.type == .text ? nil : toolbar
        
        photoImageView.isHidden = viewModel.type != .image
        subtitleTextField.isHidden = viewModel.type == .image
        
        verticalStackView.spacing = viewModel.type == .image ? 15 : verticalStackView.spacing
        
        photoImageView.image = viewModel.image
    }
    
    private func setupViews() {
        self.selectionStyle = .none
        verticalStackView.axis = .vertical
        titleLabel.font =  .systemFont(ofSize: 22,weight: .medium)
        subtitleTextField.font = .systemFont(ofSize: 20,weight: .medium)
        [verticalStackView,titleLabel,subtitleTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints =  false
        }
        datePickerView.datePickerMode = .date
      //  datePickerView.datePickerStyle = .automatic
        toolbar.setItems([doneButton], animated: false)
        photoImageView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        photoImageView.layer.cornerRadius = 10
    }
    private func setupHierarchy() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleTextField)
        verticalStackView.addArrangedSubview(photoImageView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            verticalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor ),
            verticalStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor ),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
        photoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    @objc private func tappadDone() {
        print(datePickerView.date)
       viewModel?.update(datePickerView.date)
    }
  
    
}
