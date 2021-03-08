//
//  DataManager.swift
//  Emerald
//
//  Created by Kody Deda on 3/4/21.
//

import Foundation

enum CacheError: Equatable, LocalizedError {
    case writeError(String)
    case loadError(String)
}

extension JSONEncoder {
    func writeState<State>(_ state: State, to url: URL) -> Result<Bool, CacheError> where State: Codable {
        let startDate = Date()
        
        print("writeState: to: '\(url.path)'")
        do {
            try self
                .encode(state)
                .write(to: url)

            print("\(Date()) elapsed: '\(startDate.timeIntervalSinceNow * -1000) ms'")
            return .success(true)
        } catch {
            return .failure(.writeError(error.localizedDescription))
        }
    }
}

extension JSONDecoder {
    func loadState<State>(_ type: State.Type, from url: URL) -> Result<State, CacheError> where State: Codable {
        do {
            let decoded = try self
                .decode(type.self, from: Data(contentsOf: url))
            return .success(decoded)
        }
        catch {
            return .failure(.loadError(error.localizedDescription))
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
