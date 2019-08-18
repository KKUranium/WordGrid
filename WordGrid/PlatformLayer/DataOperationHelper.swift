//
//  DataOperationHelper.swift
//  WordGrid
//
//  Created by krishna on 18/08/19.
//  Copyright © 2019 Krishna. All rights reserved.
//

import Foundation

class DataOperationHelper {
    static func getJsonFromFile(fileName: String, bundle: Bundle) -> Data? {
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                print(error)
            }
        }
        return nil
    }
}
