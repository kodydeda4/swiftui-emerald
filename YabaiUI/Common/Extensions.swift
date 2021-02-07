//
//  Extensions.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/7/21.
//

import Foundation

//// https://www.hackingwithswift.com/example-code/strings/how-to-save-a-string-to-a-file-on-disk-with-writeto
//
//func writeToFile(contents: String) {
//
//    let filename =
//        getDocumentsDirectory()
//        .appendingPathComponent(".output")
//
//    do {
//        try contents.write(
//            to: filename,
//            atomically: true,
//            encoding: String.Encoding.utf8
//        )
//    } catch {
//        /* failed to write file:
//            - bad permissions,
//            - bad filename,
//            - missing permissions,
//         or more likely:
//            it can't be converted to the encoding */
//    }
//}
//
//func getDocumentsDirectory() -> URL {
//    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//    return paths[0]
//}
