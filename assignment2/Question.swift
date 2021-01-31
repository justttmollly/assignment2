struct Question {
    
    var text: String
    var answers: [Answer]
    var type: ResponseType
    
    static func loadData() -> [Question] {
        return [
                Question(text: "When CS:GO appered",
                         answers: [Answer(text: "2012", point: 1),
                                   Answer(text: "2011", point: 0),
                                   Answer(text: "2020", point: 0),
                                   Answer(text: "2013", point: 0)].shuffled(),
                         type: .chooseOnlyOneRightAnswer),

               
                Question(text: "Which of the following is AUG",
                         answers: [Answer(text: "first logo", point: 1),
                                   Answer(text: "second logo", point: 0),
                                   Answer(text: "third logo", point: 0)].shuffled(),
                         type: .tapImageToAnswer),

                Question(text: "Which of the following is AWP",
                         answers: [Answer(text: "second logo", point: 1),
                                   Answer(text: "first logo", point: 0),
                                   Answer(text: "third logo", point: 0)].shuffled(),
                         type: .tapImageToAnswer),

                Question(text: "How many people is playing in one command",
                         answers: [Answer(text: "5", point: 1)], type: .slideToAnswer),

                Question(text: "How many flashes you can take",
                         answers: [Answer(text: "2", point: 1)], type: .slideToAnswer)
            ].shuffled()
    }

}
