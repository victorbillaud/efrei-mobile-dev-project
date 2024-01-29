//
//  FilterSheetView.swift
//  MobileDevProject
//
//  Created by Victor BILLAUD on 22/01/2024.
//

import SwiftUI

enum EventDay: String, CaseIterable {
    case all = "All"
    case firstDay = "First Day"
    case secondDay = "Second Day"
}

struct Filter {
    var eventType: Schedule.EventType = .all
    var eventDay: EventDay = .all
}


struct FilterModel {
    var selectedFilter: Filter = Filter()
    
    func applyFilters(to schedules: [Schedule]) -> [Schedule] {
        return FilteringService.filterSchedules(schedules, by: selectedFilter)
    }
}

struct FilterSheetView: View {
    @Binding var filterModel: FilterModel
    @Binding var isSheetPresented: Bool

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Event Day")) {
                    ForEach(EventDay.allCases, id: \.self) { filter in
                        Button(action: {
                            filterModel.selectedFilter.eventDay = filter
                        }) {
                            HStack {
                                Text(filter.rawValue)
                                Spacer()
                                if filterModel.selectedFilter.eventDay == filter {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                }

                Section(header: Text("Event Type")) {
                    ForEach(Schedule.EventType.allCases, id: \.self) { filter in
                        Button(action: {
                            filterModel.selectedFilter.eventType = filter
                        }) {
                            HStack {
                                Text(filter.rawValue)
                                Spacer()
                                if filterModel.selectedFilter.eventType == filter {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Select Filters", displayMode: .inline)
            .navigationBarItems(leading:
                Button("Done") {
                    isSheetPresented = false
                }
            )
        }
    }
}
