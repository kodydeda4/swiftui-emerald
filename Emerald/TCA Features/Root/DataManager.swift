//
//  DataManager.swift
//  Emerald
//
//  Created by Kody Deda on 3/4/21.
//

import Foundation
import ComposableArchitecture

extension JSONEncoder {
    func writeState<State>(_ state: State, to url: URL) -> Result<Bool, Error> where State: Codable {
        do {
            try self
                .encode(state)
                .write(to: url)
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
}

extension JSONDecoder {
    func loadState<T>(_ type: T.Type, from url: URL) -> Result<T, Error> where T: Codable {
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

extension JSONDecoder {
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
