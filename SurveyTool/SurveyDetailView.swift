//
//  SurveyScreen.swift
//  SurveyTool
//
//  Created by Andrii Pashuta on 26/02/2025.
//

import SwiftUI
import SwiftData

struct SurveyDetailView: View {
    let survey: Survey
    let viewModel: SurveyViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text(survey.question)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()
            
            HStack {
                Button("Yes") {
                    viewModel.addResponse(to: survey, isYes: true)
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
                
                Button("No") {
                    viewModel.addResponse(to: survey, isYes: false)
                }
                .buttonStyle(.bordered)
            }
            .padding(.horizontal, 50)
            
            if !survey.responses.isEmpty {
                List {
                    ForEach(survey.responses) { response in
                        HStack {
                            Text(response.isYes ? "Yes" : "No")
                            Spacer()
                            Text(response.timestamp, format: .dateTime
                                                            .year()
                                                            .month()
                                                            .day()
                                                            .hour()
                                                            .minute()
                                                            .second()
                                                        )
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            
            Spacer()
        }
        .navigationTitle("Survey")
    }
}


#Preview {
    let container = try! ModelContainer(
        for: Survey.self, SurveyResponse.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    
    let context = ModelContext(container)
    let survey = Survey(question: "Test tesst")
    survey.responses = [SurveyResponse(isYes: true)]
    context.insert(survey)
    
    let viewModel = SurveyViewModel(modelContext: context)
    return SurveyDetailView(survey: survey, viewModel: viewModel)
}
