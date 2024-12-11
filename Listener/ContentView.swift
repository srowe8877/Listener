//
//  ContentView.swift
//  Listener
//
//  Created by Stephen Rowe on 12/10/24.
//

import SwiftUI

struct ContentView: View {
    
    
    var midiHelper: MIDIHelper
    @State var keyStates: KeyboardState
    
    
    init(midiHelper: MIDIHelper) {
        self.midiHelper = midiHelper
        keyStates = midiHelper.keyStates
    }
    
    
    var body: some View {
        
        VStack {
            Text(keyStates.getOnOffStatusAll())
        }
        
    }
}
/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
