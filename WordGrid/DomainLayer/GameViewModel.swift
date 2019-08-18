//
//  GameViewModel.swift
//  WordGrid
//
//  Created by krishna on 18/08/19.
//  Copyright © 2019 Krishna. All rights reserved.
//

import Foundation
struct GameViewModel {
    var gridArray: [GridViewModel]?
    
    init(data: [GridModel]) {
        self.gridArray = [GridViewModel]()
        for grid in data {
            let gridViewModel = GridViewModel.init(data: grid)
            self.gridArray?.append(gridViewModel)
        }
    }
}
