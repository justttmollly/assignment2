//
//  QuestionsViewController.swift
//  assignment2
//
//  Created by malika abdrakhmanova on 31.01.2021.
//

import Foundation
import UIKit

class QuestionsViewController: UIViewController {
    
    private var quiz = Question.loadData()
    private var currentQuestionIndex = 0
    private var userPoints = 0
    
    
    
    @IBOutlet weak var chooseOnlyOneRightAnswerStackView: UIStackView!
    @IBOutlet weak var tapImageToAnswerStackView: UIStackView!
    @IBOutlet weak var slideToAnswerStackView: UIStackView!
    @IBOutlet weak var selectRightAnswersStackView: UIStackView!
    

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
   
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var labelOfSlider: UILabel!
    
}

extension QuestionsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNextQuestion()
    }
  
    @IBAction func slideAction(_ sender: UISlider) {
        labelOfSlider.text = "\(Int(sender.value))"
    }
 
    @IBAction func userTappedButtonToAnswer(_ sender: UIButton) {
        
      
        let currentQuestion = quiz[currentQuestionIndex]
        
        switch currentQuestion.type {
        case .chooseOnlyOneRightAnswer:
            for answer in currentQuestion.answers {
                if answer.text == sender.currentTitle {
                    userPoints += answer.point
                }
            }

       
        case .slideToAnswer:
            for answer in currentQuestion.answers {
                if labelOfSlider.text == answer.text {
                    userPoints += answer.point
                }
            }
            
        case .tapImageToAnswer: break
            
        }
        
        currentQuestionIndex += 1
        showNextQuestion()
    }
    
    
  
    private func showNextQuestion() {
        
        guard currentQuestionIndex < quiz.count else {
            
            //MARK: Perform Segue in the end of quiz
            performSegue(withIdentifier: "ResultsSegue", sender: self)
            
            return
        }
        
     
        let stackViews = [chooseOnlyOneRightAnswerStackView, tapImageToAnswerStackView, slideToAnswerStackView,selectRightAnswersStackView]
        
     
        let currentQuestion = quiz[currentQuestionIndex]
        
        switch currentQuestion.type {
            
        case .chooseOnlyOneRightAnswer:
            
            let questionLabel = chooseOnlyOneRightAnswerStackView.arrangedSubviews[0] as! UILabel
            questionLabel.text = currentQuestion.text
            
            let subStackView = chooseOnlyOneRightAnswerStackView.arrangedSubviews[1] as! UIStackView
            let subStackViewItems = subStackView.arrangedSubviews
            
            for itemIndex in 0..<subStackViewItems.count {
                let button = subStackViewItems[itemIndex] as! UIButton
                button.setTitle(currentQuestion.answers[itemIndex].text, for: .normal)
            }
            
            hideStackViews(in: stackViews, except: chooseOnlyOneRightAnswerStackView)
            navigationItem.title = "Choose the correct answer:"
           
               
        case .slideToAnswer:
            let questionLabel = slideToAnswerStackView.arrangedSubviews[0] as! UILabel
            questionLabel.text = currentQuestion.text
            
            
            slider.minimumValue = 1
            slider.maximumValue = 10
            
            slider.value = Float.random(in: 1...10)
            labelOfSlider.text = "\(Int(slider.value))"
            
            hideStackViews(in: stackViews, except: slideToAnswerStackView)
            navigationItem.title = "Slide till the correct answer:"
            
        case .tapImageToAnswer:
    
            let questionLabel = tapImageToAnswerStackView.arrangedSubviews[0] as! UILabel
            questionLabel.text = currentQuestion.text
            
            let imageStackView = tapImageToAnswerStackView.arrangedSubviews[1] as! UIStackView
            for index in 0..<imageStackView.arrangedSubviews.count {
             
                let imageView = imageStackView.arrangedSubviews[index] as! UIImageView
                
                imageView.image = UIImage(named: currentQuestion.answers[index].text)
                
               
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(gesture:)))
                imageView.addGestureRecognizer(tapGesture)
            }
            
            hideStackViews(in: stackViews, except: tapImageToAnswerStackView)
            navigationItem.title = "Click on image"

        }
        
        
        let progressPoint = Float(1.0) / Float(quiz.count)
        
        if progressBar.progress == 0 {
            progressLabel.text = "Question \(currentQuestionIndex + 1) of \(quiz.count)"
            progressBar.progress = progressPoint
        } else {
            progressBar.setProgress(progressBar.progress + progressPoint, animated: true)
            progressLabel.text = "Question \(currentQuestionIndex + 1) of \(quiz.count)"
        }
    }
    

    @objc func imageTapped(gesture: UIGestureRecognizer) {
        
        guard let image = gesture.view as? UIImageView else { return }
        

        image.alpha = 0.5
        UIView.animate(withDuration: 0.5) {
            image.alpha = 1.0
            
        }
    
        let currentQuestion = quiz[currentQuestionIndex]
        
        if currentQuestionIndex < quiz.count {
            for answer in currentQuestion.answers {
                if image.image == UIImage(named: answer.text) && answer.point == 1 {
                    userPoints += answer.point
                    
                }
            }
            
            currentQuestionIndex += 1
            showNextQuestion()
            
        }
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let resultsVC = segue.destination as? ResultsViewController {
            resultsVC.result = interpretateResults(in: quiz, with: userPoints)
            resultsVC.userPoints = (userPoints, defineMaxPossiblePoints(in: quiz))
        }
        
    }
    
}
