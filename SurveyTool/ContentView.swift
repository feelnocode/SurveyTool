//
//  ContentView.swift
//  SurveyTool
//
//  Created by Andrii Pashuta on 26/02/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: SurveyViewModel
    @State private var showingAddSurvey = false
    
    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: SurveyViewModel(modelContext: modelContext))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.surveys) { survey in
                    NavigationLink {
                        SurveyDetailView(survey: survey, viewModel: viewModel)
                    } label: {
                        SurveyRow(survey: survey, viewModel: viewModel)
                    }
                }
            }
            .navigationTitle("Surveys")
            .toolbar {
                Button(action: { showingAddSurvey = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddSurvey) {
                AddSurveyView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(
        for: Survey.self, SurveyResponse.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    
    let context = ModelContext(container)
    let survey = Survey(question: "Test test test")
    context.insert(survey)
    
    return ContentView(modelContext: context)
}
