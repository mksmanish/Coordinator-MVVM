//
//  EventDetailViewController.swift
//  Coordinator
//
//  Created by Tradesocio on 23/05/22.
//

import UIKit

class EventDetailViewController: UIViewController {

    @IBOutlet weak var timeRemainingStackView: TimeRemainingStackView! {
        didSet{
            timeRemainingStackView.setup()
        }
    }
    @IBOutlet weak var backGroundImageView: UIImageView!
    var viewModel: EventDetailViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.onUpdate = {[weak self] in
            guard let self  =  self ,let timeRemainingViewModel = self.viewModel.timeRemainingViewModel else {return }
            self.backGroundImageView.image = self.viewModel.image
            self.timeRemainingStackView.update(with: timeRemainingViewModel)
        }
        viewModel.viwDidLoad()
    }
    

   
   
}
