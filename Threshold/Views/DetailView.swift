//
//  DetailView.swift
//  Threshold
//
//  Created by Issac Allport on 26/08/2025.
//

import SwiftUI

struct DetailView: View {
    @Binding var workout: Workout
    @State private var data: Workout.Data = Workout.Data()
    @State private var isEditing = false
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    let updateWorkout: (Int) -> Void
    
    var maximumRating = 5

    var offImage = Image(systemName: "circle")
    var onImage = Image(systemName: "circle.fill")

    var offColor = Color.gray
    var onColor: Color {
        if workout.intensity == 5 {
            return Color.red
        } else if workout.intensity == 3 || workout.intensity == 4 {
            return Color.orange
        } else {
            return Color.green
        }
    }
    
    func image(for number: Int) -> Image {
        if number > workout.intensity {
            offImage
        } else {
            onImage
        }
    }
    
    var hourMinute: String {
        let hours = workout.lengthInMinutes / 60
        let minutes = workout.lengthInMinutes % 60
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes)m"
        }
    }
    
    var body: some View {
        List {
            Section("Workout Info") {
                HStack {
                    Text("Intensity")
                    Spacer()
                    ForEach(1..<maximumRating + 1, id: \.self) { number in
                        image(for: number)
                            .foregroundStyle(number > workout.intensity ? offColor : onColor)
                    }
                }
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text(hourMinute)
                }
                
            }
            Section("Notes") {
                Text(workout.notes)
                    .multilineTextAlignment(.leading)
            }
            
        }
        .navigationTitle(workout.title)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("Complete") {
                    workout.completed = true
                    updateWorkout(workout.intensity)
                    
                    self.mode.wrappedValue.dismiss()
                }
                .buttonStyle(.glassProminent)
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Edit") {
                    data = workout.data
                    isEditing = true
                }
            }
            
        }
        .fullScreenCover(isPresented: $isEditing) {
            NavigationView {
                EditView(workoutData: $data)
                    .navigationTitle(workout.title)
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            Button("Cancel") {
                                isEditing = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isEditing = false
                                workout.update(from: data)
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    NavigationView {
        DetailView(workout: .constant(Workout.data[0]), updateWorkout: {_ in })
    }
}

