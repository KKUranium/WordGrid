//
//  GridView.swift
//  WordGrid
//
//  Created by krishna on 17/08/19.
//  Copyright © 2019 Krishna. All rights reserved.
//

import UIKit

class GridView: UIView {
    override var frame: CGRect {
        didSet {
            
        }
    }
    
    private var viewModel: GridViewModel? {
        didSet {
            self.refreshDataSource(model: viewModel!)
        }
    }
    private var gridSize : Int?
    
    private var cellSize = CGSize.zero
    private var gridCellMatrix = [[GridCell]]()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateCellSize(gridSize: gridSize!)
        self.updateFrameForGridCells()
    }
    
    func updateDataSource(model: GridViewModel) {
        viewModel = model
        self.configureGridUI()
        self.createGrid()
    }
    
    func refreshDataSource(model: GridViewModel) {
        
    }
}

private extension GridView {
    func createGrid() {
        guard let matrixSize = viewModel?.gridView?.count else {
            return
        }
        
        gridSize = matrixSize
        gridCellMatrix = [[GridCell]]()
        
        for col in (viewModel?.gridView)! {
            var arrayOfCells = [GridCell]()
            for cellViewModel in col {
                let cell = self.createGridCell()
                self.updateFrameForCell(cell: cell, index: cellViewModel.index!)
                self.updateGridCell(cell: cell,model: cellViewModel)
                arrayOfCells.append(cell)
            }
            gridCellMatrix.append(arrayOfCells)
        }
    }
    
    func updateCellSize(gridSize: Int) {
        let height = self.getGridCellHeight(rows: gridSize)
        let width = self.getGridCellWidth(columns: gridSize)
        cellSize = CGSize.init(width: width, height: height)
    }
    
    func configureGridUI() {
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 1
    }
    
    func refreshGridCells() {
        
    }
}

private extension GridView {
    func getGridCellHeight(rows: Int) -> CGFloat {
        let height = self.frame.height
        return height / CGFloat(rows)
    }
    
    func getGridCellWidth(columns: Int) -> CGFloat {
        let width = self.frame.width
        return width / CGFloat(columns)
    }
    
    func createGridCell() -> GridCell {
        let gridCell = GridCell()
        self.addSubview(gridCell)
        return gridCell
    }
    
    func updateGridCell(cell: GridCell, model: GridCellViewModel) {
        cell.updateDataSource(model: model)
    }
    
    func updateFrameForGridCells() {
        guard gridCellMatrix.count > 0 else {
            return
        }
        
        var col = 0
        for columns in gridCellMatrix {
            var row = 0
            for cell in columns {
                self.updateFrameForCell(cell: cell, index: GridCellIndex(row: row, column: col))
                row += 1
            }
            col += 1
        }
    }
    
    func updateFrameForCell(cell: GridCell, index: GridCellIndex) {
        guard let row = index.row, let column = index.column else {
            return
        }
        
        let x = CGFloat(column) * cellSize.width
        let y = CGFloat(row) * cellSize.height
        
        let frame = CGRect.init(x: x, y: y, width: cellSize.width, height: cellSize.height)
        cell.frame = frame
    }
}
