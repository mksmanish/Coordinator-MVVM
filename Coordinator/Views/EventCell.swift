//
//  EventCell.swift
//  Coordinator
//
//  Created by Tradesocio on 19/05/22.
//

import UIKit

final class EventCell:UITableViewCell {
    
    private let timeRemainingStackView = TimeRemainingStackView()
    
    private let dateTextLabel = UILabel()
    
    private let eventNameLabel = UILabel()
    private let backgroundImageView = UIImageView()
    private let verticalStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        timeRemainingStackView.setup()
        
       ([dateTextLabel ,eventNameLabel,backgroundImageView,verticalStackView]).forEach {
            $0.translatesAutoresizingMaskIntoConstraints =  false
        }
        
        dateTextLabel.font = .systemFont(ofSize: 22, weight: .bold)
        dateTextLabel.textColor = .white
        eventNameLabel.font = .systemFont(ofSize: 32, weight: .bold)
        eventNameLabel.textColor = .white
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .trailing
        
    }
    
    private func  setupHierarchy() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(verticalStackView)
        contentView.addSubview(eventNameLabel)
        
        verticalStackView.addArrangedSubview(timeRemainingStackView)
        verticalStackView.addArrangedSubview(UIView())
        verticalStackView.addArrangedSubview(dateTextLabel)
        
    }
    
    private func setupLayout() {
        backgroundImageView.pinToSuperviewEdges([.left, .top, .right, .bottom])
        let bottomConstraint = backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        bottomConstraint.priority = .required - 2
        bottomConstraint.isActive = true
        backgroundImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        verticalStackView.pinToSuperviewEdges([.top, .right, .bottom],constant: 15)
        eventNameLabel.pinToSuperviewEdges([.left, .bottom],constant: 15)
    }
    
    func update(with viewModel: EventCellViewModel) {
     
        if let timeRemaingViewModel = viewModel.timeRememaingigViewModel{
            timeRemainingStackView.update(with: timeRemaingViewModel)
        }
     
        dateTextLabel.text  = viewModel.dateText
        eventNameLabel.text = viewModel.eventName
        viewModel.loadImage { image in
            self.backgroundImageView.image = image
        }
        
        
    }
}

