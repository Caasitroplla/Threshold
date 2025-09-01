//
//  CardView.swift
//  Threshold
//
//  Created by Issac Allport on 26/08/2025.
//

import SwiftUI

struct CardView: View {
    let workout: Workout
    
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
        VStack(alignment: .leading) {
            Text(workout.title)
                .font(.headline)
                .padding()
            Spacer()
            HStack {
                HStack {
                    ForEach(1..<maximumRating + 1, id: \.self) { number in
                        image(for: number)
                    }
                }
                .padding(.leading, 15)
                Spacer()
                Label(hourMinute, systemImage: "clock")
                    .padding(.trailing, 20)
            }
            .font(.caption)
        }
        .foregroundColor(onColor.accessibleFontColor)
        
    }
    
    func image(for number: Int) -> Image {
        if number > workout.intensity {
            offImage
        } else {
            onImage
        }
    }
    
}

#Preview(traits: .fixedLayout(width: 400, height: 60)) {
    let workout = Workout.data[0]
    List {
        CardView(workout: workout)
    }
}
