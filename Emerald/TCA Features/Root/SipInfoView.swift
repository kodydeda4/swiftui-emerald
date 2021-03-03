//
//  SipInfoView.swift
//  Emerald
//
//  Created by Kody Deda on 3/2/21.
//

import SwiftUI

let description =
"""
System Integrity Protection is a security feature of macOS that restricts modification of certain files and directories even by the root user or with root privileges (sudo). Some features require partially disabling SIP to make modifications to the macOS window server, such as:

- modifying window shadows
- modifying window transparency
- creating window borders
- creating sticky-windows which appear on all spaces
- enabling 'picture-in-picture' mode for all windows
- enabling always-on-top floating windows
- toggling space animations (focus/create/destroy)
- moving spaces
"""

let description2 =
"""
1. Turn off your device
2. Hold down command ⌘R while booting.
3. In the menu bar, choose Utilities, then Terminal
"""

//What is System Integrity Protection and why does it need to be disabled?
//https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection
//
//**** For BigSur you have to follow extra steps to automatically load SA.
//https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)#macos-big-sur---automatically-load-scripting-addition-on-startup


struct SipInfoView: View {
    
    var body: some View {
        Form {
            Text("System Integrity Protection")
                .font(.largeTitle)
                .fontWeight(.medium)
                
            Text("What is System Integrity Protection and why does it need to be disabled?")
                .font(.title)
                .padding(.vertical)
            
            Text(description)
                .font(.body)
                .foregroundColor(.gray)
            
            Text("How do I disable System Integrity Protection?")
                .font(.title)
                .padding(.vertical)

            Text(description2)
                .font(.body)
                .foregroundColor(.gray)
            
            Group {
            Text("High Sierra")
            TextField("", text: .constant("csrutil disable"))
            
            Text("Mojave & Catalina")
            TextField("", text: .constant("csrutil enable --without debug --without fs"))

            Text("Big Sur")
            TextField("", text: .constant("csrutil disable --with kext --with dtrace --with nvram --with basesystem"))
            }




            Spacer()
        }
    }
}

struct SipInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SipInfoView()
    }
}

