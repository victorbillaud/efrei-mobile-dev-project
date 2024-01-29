import SwiftUI

private func formattedDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d, yyyy"
    return formatter.string(from: date)
}

private func formattedHour(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mm a"
    return formatter.string(from: date)
}

struct EventDetailView: View {
    var schedule: Schedule
    var speakerDict: SpeakerLibrary
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Color Gradient Header
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.2, green: 0.1, blue: 0.4), Color(red: 0.1, green: 0.05, blue: 0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(height: 200) // Adjust the height as needed
                    .edgesIgnoringSafeArea(.top)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(schedule.activity)
                        .foregroundColor(.black)
                        .font(.title)
                        .bold()
                    
                    BadgeType(eventType: schedule.type)
                    
                    Section(header: Text("Date").bold().padding(.bottom, 10)) {
                        Text(formattedDate(schedule.start))
                            .font(.subheadline)
                        Text("from \(formattedHour(schedule.start)) to \(formattedHour(schedule.end))")
                            .font(.subheadline)
                    }
                    
                    Section(header: Text("Location").bold().padding(.top, 20)) {
                        Text(schedule.location)
                            .font(.subheadline)
                    }
                    
                    if let speakers = schedule.speakers, !speakers.isEmpty {
                        Section(header: Text(speakers.count == 1 ? "Speaker" : "Speakers").bold().padding(.top, 20)) {
                            ForEach(schedule.speakers!, id: \.self) { speakerID in
                                if let speaker = speakerDict.getValue(forID: speakerID) {
                                    SpeakerCard(speakerInfo: speaker)
                                }
                            }
                        }
                    }
                }
                .padding()
                .cornerRadius(10)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
