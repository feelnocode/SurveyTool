//
//  Survey.swift
//  SurveyTool
//
//  Created by Andrii Pashuta on 26/02/2025.
//


import Foundation
import SwiftData

@Model
class Survey {
    var question: String
    var responses: [SurveyResponse]
    
    init(question: String) {
        self.question = question
        self.responses = []
    }
}

@Model
class SurveyResponse {
    var isYes: Bool
    var timestamp: Date
    
    init(isYes: Bool, timestamp: Date = Date()) {
        self.isYes = isYes
        self.timestamp = timestamp
    }
}
