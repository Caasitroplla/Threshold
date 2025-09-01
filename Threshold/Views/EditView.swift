//
//  EditView.swift
//  Threshold
//
//  Created by Issac Allport on 26/08/2025.
//

import SwiftUI

struct EditView: View {
    @Binding var workoutData: Workout.Data

    var maximumRating = 5
    
    var body: some View {
        List {
            Section("Workout Info") {
                TextField("Title", text: $workoutData.title)
                HStack {
                    Text("Intensity: \(workoutData.intensity)")
                    Spacer(minLength: 20)
                    Slider(
                        value: Binding<Double>(
                            get: { Double(workoutData.intensity) },
                            set: { workoutData.intensity = Int($0.rounded()) }
                        ),
                        in: 0...Double(maximumRating),
                        step: 1
                    )
                }
                Stepper("Length: \(workoutData.lengthInMinutes)", value: $workoutData.lengthInMinutes, in: 0...360, step: 10)
                
            }
            Section("Notes") {
                TextField("Notes", text: $workoutData.notes, axis: .vertical)
                    .lineLimit(5)
                    .multilineTextAlignment(.leading)
                    .padding()
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

#Preview {
    EditView(workoutData: .constant(Workout.data[0].data))
}
