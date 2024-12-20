//
//  KeybooardState.swift
//  Listener
//
//  Created by Stephen Rowe on 12/10/24.
//

import Foundation
import MIDIKitIO

typealias MIDINumber = UInt7
typealias MIDIStateArray = Array<Bool>
import SwiftUI



class KeyboardState: ObservableObject{
    
    @Published var keyState: MIDIStateArray = Array(repeating: false, count: 120)
    var midinotes: Array<(String,Int)> = Array(repeating: (name: "C",octave: -2), count: 120)
    init(){
        
        var runningCount = 0
        let name = ["C","C#","D","D#","E","F","F#","G","G#","A","A#","B"]
        for octave in -2..<8{
            for index in 0..<12 {
                midinotes[runningCount + index] = (name[index],octave)
            }
            runningCount += 12
        }
    }
    
    public var debugOut = false
    
    public func getStatus(_ midinum: MIDINumber) -> Bool{
        if midinum >= 0 && midinum < 120{
            if debugOut {
                print("Key \(midinum) status \(keyState[Int(midinum)])")
            }
            return keyState[Int(midinum)]
        } else{
            print("Invalid Midinote \(midinum)")
        }
        
        return false
    }
    public func getStatusString(_ midinum: MIDINumber) -> String {
        if midinum >= 0 && midinum < 120{
            var name = midinotes[Int(midinum)]
            var string = name.0 + "\(name.1)"
            return String( "Note \(string) Key \(midinum) \(keyState[Int(midinum)] )")
        }else {
            print("Invalid midinote \(midinum)")
        }
        return "Invalid Midinote \(midinum)"
    }
    
    
    
    public func getOnOffStatusAll() -> String {
        var stringAll = ""
        for note in keyState {
            if note == true {
                stringAll += "_"
            }
            else{
                stringAll += "|"
            }
        }
        return stringAll
        
    }
    
    public func setStatus(_ midinum: MIDINumber, status: Bool) {
        if midinum >= 0 {
            if debugOut {
                print("Key \(midinum) set to \(status)")
            }
            keyState[Int(midinum)] = status
        }
    }
    
}
