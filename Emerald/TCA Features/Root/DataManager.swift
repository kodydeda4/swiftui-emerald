//
//  DataManager.swift
//  Emerald
//
//  Created by Kody Deda on 3/4/21.
//

import Foundation
import ComposableArchitecture

public enum DataManagerError: Error {
    case encodeState
    case decodeState
    case exportConfig
    case none
}

public struct DataManager<State> where State: Codable {
    let homeURL = URL(fileURLWithPath: NSHomeDirectory())
    let stateURLFilename: String
    let configURLFilename: String
    var stateURL : URL { homeURL.appendingPathComponent(stateURLFilename) }
    var configURL: URL { homeURL.appendingPathComponent(configURLFilename) }
    
    func encodeState<State>(_ state: State) -> Result<Bool, DataManagerError> where State : Encodable {
        do {
            try JSONEncoder()
                .encode(state)
                .write(to: stateURL)
            return .success(true)
        } catch {
            return .failure(.encodeState)
        }
    }
    func decodeState<State>(_ state: State) -> Result<State, DataManagerError> where State : Decodable {
        do {
            let decoded = try JSONDecoder()
                .decode(type(of: state), from: Data(contentsOf: stateURL))
            return .success(decoded)
        }
        catch {
            return .failure(.decodeState)
        }
    }
    func exportConfig(_ data: String) -> Result<Bool, DataManagerError> {
        do {
            let data: String = data
            try data.write(to: configURL, atomically: true, encoding: .utf8)
            
            return .success(true)
        }
        catch {
            return .failure(.exportConfig)
        }
    }
}

extension DataManager: Equatable {}
