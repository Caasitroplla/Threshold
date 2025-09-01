//
//  WorkoutsView.swift
//  Threshold
//
//  Created by Issac Allport on 26/08/2025.
//

import SwiftUI

struct WorkoutsView: View {
    @Binding var workouts: [Workout]
    let saveAction: () -> Void
    
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var lastWorkout = LastWorkout()
    
    @State private var isPresentingNew = false
    @State private var newWorkoutData = Workout.Data()
    
    private func onColor(workout: Workout) -> Color {
        if workout.intensity == 5 {
            return Color.red
        } else if workout.intensity == 3 || workout.intensity == 4 {
            return Color.orange
        } else {
            return Color.green
        }
    }
    
    var body: some View {
        List {
            ForEach(workouts) { workout in
                NavigationLink(destination:
                                NavigationView {
                    DetailView(workout: binding(for: workout), updateWorkout: updateIntensity)
                } ) {
                    CardView(workout: workout)
                    
                }
                .listRowBackground(onColor(workout: workout))
                .disabled(workout.completed || doWorkout(lastIntensity: lastWorkout.intensity, currentIntensity: workout.intensity))
            }
            .onDelete(perform: deleteWorkoutsAt)
        }
        .listStyle(InsetGroupedListStyle())
        .listRowSeparator(Visibility.hidden)
        .navigationTitle("Workouts")
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("Add", systemImage: "plus") {
                    isPresentingNew = true
                }
                .buttonStyle(.glassProminent)
            }
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    resetWorkouts()
                }) {
                    Image(systemName: "arrow.clockwise")
                }
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .inactive {
                saveAction()
            }
        }
        .sheet(isPresented: $isPresentingNew) {
            NavigationView {
                EditView(workoutData: $newWorkoutData)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let newWorkout = Workout(title: newWorkoutData.title, intensity: newWorkoutData.intensity, notes: newWorkoutData.notes, completed: false, lengthInMinutes: newWorkoutData.lengthInMinutes)
                                workouts.append(newWorkout)
                                isPresentingNew = false
                                newWorkoutData = Workout.Data()
                            }
                        }
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNew = false
                                newWorkoutData = Workout.Data()
                            }
                        }
                    }
            }
        }
    }
    
    func updateIntensity(newIntensity: Int) -> Void {
        lastWorkout.intensity = newIntensity
    }
    
    private func resetWorkouts() {
        for i in workouts.indices {
            workouts[i].completed = false
        }
    }
    
    private func binding(for workout: Workout) -> Binding<Workout> {
        guard let workoutIndex = workouts.firstIndex(where: { $0.id == workout.id }) else {
            fatalError("Can't find workout in array")
        }
        return $workouts[workoutIndex]
    }
    
    private func deleteWorkoutsAt(_ offsets: IndexSet) {
        workouts.remove(atOffsets: offsets)
    }
    
    private func doWorkout(lastIntensity: Int, currentIntensity: Int) -> Bool {
        // If last intensity is high then only accept new one of low intensity
        // range 0...5
        return !(7 - lastIntensity >= currentIntensity)
    }
}

#Preview {
    NavigationView {
        WorkoutsView(workouts: .constant(Workout.data), saveAction: {})
    }
}
