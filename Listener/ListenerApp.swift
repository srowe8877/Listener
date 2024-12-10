//
//  ListenerApp.swift
//  Listener
//
//  Created by Stephen Rowe on 12/10/24.
//

import SwiftUI

@main
struct ListenerApp: App {
    public var midiHelper = MIDIHelper()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
