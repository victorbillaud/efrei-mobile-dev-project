import SwiftUI

struct ContentView: View {
    @StateObject private var scheduleViewModel = ScheduleViewModel()
    @State private var isTrue = true

    var body: some View {
        let _ = print("Update ContentView")
        NavigationView {
            List(scheduleViewModel.schedules) { schedule in
                VStack(alignment: .leading) {
                    Text(schedule.activity)
                        .font(.headline)
                    Text("Type: \(schedule.type.rawValue)")
                        .font(.subheadline)
                    Text("Location: \(schedule.location)")
                        .font(.subheadline)
                    Text("Start: \(formattedDate(schedule.start))")
                        .font(.subheadline)
                    Text("End: \(formattedDate(schedule.end))")
                        .font(.subheadline)
                }
            }
            .navigationBarTitle("Schedule")
        }
        .onAppear {
            scheduleViewModel.fetchScheduleList()
        }
        
        
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy HH:mm"
        return formatter.string(from: date)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
