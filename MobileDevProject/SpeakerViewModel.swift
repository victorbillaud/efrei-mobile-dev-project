//
//  SpeakerViewModel.swift
//  MobileDevProject
//
//  Created by Théophile Dal on 22/01/2024.
//

import SwiftUI

class SpeakerLibrary {
    var speakerDictionary: [String: SpeakerInfo] = [:]

    func addValue(forID id: String, value: SpeakerInfo) {
        speakerDictionary[id] = value
    }

    func getValue(forID id: String) -> SpeakerInfo? {
        return speakerDictionary[id]
    }
}

class SpeakerViewModel: ObservableObject {
    @Published var speakersLib = SpeakerLibrary()
    
    private let requestFactory: RequestFactoryProtocol = RequestFactory()
    
    func fetchSpeakerLibrary() {
        requestFactory.getSpeakerList { [self] speakers in
            for speaker in speakers!.result
            {
                speakersLib.addValue(forID: speaker.id, value: speaker.details)
            }
        }
    }
}
