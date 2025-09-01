//
//  WorkoutData.swift
//  Threshold
//
//  Created by Issac Allport on 26/08/2025.
//

import Foundation
internal import Combine

class WorkoutData: ObservableObject {
    
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }
    
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("workouts.data")
    }
    
    @Published var workouts: [Workout] = []
    
    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                #if DEBUG
                DispatchQueue.main.async {
                    self?.workouts = Workout.data
                }
                #endif
                return
            }
            guard let workoutList = try? JSONDecoder().decode([Workout].self, from: data) else {
                fatalError("Can't decode saved scrum data.")
            }
            DispatchQueue.main.async {
                self?.workouts = workoutList
            }
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let workouts = self?.workouts else { fatalError("Self not in scope") }
            guard let data = try? JSONEncoder().encode(workouts) else { fatalError("Error encoding data")}
            do {
                let outfile = Self.fileURL
                try data.write(to: outfile)
            } catch {
                fatalError("Can't write to file")
            }
        }
    }
}
