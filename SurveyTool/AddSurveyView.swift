//
//  AddSurveyView.swift
//  SurveyTool
//
//  Created by Andrii Pashuta on 28/02/2025.
//

import SwiftUI
import SwiftData

struct AddSurveyView: View {
    @Environment(\.dismiss) private var dismiss
    let viewModel: SurveyViewModel
    @State private var question = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter survey question", text: $question)
            }
            .navigationTitle("New Survey")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        if !question.isEmpty {
                            viewModel.addSurvey(question: question)
                            dismiss()
                        }
                    }
                    .disabled(question.isEmpty)
                }
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
    let viewModel = SurveyViewModel(modelContext: context)
    
    return AddSurveyView(viewModel: viewModel)
}
