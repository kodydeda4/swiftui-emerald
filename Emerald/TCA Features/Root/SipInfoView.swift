//
//  SipInfoView.swift
//  Emerald
//
//  Created by Kody Deda on 3/2/21.
//

import SwiftUI

let sectionA =
"""
System Integrity Protection is a security feature of macOS that restricts the modification of certain
files and directories even to root users or those with root privileges (sudo).
"""

let a2 =
"""
System Integrity Protection must be partially disabled to establish a connection with the macOS window server.
The following features require SIP to be partially disabled to work:

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
2. Open a Terminal from the menubar (Utilities > Terminal).
3. Run the command specific to your version of macOS:
"""

//What is System Integrity Protection and why does it need to be disabled?
//https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection
//
//**** For BigSur you have to follow extra steps to automatically load SA.
//https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)#macos-big-sur---automatically-load-scripting-addition-on-startup


struct SipInfoView: View {
    
    var body: some View {
        List {
            Group {
                Text("What is System Integrity Protection?")
                    .bold()
                Text(sectionA)
                    .foregroundColor(.gray)
                
                Link("Learn more", destination: URL(string: "https://en.wikipedia.org/wiki/System_Integrity_Protection")!)
            }
            Divider()
            Group {
                Text("Why disable it?")
                    .bold()
                Text(a2)
                    .foregroundColor(.gray)
            }
            Divider()
            Group {
                Text("Disabling System Integrity Protection")
                    .bold()
                Text(description2)
                    .foregroundColor(.gray)
            }
            
            Group {
                Text("High Sierra")
                TextField("", text: .constant("csrutil disable"))
                    .foregroundColor(.gray)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("Mojave & Catalina")
                TextField("", text: .constant("csrutil enable --without debug --without fs"))
                    .foregroundColor(.gray)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("Big Sur")
                TextField("", text: .constant("csrutil disable --with kext --with dtrace --with nvram --with basesystem"))
                    .foregroundColor(.gray)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
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

