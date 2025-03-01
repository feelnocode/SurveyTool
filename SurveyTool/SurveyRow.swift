//
//  SurveyRow.swift
//  SurveyTool
//
//  Created by Andrii Pashuta on 28/02/2025.
//

import SwiftUI
import SwiftData

struct SurveyRow: View {
    let survey: Survey
    let viewModel: SurveyViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(survey.question)
                .font(.headline)
            
            let results = viewModel.getSurveyResults(survey)
            Text("Yes: \(results.yesPercentage, specifier: "%.1f")% | No: \(results.noPercentage, specifier: "%.1f")%")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    let container = try! ModelContainer(
        for: Survey.self, SurveyResponse.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    
    let context = ModelContext(container)
    let survey = Survey(question: "test test test")
    survey.responses = [SurveyResponse(isYes: true), SurveyResponse(isYes: false)]
    context.insert(survey)
    
    let viewModel = SurveyViewModel(modelContext: context)
    return SurveyRow(survey: survey, viewModel: viewModel)
}
