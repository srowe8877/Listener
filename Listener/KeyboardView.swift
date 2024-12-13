//
//  KeyboardView.swift
//  Listener
//
//  Created by Stephen Rowe on 12/12/24.
//

import SwiftUI
import CoreMIDI



final class KeyboardView: View, ObservableObject {
    
    

    @State var selectedDevice = ""
    @State var devices: [String] = []
    
    var body: some View {
        VStack {
            Text("Selected: \(selectedDevice)")
            Picker("Select Device", selection: $selectedDevice)  {
                ForEach(devices, id: \.self) { device in
                    Text("\(device)")
                }
            }
        }
        .padding()
        .fixedSize()
        .task {
            self.devices = self.getMIDIDeviceList()
        }
    }
    
    private func getMIDIDeviceList() -> [String] {
        var deviceNames = [String]()
        
        let numberOfDevices = MIDIGetNumberOfDevices()
        for index in 0..<numberOfDevices {
            let device = MIDIGetDevice(index)
            var name: Unmanaged<CFString>?
            MIDIObjectGetStringProperty(device, kMIDIPropertyName, &name)
            if let name = name {
                deviceNames.append(name.takeUnretainedValue() as String)
            }
        }
        return deviceNames
    }
}

/*
struct PianoKey: Shape {
    private let startAngle = Angle.radians(1.5 * .pi)
    
    var pressed: Bool = false
    
    func path(in rect: CGRect) -> Path {
        Path() { path in
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.width / 2,
                startAngle: startAngle,
                endAngle: startAngle +
                Angle(radians: 2 * .pi * progress),
                clockwise: false
            )
        }
    }
}
 */








/*
struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
    }
}*/
