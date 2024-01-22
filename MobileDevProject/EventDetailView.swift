//
//  EventDetailView.swift
//  MobileDevProject
//
//  Created by Victor BILLAUD on 22/01/2024.
//

import SwiftUI

private func formattedDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy"
    return formatter.string(from: date)
}

private func formattedHour(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter.string(from: date)
}

struct EventDetailView: View {
    var schedule: Schedule
    var speakerDict: SpeakerLibrary
        
    var body: some View {
        Text(schedule.activity)
            .foregroundColor(.blue)
            .bold()
            .font(.title)
            .padding(30)
        
        VStack(alignment: .leading) {
            VStack(alignment: .leading){
                Text("- Date -")
                    .bold()
                    .padding(.bottom, 10)
                Text(formattedDate(schedule.start))
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("from \(formattedHour(schedule.start)) to \(formattedHour(schedule.end))")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            VStack(alignment: .leading){
                Text("- Location -")
                    .bold()
                    .padding(.bottom, 10)
                Text(schedule.location)
                    .frame(maxWidth: .infinity, alignment: .center)
            }.padding(.top, 40)
            
            if let speakers = schedule.speakers, !speakers.isEmpty {
                VStack(alignment: .leading){
                    if (speakers.count == 1){
                        Text("- Speaker -")
                            .bold()
                            .padding(.bottom, 10)
                    }
                    else{
                        Text("- Speakers -")
                            .bold()
                            .padding(.bottom, 10)
                    }
                    ForEach(schedule.speakers!, id: \.self) { speakerID in
                        if let speaker = speakerDict.getValue(forID: speakerID) {
                            Text("- \(speaker.name)")
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }.padding(.top, 40)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)
        .padding(30)
    }
}


struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
