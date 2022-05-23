//
//  UIView + Extensions.swift
//  Coordinator
//
//  Created by Tradesocio on 19/05/22.
//

import Foundation
import UIKit

enum Edge{
    case left
    case right
    case top
    case bottom
}
extension UIView {
    func pinToSuperviewEdges(_ edges: [Edge] = [.top, .left, .right, .bottom],constant:CGFloat = 0) {
        guard let superview = superview else {return}
        edges.forEach {
            switch $0 {
            case .top:
                topAnchor.constraint(equalTo: superview.topAnchor,constant: constant).isActive =  true
            case .left:
                leftAnchor.constraint(equalTo: superview.leftAnchor,constant: constant).isActive =  true
            case .right:
                rightAnchor.constraint(equalTo: superview.rightAnchor,constant: -constant).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: superview.bottomAnchor,constant: -constant).isActive = true
            }
        }
    }
}
