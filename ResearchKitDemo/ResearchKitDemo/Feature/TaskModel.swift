//
//  TaskModel.swift
//  ResearchKitDemo
//
//  Created by Suman on 04/05/19.
//  Copyright © 2019 Suman. All rights reserved.
//

import Foundation
class TaskModel {
    var taskType: TaskType?
    
    init(taskType: TaskType) {
        self.taskType = taskType
    }
}
