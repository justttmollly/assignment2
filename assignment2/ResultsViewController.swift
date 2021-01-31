//
//  ResultsViewController.swift
//  assignment2
//
//  Created by malika abdrakhmanova on 31.01.2021.
//

import Foundation
import UIKit

class ResultsViewController: UIViewController {
    
    var userPoints = (gained: 0, maxPossiblePoints: 5)
    var result = [Character : String]()
    
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var userPointsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.hidesBackButton = true
        userPointsLabel.text = " You took \(userPoints.gained) out of \(userPoints.maxPossiblePoints)."
        for (char, description) in result {
            characterLabel.text = "\(char)"
            descriptionLabel.text = description
        }
    }

}
