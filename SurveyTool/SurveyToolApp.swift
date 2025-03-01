//
//  SurveyToolApp.swift
//  SurveyTool
//
//  Created by Andrii Pashuta on 26/02/2025.
//

import SwiftUI
import SwiftData

@main
struct SurveyToolApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(modelContext: try! ModelContext(
                .init(for: Survey.self, SurveyResponse.self)
            ))
        }
        .modelContainer(for: [Survey.self, SurveyResponse.self])
    }
}
