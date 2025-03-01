//
//  SurveyViewModel.swift
//  SurveyTool
//
//  Created by Andrii Pashuta on 27/02/2025.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor
class SurveyViewModel: ObservableObject {
    @Published var surveys: [Survey] = []
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchSurveys()
    }
    
    func fetchSurveys() {
        do {
            let descriptor = FetchDescriptor<Survey>()
            surveys = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to fetch surveys: \(error)")
        }
    }
    
    func addSurvey(question: String) {
        let newSurvey = Survey(question: question)
        modelContext.insert(newSurvey)
        try? modelContext.save()
        fetchSurveys()
    }
    
    func addResponse(to survey: Survey, isYes: Bool) {
        let response = SurveyResponse(isYes: isYes)
        survey.responses.append(response)
        try? modelContext.save()
        fetchSurveys()
    }
    
    func getSurveyResults(_ survey: Survey) -> (yesPercentage: Double, noPercentage: Double) {
        let totalResponses = survey.responses.count
        guard totalResponses > 0 else { return (0.0, 0.0) }
        
        let yesCount = survey.responses.filter { $0.isYes }.count
        let yesPercentage = (Double(yesCount) / Double(totalResponses)) * 100
        let noPercentage = 100 - yesPercentage
        
        return (yesPercentage, noPercentage)
    }
}
