//
//  DataManager.swift
//  Emerald
//
//  Created by Kody Deda on 3/4/21.
//

import Foundation
import ComposableArchitecture

public struct DataManager<State> where State: Codable {
    let homeURL = URL(fileURLWithPath: NSHomeDirectory())
    let stateURLFilename: String
    let configURLFilename: String
    var stateURL : URL { homeURL.appendingPathComponent(stateURLFilename) }
    var configURL: URL { homeURL.appendingPathComponent(configURLFilename) }
    
    func encodeState<State>(_ state: State) -> Result<Bool, Error> where State : Encodable {
        do {
            try JSONEncoder()
                .encode(state)
                .write(to: stateURL)
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    func decodeState<State>(_ state: State) -> Result<State, Error> where State : Decodable {
        do {
            let decoded = try JSONDecoder()
                .decode(type(of: state), from: Data(contentsOf: stateURL))
            return .success(decoded)
        }
        catch {
            return .failure(error)
        }
    }
    func exportConfig(_ data: String) -> Result<Bool, Error> {
        do {
            let data: String = data
            try data.write(to: configURL, atomically: true, encoding: .utf8)
            
            return .success(true)
        }
        catch {
            return .failure(error)
        }
    }
}

extension DataManager: Equatable {}
