//
//  GridViewModel.swift
//  WordGrid
//
//  Created by krishna on 17/08/19.
//  Copyright © 2019 Krishna. All rights reserved.
//

import UIKit

struct GridCellIndex {
    let row: Int?
    let column : Int?
}

struct GridCellViewModel {
    let textValue: String?
    var highlighted: Bool?
    let index : GridCellIndex?
    var hoverColor: UIColor?
    var backgroundColor: UIColor?
}

struct GridViewModel {
    var gridView : [[GridCellViewModel]]?
    var question: NSAttributedString?
    
    init(data: GridModel) {
        self.question = self.getQuestion(data: data)
        self.gridView = self.createGridViewModel(data: data.characterGrid)
    }
    
    private func createGridViewModel(data: [[String]]?) -> [[GridCellViewModel]]? {
        if let grid = data {
            var gridModel = [[GridCellViewModel]]()
            var column = 0
            for columns in grid {
                var columnModel = [GridCellViewModel]()
                var row = 0
                for character in columns {
                    let cellModel = GridCellViewModel(textValue: character, highlighted: false, index: GridCellIndex(row: row, column: column), hoverColor: UIColor.clear, backgroundColor: UIColor.init(red: 220/255, green: 222/255, blue: 224/255, alpha: 1.0))
                    columnModel.append(cellModel)
                    row += 1
                }
                gridModel.append(columnModel)
                column += 1
            }
            return gridModel
        }
        return nil
    }
    
    private func getLanguage(code: String) -> String {
        switch code {
        case "en":
            return "ENGLISH"
        case "es":
            return "SPANISH"
        default:
            return code.capitalized
        }
    }
    
    private func getQuestion(data: GridModel) -> NSAttributedString? {
        guard let sourceLanguage = data.sourceLanguage, let targetLanguage = data.targetLanguage, let word = data.word else {
            return nil
        }
        let numberOfAnswers = "\((data.wordLocations?.keys.count)!)"
        let sourceLang = self.getLanguage(code: sourceLanguage)
        let targetLang = self.getLanguage(code: targetLanguage)
        
        let boldAttrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 17, weight: .semibold)]
        let normalAttrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 17, weight: .regular)]
        
        let attribString = NSMutableAttributedString.init(string: "Find ", attributes: normalAttrs)
        attribString.append(NSAttributedString.init(string: numberOfAnswers, attributes: boldAttrs))
        attribString.append(NSAttributedString.init(string: " translated words in grid for ", attributes: normalAttrs))
        attribString.append(NSAttributedString.init(string: sourceLang, attributes: boldAttrs))
        attribString.append(NSAttributedString.init(string: " word ", attributes: normalAttrs))
        attribString.append(NSAttributedString.init(string: word.capitalized, attributes: boldAttrs))
        attribString.append(NSAttributedString.init(string: " in ", attributes: normalAttrs))
        attribString.append(NSAttributedString.init(string: targetLang, attributes: boldAttrs))
        attribString.append(NSAttributedString.init(string: "?", attributes: normalAttrs))
        
        return attribString
    }
}
