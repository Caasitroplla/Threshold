//
//  Workout.swift
//  Threshold
//
//  Created by Issac Allport on 26/08/2025.
//

import SwiftUI

struct Workout: Identifiable, Codable {
    let id: UUID
    var title: String
    var intensity: Int
    var notes: String
    var completed: Bool
    var lengthInMinutes: Int
    
    init(id: UUID = UUID(), title: String, intensity:
         Int, notes: String, completed: Bool, lengthInMinutes: Int) {
        self.id = id
        self.title = title
        self.intensity = intensity
        self.notes = notes
        self.completed = completed
        self.lengthInMinutes = lengthInMinutes
    }
}

extension Workout {
    static var data: [Workout] {
        [
            Workout(title: "8 Minute Repeats", intensity: 5, notes: "Repeat 8 minutes at threshold until cooked", completed: false, lengthInMinutes: 120),
            Workout(title: "4 Hour zone 2 ride", intensity: 2, notes: "Keep hear rate and power in zone 2 to be performed on a flat route", completed: false, lengthInMinutes: 240),
            Workout(title: "1 Hour Recovery Ride", intensity: 1, notes: "Keep heart rate super low, no intensity today.", completed: true, lengthInMinutes: 60)
        ]
    }
}


extension Workout {
    struct Data {
        var title: String = ""
        var intensity: Int = 1
        var notes: String = ""
        var completed = false
        var lengthInMinutes = 60
    }
    
    var data: Data {
        return Data(title: self.title, intensity: self.intensity, notes: self.notes, completed: self.completed, lengthInMinutes: self.lengthInMinutes)
    }
    
    mutating func update(from data: Data) {
        title = data.title
        intensity = data.intensity
        notes = data.notes
        completed = data.completed
        lengthInMinutes = data.lengthInMinutes
    }
}
