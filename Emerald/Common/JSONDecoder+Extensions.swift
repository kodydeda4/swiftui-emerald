//
//  JSONDecoder+Extensions.swift
//  Emerald
//
//  Created by Kody Deda on 5/10/21.
//

import Foundation


extension JSONDecoder {
    
    func decodeState<State>(_ type: State.Type, from url: URL) -> Result<State, Error> where State: Codable {
        do {
            let decoded = try JSONDecoder().decode(type.self, from: Data(contentsOf: url))
            return .success(decoded)
        }
        catch {
            return .failure(error)
        }
    }
}

extension JSONEncoder {
    func writeState<State>(_ state: State, to url: URL) -> Result<Bool, Error> where State: Codable {
        let startDate = Date()
        
        print("writeState: to: '\(url.path)'")
        do {
            try JSONEncoder()
                .encode(state)
                .write(to: url)
            
            print("\(Date()) elapsed: '\(startDate.timeIntervalSinceNow * -1000) ms'")
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    
    
    func writeConfig(_ config: String, to url: URL) -> Result<Bool, Error> {
        do {
            let data: String = config
            try data.write(to: url, atomically: true, encoding: .utf8)
            return .success(true)
        }
        catch {
            return .failure(error)
        }
    }
}
