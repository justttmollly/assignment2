//
//  Hide Views.swift
//  assignment2
//
//  Created by malika abdrakhmanova on 31.01.2021.
//

import Foundation
import UIKit


func hideStackViews(in stackViews: [UIStackView?], except stackView: UIStackView) {
    
    for item in stackViews {
        if item == stackView {
            item?.showAnimated()
        } else {
            item?.hideAnimated()
        }
        
    }
}

extension UIView {
    
    func hideAnimated() {
        if !self.isHidden {
            UIView.animate(
                withDuration: 0.35,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 1,
                options: [],
                animations: {
                    self.isHidden = true
                    self.layoutIfNeeded()
            },
                completion: nil
            )
        }
    }

    func showAnimated() {
        if self.isHidden {
            UIView.animate(
                withDuration: 0.35,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 1,
                options: [],
                animations: {
                    self.isHidden = false
                    self.layoutIfNeeded()
            },
                completion: nil
            )

        }
    }
}
