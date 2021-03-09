//
//  SipInfoView.swift
//  Emerald
//
//  Created by Kody Deda on 3/2/21.
//

import SwiftUI

struct SystemIntegrityProtectionView: View {
    var body: some View {
        List {
            SectionView("What is System Integrity Protection?") {
                grayText(
                    """
                    System Integrity Protection is a security feature of macOS that restricts the modification of certain
                    files and directories even to root users or those with root privileges (sudo).
                    """
                )
                Link("Learn more", destination: URL(string: "https://tinyurl.com/xpr5jc")!)
            }
            SectionView("Why disable it?") {
                grayText(
                    """
                    Some features require a connection to the macOS window server, which can only be established by
                    partially disabling System Integrity Protection.
                    """
                )
            }
            SectionView("Extra Features") {
                grayText(
                    """
                    • Window Shadows
                    • Window Transparency
                    • Window Borders
                    • Sticky-Windows that appear in all spaces
                    • Picture-in-Picture mode for all windows
                    • Always-on-top for Floating Windows
                    """
                )
            }
            SectionView("Disabling System Integrity Protection") {
                grayText(
                    """
                    1. Boot into recovery mode by restarting your Mac while holding Command-R.
                    2. Open a Terminal from the menubar (Utilities > Terminal).
                    3. Run the specific command for your version of macOS.
                    4. Reboot to exit recovery mode and apply changes.
                    """
                )
                grayText("High Sierra")
                grayTextField("csrutil disable")
                grayText("Mojave & Catalina")
                grayTextField("csrutil enable --without debug --without fs")
                grayText("Big Sur")
                grayTextField("csrutil disable --with kext --with dtrace --with nvram --with basesystem")
            }
            SectionView("Installing the Yabai Scripting Additions") {
                grayText("After disabling System Integrity Protection, you need to install and load the scripting additions.")
                grayText("Open Terminal and run the following command:")
                grayTextField("sudo yabai --install-sa")
            }
            SectionView("Extra Steps for macOS 11.01 BigSur or later") {
                grayText("If you're running macOS 11.01 or later, you'll need to follow these steps to enable the scripting additions.")
                Link("How come?", destination: URL(string: "https://tinyurl.com/4mzr6bf5")!)
                grayText("Open Terminal and run the following commands:")
                Section {
                    grayText("1. Find your username")
                    grayTextField("whoami")
                    grayText("2. Open the automation script with visudo")
                    grayTextField("sudo visudo -f /private/etc/sudoers.d/yabai")
                    grayText("3. Press enter to switch to Insertion Mode")
                    grayText("4. Paste the following")
                    grayTextField("user ALL = (root) NOPASSWD: /usr/local/bin/yabai --load-sa")
                    grayText("5. Replace 'user' with your username")
                    grayText("6. Press esc to exit Insertion Mode")
                    grayText("7. Type :wq to save changes and exit visudo")
                }
            }
        }
        .navigationTitle("System Integrity Protection")
    }
}

extension SystemIntegrityProtectionView {
    func grayText(_ text: String) -> AnyView {
        AnyView(Text(text).foregroundColor(.gray))
    }
    
    func grayTextField(_ text: String) -> AnyView {
        AnyView(
            TextField("", text: .constant(text))
                .foregroundColor(.gray)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        )
    }
}

// MARK:- SystemIntegrityProtectionView_Previews
struct SystemIntegrityProtectionView_Previews: PreviewProvider {
    static var previews: some View {
        SystemIntegrityProtectionView()
    }
}

