//
//  FileManager-Decodable.swift
//  BucketList
//
//  Created by Helen Dempsey on 5/18/25.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
    }
}
