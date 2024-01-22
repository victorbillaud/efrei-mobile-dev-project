//
//  AirTableService.swift
//  MobileDevProject
//
//  Created by Victor BILLAUD on 22/01/2024.
//

import Foundation
import UIKit

struct UrlImage: Codable {
    
    let url: String
    
    enum CodingKeys : String, CodingKey {
        case url = "url"
    }
}

struct ScheduleResponse: Decodable {
    let records: [Record]

    struct Record: Decodable {
        let id: String
        let createdTime: String
        let fields: Schedule
    }
}

struct Schedule: Identifiable, Decodable {
    var id = UUID()
    var activity: String
    var type: EventType
    var start: Date
    var end: Date
    var location: String
    var speakers: [String] // Assuming speakerID is a String, you might need to replace it with the actual type
    var notes: String?

    enum EventType: String, Decodable {
        case meal = "Meal"
        case networking = "Networking"
        case keynote = "Keynote"
        case panel = "Panel"
        case workshop = "Workshop"
        case breakoutSession = "Breakout session"
    }

    private enum CodingKeys: String, CodingKey {
        case activity = "Activity"
        case type = "Type"
        case start = "Start"
        case end = "End"
        case location = "Location"
        case speakers = "Speaker(s)"
        case notes = "Notes"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        activity = try container.decode(String.self, forKey: .activity)
        type = try container.decode(EventType.self, forKey: .type)
        location = try container.decode(String.self, forKey: .location)
        speakers = try container.decode([String].self, forKey: .speakers)
        notes = try container.decodeIfPresent(String.self, forKey: .notes)

        // Use a custom date formatter for the "Start" and "End" keys
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        start = try dateFormatter.date(from: container.decode(String.self, forKey: .start)) ?? Date()
        end = try dateFormatter.date(from: container.decode(String.self, forKey: .end)) ?? Date()
    }
}

let url_string = "https://api.airtable.com/v0/apps3Rtl22fQOI9Ph/%F0%9F%93%86%20Schedule?maxRecords=3&view=Full%20schedule"
let token = "patikQ2NLt8ZuefWF.bab4360644fa68db943fec3ff9db7a0bb990674f092136422b3a0be9212e229d"

protocol RequestFactoryProtocol {
    func createRequest(urlStr: String) -> URLRequest
    func getScheduleList(callback: @escaping ([Schedule]?) -> Void)
}

class RequestFactory: RequestFactoryProtocol{
    func createRequest(urlStr: String) -> URLRequest {
        let url = URL(string: urlStr)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    func getScheduleList(callback: @escaping ([Schedule]?) -> Void) {
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: createRequest(urlStr: url_string)) { data, response, error in
            guard error == nil, let data = data else {
                callback(nil)
                return
            }

            // Print the received JSON string for debugging
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received JSON: \(jsonString)")
            }

            guard let responseHttp = response as? HTTPURLResponse, responseHttp.statusCode == 200 else {
                callback(nil)
                return
            }

            do {
                let scheduleResponse = try JSONDecoder().decode(ScheduleResponse.self, from: data)
                let schedules = scheduleResponse.records.map { $0.fields }
                print(schedules)
                callback(schedules)
            } catch let decodingError {
                print("Decoding error: \(decodingError)")
                callback(nil)
            }
        }.resume()
    }

}

