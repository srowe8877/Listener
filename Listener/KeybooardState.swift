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



struct KeyboardState {
    
    private var keyState: MIDIStateArray = Array(repeating: false, count: 128)
    
    public var debugOut = true
    
    public func getStatus(_ midinum: MIDINumber) -> Bool{
        if midinum >= 0 {
            if debugOut {
                print("Key \(midinum) status \(keyState[Int(midinum)])")
            }
            return keyState[Int(midinum)]
        }
        print("Should never see this.")
        return false
    }
    
    public mutating func setStatus(_ midinum: MIDINumber, status: Bool) {
        if midinum >= 0 {
            if debugOut {
                print("Key \(midinum) set to \(status)")
            }
            keyState[Int(midinum)] = status
        }
    }
    
}
