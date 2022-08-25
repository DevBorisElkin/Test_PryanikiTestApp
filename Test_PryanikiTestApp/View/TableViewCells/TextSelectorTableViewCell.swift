//
//  TextSelectorTableViewCell.swift
//  PryanikiTestApp
//
//  Created by Boris on 25.08.2022.
//

import UIKit

class TextSelectorTableViewCell: UITableViewCell {

    static let reuseId = "TextSelectorTableViewCell"
    static let nib = UINib(nibName: TextSelectorTableViewCell.reuseId, bundle: nil)
    
    @IBOutlet weak var textToDiplay: UILabel!
    
    func setUp(viewModel: SelectorTableViewCellViewModel){
        textToDiplay.text = viewModel.textToDisplay
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
