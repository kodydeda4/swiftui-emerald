//
//  SipInfoView.swift
//  Emerald
//
//  Created by Kody Deda on 3/2/21.
//

import SwiftUI
import OmenTextField

let sectionA =
"""
System Integrity Protection is a security feature of macOS that restricts the modification of certain
files and directories even to root users or those with root privileges (sudo).
"""

let a2 =
"""
System Integrity Protection must be partially disabled to establish a connection with the macOS window server.
The following features require partially disabling System Integrity Protection:

• Window Shadows
• Window Transparency
• Window Borders
• Sticky-Windows that appear in all spaces
• Picture-in-Picture mode for all windows
• Always-on-top for Floating Windows
"""

let description2 =
"""
1. Boot into recovery mode by restarting your Mac while holding Command-R.
2. Open a Terminal from the menubar (Utilities > Terminal).
3. Run the specific command for your version of macOS.
4. Reboot to exit recovery mode and apply changes.
"""

let installAndLoadCommands =
"""
sudo yabai --load-sa
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
                    .font(.title3)
                Text(sectionA)
                    .foregroundColor(.gray)
                
                Link("Learn more", destination: URL(string: "https://en.wikipedia.org/wiki/System_Integrity_Protection")!)
            }
            Divider()
            Group {
                Text("Why disable it?")
                    .font(.title3)
                Text(a2)
                    .foregroundColor(.gray)
            }
            Divider()
            Group {
                Text("Disabling System Integrity Protection")
                    .font(.title3)
                
                Text(description2)
                    .foregroundColor(.gray)
            
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
            Divider()
            Group {
                Text("Final Steps")
                    .font(.title3)
                
                Text("After disabling System Integrity Protection, you need to install and load the scripting additions.")
                    .foregroundColor(.gray)
                
                Text("Open Terminal and run the following command:")
                    .foregroundColor(.gray)
            
                TextField("", text: .constant("sudo yabai --install-sa"))
                    .foregroundColor(.gray)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

            }
            Divider()
            Group {
                Text("Extra Steps for macOS 11.01 BigSur and above")
                    .font(.title3)
                
                HStack {
                    Text("If you're running macOS 11.01+ you'll have to edit a file with root priviledges to load the scripting additions automatically.")
                    .foregroundColor(.gray)
                    
                    Link("Learn more", destination: URL(string: "https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)#macos-big-sur---automatically-load-scripting-addition-on-startup")!)
                }
                
                Text("Open Terminal and run the following commands:")
                
                Text("1. Find your username")
                    .foregroundColor(.gray)
                
                TextField("", text: .constant("whoami"))
                    .foregroundColor(.gray)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                
                Text("2. Open the file with visudo")
                    .foregroundColor(.gray)
                
                Group {
                
                TextField("", text: .constant("sudo visudo -f /private/etc/sudoers.d/yabai"))
                    .foregroundColor(.gray)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("3. Press enter to switch to Insertion Mode")
                    .foregroundColor(.gray)
                
                Text("4. Write the following, replacing 'user' with your username")
                    .foregroundColor(.gray)

                TextField("", text: .constant("user ALL = (root) NOPASSWD: /usr/local/bin/yabai --load-sa"))
                    .foregroundColor(.gray)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                Text("5. Press esc to exit Insertion Mode")
                    .foregroundColor(.gray)
                    
                Text("6. Type :wq to save changes and exit visudo")
                    .foregroundColor(.gray)
                    
                }
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

