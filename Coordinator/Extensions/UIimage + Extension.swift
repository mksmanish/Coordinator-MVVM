//
//  UIimage + Extension.swift
//  Coordinator
//
//  Created by Tradesocio on 23/05/22.
//

import Foundation
import UIKit

extension UIImage {
    func sameAspectRatio(newHeight: CGFloat) -> UIImage {
        let scale = newHeight / size.height
        let newWidth = size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        return UIGraphicsImageRenderer(size: newSize).image { _ in
            self.draw(in: .init(origin: .zero,size: newSize))
        }
        
    }
    
}
