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

struct ContentView: View {
    @StateObject private var scheduleViewModel = ScheduleViewModel()
    @StateObject private var speakerViewModel = SpeakerViewModel()
    @State private var selectedFilter: Filter = .all
    @State private var isFilterSheetPresented = false
    @State private var filterModel = FilterModel()
    
    enum Filter {
        case all
        case firstDay
        case secondDay
    }
    
    var body: some View {
        let _ = print("Update ContentView")
        NavigationView {
            VStack {
                List(filteredSchedules) { schedule in
                    NavigationLink(destination: EventDetailView(schedule: schedule, speakerDict: speakerViewModel.speakersLib)) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(schedule.activity)
                                    .font(.headline)
                                Spacer()
                                BadgeType(eventType: schedule.type)
                            }
                            Text("Location: \(schedule.location)")
                                .font(.subheadline)
                            Text(formattedDate(schedule.start))
                                .font(.subheadline)
                            Text("from \(formattedHour(schedule.start)) to \(formattedHour(schedule.end))")
                                .font(.subheadline)
                        }
                    }
                }
                .sheet(isPresented: $isFilterSheetPresented) {
                    FilterSheetView(filterModel: $filterModel, isSheetPresented: $isFilterSheetPresented)
                }
                .navigationBarItems(trailing:
                                        Button(action: {
                    isFilterSheetPresented.toggle()
                }) {
                    Image(systemName: "line.horizontal.3.decrease.circle.fill")
                        .imageScale(.large)
                }
                )
                .navigationBarTitle("Schedule")
                .listStyle(GroupedListStyle())
                .contentMargins(.vertical, 0)
            }
            
        }
        .onAppear {
            scheduleViewModel.fetchScheduleList()
            speakerViewModel.fetchSpeakerLibrary()
        }
        .background(Color.white)
    }
    
    var filteredSchedules: [Schedule] {
        return FilteringService.filterSchedules(scheduleViewModel.schedules, by: filterModel.selectedFilter)
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
