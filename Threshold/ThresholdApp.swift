//
//  ThresholdApp.swift
//  Threshold
//
//  Created by Issac Allport on 26/08/2025.
//

import SwiftUI

@main
struct ThresholdApp: App {
    @ObservedObject private var data = WorkoutData()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                WorkoutsView(workouts: $data.workouts) {
                    data.save()
                }
            }
            .onAppear {
                data.load()
            }
        }
    }
}
