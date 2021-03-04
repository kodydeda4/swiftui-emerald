//
//  DataManager.swift
//  Emerald
//
//  Created by Kody Deda on 3/4/21.
//

import Foundation
import ComposableArchitecture

public struct DataManager<State> where State: Codable {
    func genericEncodeState<State>(_ state: State, url: URL) -> Result<Bool, Error> where State : Encodable {
        do {
            try JSONEncoder()
                .encode(state)
                .write(to: url)
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    func genericDecodeSettings<State>(_ state: State, url: URL) -> Result<State, Error> where State : Decodable {
        do {
            let decoded = try JSONDecoder()
                .decode(type(of: state), from: Data(contentsOf: url))
            return .success(decoded)
        }
        catch {
            return .failure(error)
        }
    }
    func genericExportConfig(_ data: String, url: URL) -> Result<Bool, Error> {
        do {
            let data: String = data
            try data.write(to: url, atomically: true, encoding: .utf8)
            
            return .success(true)
        }
        catch {
            return .failure(error)
        }
    }
}

extension DataManager: Equatable {}
