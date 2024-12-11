//
//  ContentView.swift
//  Listener
//
//  Created by Stephen Rowe on 12/10/24.
//

import SwiftUI

struct ContentView: View {
    
    
    var midiHelper: MIDIHelper
    @ObservedObject var keyStates: KeyboardState
    
    
    init(midiHelper: MIDIHelper) {
        self.midiHelper = midiHelper
        keyStates = midiHelper.keyStates
        
        
        
    }
    
    
    var body: some View {
        
        VStack {
            Text(keyStates.getOnOffStatusAll()) // Try to get this to respond to changes in keyStates (aka--KeyboardState a member of MIDIHelper)
        }
        
        
    }
}
