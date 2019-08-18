//
//  GridCell.swift
//  WordGrid
//
//  Created by krishna on 18/08/19.
//  Copyright © 2019 Krishna. All rights reserved.
//

import UIKit

class GridCell: UIView {
    @IBOutlet weak var label: UILabel!
    @IBOutlet var contentView: UIView!
    
    private var viewModel: GridCellViewModel? {
        didSet {
            self.refreshUI()
        }
    }
    
    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.xibSetup()
        self.configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureLabel()
    }
    
    func updateDataSource(model: GridCellViewModel) {
        self.viewModel = model
    }

}

private extension GridCell {
    func refreshUI() {
        guard let bgColor = self.viewModel?.backgroundColor else {
            return
        }
        
        self.contentView.backgroundColor = bgColor
        self.updateLabel()
    }
    
    func configureUI() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.25
        self.configureLabel()
    }
    
    func configureLabel() {
        self.label.layer.cornerRadius = self.frame.height / 2
    }
    
    func updateLabel() {
        guard let text = self.viewModel?.textValue, let hoverColor = self.viewModel?.hoverColor else {
            return
        }
        self.label.text = text
        self.label.layer.backgroundColor = hoverColor.cgColor
    }
}
