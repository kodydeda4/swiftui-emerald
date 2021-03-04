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
    func encodeState<State>(_ state: State, stateURL: URL) -> Result<Bool, Error> where State : Codable {
        JSONEncoder().store(state, to: stateURL)
    }
    
    func decodeState<State>(_ state: State, stateURL: URL) -> Result<State, Error> where State : Codable {
        JSONDecoder().load(State.self, from: stateURL)
    }
    
    func exportConfig(_ data: String, configURL: URL) -> Result<Bool, DataManagerError> {
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

extension JSONEncoder {
    func store<T>(_ value: T, to url: URL) -> Result<Bool, Error> where T: Codable {
        do {
            try self
                .encode(value)
                .write(to: url)
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
}

extension JSONDecoder {
    func load<T>(_ type: T.Type, from url: URL) -> Result<T, Error> where T: Codable {
        do {
            let decoded = try self
                .decode(type.self, from: Data(contentsOf: url))
            return .success(decoded)
        }
        catch {
            return .failure(error)
        }
    }
}
