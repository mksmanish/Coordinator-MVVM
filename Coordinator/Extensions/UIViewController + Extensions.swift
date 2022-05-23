//
//  UIViewController + Extensions.swift
//  Coordinator
//
//  Created by Tradesocio on 13/05/22.
//

import Foundation
import UIKit

extension UIViewController {
    static func instantiate<T>() -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "\(T.self)") as! T
        return controller
    }
}
