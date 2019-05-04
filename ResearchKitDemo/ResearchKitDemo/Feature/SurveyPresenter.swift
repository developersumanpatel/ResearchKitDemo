//
//  SurveyPresenter.swift
//  ResearchKitDemo
//
//  Created by Suman on 04/05/19.
//  Copyright © 2019 Suman. All rights reserved.
//

import Foundation
import ResearchKit

class SurveyPresenter {
    private var tasks:[TaskType] = [.Text, .Numeric, .Image, .Date, .TextSingleSelection, .TextMultiSelection, .Picker, .Scale]
    
    init() {
    }
    
    func getSurveyTask() -> ORKOrderedTask {
        let taskList = TaskList.shared.createTask(tasks)
        return taskList
    }
    
    func postSurveyResult(_ result: ORKTaskResult) {
        debugPrint(result)
    }
    
}
