//
//  BadgeType.swift
//  MobileDevProject
//
//  Created by Victor BILLAUD on 22/01/2024.
//
import SwiftUI

struct BadgeType: View {
    var eventType: Schedule.EventType

    var body: some View {
        Text(eventType.rawValue)
            .font(.caption)
            .padding(5)
            .bold()
            .foregroundColor(.white)
            .background(getColorForEventType(eventType))
            .cornerRadius(8)
    }

    private func getColorForEventType(_ eventType: Schedule.EventType) -> Color {
        switch eventType {
        case .meal:
            return .blue
        case .networking:
            return .green
        case .keynote:
            return .purple
        case .panel:
            return .orange
        case .workshop:
            return .red
        case .breakoutSession:
            return .yellow
        case .all:
            return .orange
        }
    }
}
