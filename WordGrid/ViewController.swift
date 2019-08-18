//
//  ViewController.swift
//  WordGrid
//
//  Created by krishna on 16/08/19.
//  Copyright © 2019 Krishna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var gridView: GridView!
    @IBOutlet weak var questionLabel: UILabel!
    
    var viewModel: GameViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.prepareViewModel()
        self.configureUI()
    }

    func prepareViewModel() {
        if let json = DataOperationHelper.getJsonFromFile(fileName: "Grid", bundle: Bundle.main) {
            do {
                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                let model = try decoder.decode([GridModel].self, from:
                    json) //Decode JSON Response Data
                self.viewModel = GameViewModel.init(data: model)
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
    }
    
    func configureUI() {
        self.configureGrid()
        if let question = self.viewModel?.gridArray?[0].question {
            self.questionLabel.attributedText = question
        }
        else {
            self.questionLabel.text = ""
        }
    }
    
    func configureGrid() {
        self.gridView.updateDataSource(model: (self.viewModel?.gridArray?[0])!)
    }
}

