//
//  FileManager-Decodable.swift
//  NameToAFace
//
//  Created by Helen Dempsey on 5/26/25.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
