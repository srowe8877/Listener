//
//  MIDIHelper.swift
//  Listener
//
//  Created by Stephen Rowe on 12/10/24.
//

import Foundation
import MIDIKitIO


public class MIDIHelper: ObservableObject{
    
    
    
    private let midiManager = MIDIManager(
        clientName: "Listener",
        model: "Listener",
        manufacturer: "S Rowe"
    )
    
    let inputTag = "Listener"
    @Published var keyStates = KeyboardState()
    
    
    public init() {
        do {
            try midiManager.start()
            try midiManager.addInputConnection(to: .allOutputs, tag: inputTag,
                                               receiver: .events { [weak self] events, timeStamp, source in
                // Note: this handler will be called on a background thread so be
                // sure to call anything that may result in UI updates on the main thread
                DispatchQueue.main.async {
                    events.forEach { self?.received(midiEvent: $0) }
                }
            }
            )
            } catch {
                print("MIDI Setup Error:", error)
        }
    }
    
    
    private func received(midiEvent: MIDIEvent) {
        switch midiEvent {
            
        case .noteOn(let payload):
            print("\nNote On:", payload.note, payload.velocity, payload.channel)
            print("Check status \(keyStates.getStatus(payload.note.number))")
            keyStates.setStatus(payload.note.number, status: true)
            //print("Check status \(keyStates.getStatus(payload.note.number))")
            //print(keyStates.getOnOffStatusAll())
            print(keyStates.getStatusString(payload.note.number))
            
        case .noteOff(let payload):
            print("\nNote Off:", payload.note, payload.velocity, payload.channel)
            print("Check status \(keyStates.getStatus(payload.note.number))")
            keyStates.setStatus(payload.note.number, status: false)
            //print("Check status \(keyStates.getStatus(payload.note.number))")
            //print(keyStates.getOnOffStatusAll())
            print(keyStates.getStatusString(payload.note.number))
            
        case .cc(let payload):
            print("CC:", payload.controller, payload.value, payload.channel)
            
        case .programChange(let payload):
            print("Program Change:", payload.program, payload.channel)
            
        // etc...
            
        default:
            break
        }
    }
}
