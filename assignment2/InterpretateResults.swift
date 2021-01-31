//
//  InterpretateResults.swift
//  assignment2
//
//  Created by malika abdrakhmanova on 31.01.2021.
//

import Foundation
func defineMaxPossiblePoints(in quiz: [Question]) -> Int {
    var points = 0
    for question in quiz {
        for answer in question.answers {
            if answer.point != 0 {
                points += answer.point
            }
        }
    }
    return points
}

func interpretateResults(in quiz: [Question], with points: Int) -> [Character:String] {
    
    switch  points {
    case 0:
        return ["👽": "Sooo, you are noob, sry"]
    case 1...3:
        return ["👂🏻": "Wow, nice try, not bad"]
    case 4...5:
        return ["🙌🏻": "OMG, awp master? +rep, bro"]

    default:
        break
    }
    
    return ["🤖":"Error!"]
}

