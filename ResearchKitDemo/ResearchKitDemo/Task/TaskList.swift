//
//  TaskList.swift
//  ResearchKitDemo
//
//  Created by Suman on 04/05/19.
//  Copyright © 2019 Suman. All rights reserved.
//

import Foundation
import ResearchKit

enum TaskType {
    case Text
    case Numeric
    case Image
    case Date
    case Picker
    case TextSingleSelection
    case TextMultiSelection
    case Scale
  
}

class TaskList {
    static let shared = TaskList()
    init() {
        
    }
    
    func createTask(_ tasks: [TaskType]) -> ORKOrderedTask {
        var steps = [ORKStep]()
        
        let instructionStep = ORKInstructionStep(identifier: "IntroStep")
        instructionStep.title = "Test Survey"
        instructionStep.text = "Answer some questions to complete the survey."
        steps += [instructionStep]
        
        for task in tasks {
            switch task {
            case .Text:
                let answerFormat = ORKTextAnswerFormat(maximumLength: 20)
                answerFormat.multipleLines = false
                let questionStep = ORKQuestionStep(identifier: "NameStep", title: nil, question: "What is your name?", answer: answerFormat)
                steps += [questionStep]
            case .Numeric:
                let answerFormat = ORKNumericAnswerFormat.integerAnswerFormat(withUnit: "years")
                answerFormat.minimum = 18
                answerFormat.maximum = 85
                let questionStep = ORKQuestionStep(identifier: "AgeStep", title: "", question: "How old are you?", answer: answerFormat)
                steps += [questionStep]
            case .Image:
                let moodImages = [
                    (UIImage(named: "happy")!, "Happy"),
                    (UIImage(named: "angry")!, "Angry"),
                    (UIImage(named: "sad")!, "Sad"),
                ]
                let moodChoice : [ORKImageChoice] = moodImages.map {
                    return ORKImageChoice(normalImage: $0.0, selectedImage: nil, text: $0.1, value: $0.1 as NSCoding & NSCopying & NSObjectProtocol)
                }
                let answerFormat: ORKImageChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: moodChoice)
                let questionStep = ORKQuestionStep(identifier: "MoodStep", title: "", question: "How do you feel today?", answer: answerFormat)
                steps += [questionStep]
            case .Date:
                let answerFormat = ORKAnswerFormat.dateAnswerFormat(withDefaultDate: Date(), minimumDate: nil, maximumDate: Date(), calendar: nil)
                let questionStep = ORKQuestionStep(identifier: "DateStep", title: "", question: "When is your birthday?", answer: answerFormat)
                 steps += [questionStep]
                
            case .Picker:
                let textChoices = [
                    ORKTextChoice(text: "A+ve", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
                    ORKTextChoice(text: "A-ve", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
                    ORKTextChoice(text: "B+ve", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
                    ORKTextChoice(text: "B-ve", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
                    ORKTextChoice(text: "AB+ve", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
                    ORKTextChoice(text: "AB-ve", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
                    ORKTextChoice(text: "O+ve", value: 6 as NSCoding & NSCopying & NSObjectProtocol),
                    ORKTextChoice(text: "O-ve", value: 7 as NSCoding & NSCopying & NSObjectProtocol)
                ]
                
                let answerFormat = ORKAnswerFormat.valuePickerAnswerFormat(with: textChoices)
                let questionStep = ORKQuestionStep(identifier: "PickerQuestionStep", title: "", question: "What is your blood group?", answer: answerFormat)
                 steps += [questionStep]
                
            case .Scale:
                let answerFormat = ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 1, defaultValue: NSIntegerMax, step: 1, vertical: false, maximumValueDescription: "Good", minimumValueDescription: "Bad")
                
                let questionStep = ORKQuestionStep(identifier: "ScaleQuestionStep", title: "", question: "Please rate your experience", answer: answerFormat)
                steps += [questionStep]

            case .TextSingleSelection:
                let textChoices = [
                    ORKTextChoice(text: "Less than seven", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
                    ORKTextChoice(text: "Between seven and eight", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
                    ORKTextChoice(text: "More than eight", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
                ]
                
                let answerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)
                let questionStep = ORKQuestionStep(identifier: "TextSingleSelectionStep", title: "", question: "How many hours did you sleep last night?", answer: answerFormat)
                steps += [questionStep]
            case .TextMultiSelection:
                let textChoices = [
                    ORKTextChoice(text: "Cough", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
                    ORKTextChoice(text: "Fever", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
                    ORKTextChoice(text: "Headaches", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
                ]
                
                let answerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: textChoices)
                let questionStep = ORKQuestionStep(identifier: "TextMultiSelectionStep", title: "", question: "Which symptoms do you have?", answer: answerFormat)
                steps += [questionStep]
            }
        }
        let completionStep = ORKCompletionStep(identifier: "SummaryStep")
        completionStep.title = "Thank You!!"
        completionStep.text = "You have completed the survey"
        steps += [completionStep]
        
        return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
    }
}
