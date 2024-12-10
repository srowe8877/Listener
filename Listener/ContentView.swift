//
//  ContentView.swift
//  Listener
//
//  Created by Stephen Rowe on 12/10/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var midiHelper: MIDIHelper
    
    init(midiHelper: MIDIHelper) {
        self.midiHelper = midiHelper
    }
    
    
    var body: some View {
        VStack {
            Text("")
        }
        .padding()
    }
}
/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
