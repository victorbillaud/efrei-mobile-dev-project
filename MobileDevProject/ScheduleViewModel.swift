//
//  ScheduleViewModel.swift
//  MobileDevProject
//
//  Created by Victor BILLAUD on 22/01/2024.
//

import SwiftUI

class ScheduleViewModel: ObservableObject {
    @Published var schedules: [Schedule] = []

    private let requestFactory: RequestFactoryProtocol = RequestFactory()

    func fetchScheduleList() {
        requestFactory.getScheduleList { schedules in
            DispatchQueue.main.async {
                if let schedules = schedules {
                    self.schedules.append(contentsOf: schedules)
                }
            }
        }
    }
}
