//
//  FileLoader.swift
//  wallbox-test
//
//  Created by Cristian Carlassare on 03/03/2025.
//

import Foundation

enum FileLoaderError: Error {
    case fileNotFound(String)
    case dataLoadingError(Error)
    case decodingError(Error)
}

struct FileLoader {
    private init() {}
        
    static func loadJSON<T: Decodable>(filename: String, as type: T.Type) throws -> T {
        
        guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
            throw FileLoaderError.fileNotFound(filename)
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            return try decoder.decode(T.self, from: data)
            
        } catch let error as DecodingError {
            throw FileLoaderError.decodingError(error)
            
        } catch {
            throw FileLoaderError.dataLoadingError(error)
        }
    }
}
