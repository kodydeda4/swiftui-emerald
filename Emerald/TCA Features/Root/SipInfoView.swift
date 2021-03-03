//
//  SipInfoView.swift
//  Emerald
//
//  Created by Kody Deda on 3/2/21.
//

import SwiftUI

//What is System Integrity Protection and why does it need to be disabled?
//https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection
//
//**** For BigSur you have to follow extra steps to automatically load SA.
//https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)#macos-big-sur---automatically-load-scripting-addition-on-startup
//
//- focus/create/destroy space without animation
//- move space (and its windows) left, right or to another display
//- remove window shadows
//- enable window transparency
//- control window layers (make windows appear topmost)
//- sticky windows (make windows appear on all spaces)
//- move window by clicking anywhere in its frame
//- toggle picture-in-picture for any given window
//- border for focused and inactive windows

let foo =
"""
System Integrity Protection is a security feature of macOS which restricts modification of certain files and directories, even by the root user or with root privileges (sudo). Some advanced features require modifications to the macOS window server, which requires partially disabling SIP.

Partially disabling SIP is required for the following features to work:

- Modify window shadows
- Modify window transparency
- Modify window borders
- Any-window 'picture-in-picture'
- Enable 'always-on-top' for floating windows
- Select 'sticky-windows to appear on all spaces
- Toggle space animations (focus/create/destroy)
- Move spaces & windows together
"""

struct SipInfoView: View {
    
    var body: some View {
        Form {
            Text("System Integrity Protection")
                .font(.largeTitle)
                .fontWeight(.medium)
                
            Text("What is System Integrity Protection?")
                .font(.title2)
                .padding(.vertical)
            
            Text(foo)
                .font(.body)
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
    }
}

struct SipInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SipInfoView()
    }
}

