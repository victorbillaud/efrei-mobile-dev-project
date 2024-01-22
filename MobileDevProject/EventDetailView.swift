//
//  EventDetailView.swift
//  MobileDevProject
//
//  Created by Victor BILLAUD on 22/01/2024.
//

import SwiftUI

struct EventDetailView: View {
    var schedule: Schedule

    var body: some View {
        VStack {
            Text("Event Details")
                .font(.title)
                .padding()

            // Display event details here using the schedule parameter
            Text("Activity: \(schedule.activity)")
            Text("Location: \(schedule.location)")
            Text("Start: \(schedule.start)")
            Text("End: \(schedule.end)")

            // You can add more details as needed
        }
        .padding(5)
    }
}


struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
