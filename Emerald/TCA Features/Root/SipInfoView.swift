//
//  SipInfoView.swift
//  Emerald
//
//  Created by Kody Deda on 3/2/21.
//

import SwiftUI

let sectionA =
"""
System Integrity Protection is a security feature of macOS. It restricts the modification of certain
files and directories even to root users or those with root privileges (sudo).

The following features require (partially) disabling System Integrity Protection to
establish a connection to the macOS window server:

• Window Shadows
• Window Transparency
• Window Borders
• Sticky-Windows that appear in all spaces
• Picture-in-Picture mode for all windows
• Always-on-top for Floating Windows
"""

let description2 =
"""
1. Restart your Mac while holding Command-R to boot into recovery mode.
2. Open a Terminal from the menubar (Utilities > Terminal)
4. Follow the instructions specific to your macOS version.
"""

//What is System Integrity Protection and why does it need to be disabled?
//https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection
//
//**** For BigSur you have to follow extra steps to automatically load SA.
//https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)#macos-big-sur---automatically-load-scripting-addition-on-startup


struct SipInfoView: View {
    
    var body: some View {
        List {
            Text("What is it, and why does it need to be disabled?")
                .bold()
            Text(sectionA)
                .foregroundColor(.gray)

            Divider()
            
            Text("How To Disable System Integrity Protection")
                .bold()
            Text(description2)
                .foregroundColor(.gray)
            
            Form {
                Text("High Sierra")
                TextField("", text: .constant("csrutil disable"))
                
                Text("Mojave & Catalina")
                TextField("", text: .constant("csrutil enable --without debug --without fs"))
                
                Text("Big Sur")
                TextField("", text: .constant("csrutil disable --with kext --with dtrace --with nvram --with basesystem"))
            }
        }
        .navigationTitle("System Integrity Protection")
    }
}

struct SipInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SipInfoView()
    }
}

