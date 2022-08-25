//
//  PryanikiResultTableViewCell.swift
//  PryanikiTestApp
//
//  Created by Boris on 25.08.2022.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    static let reuseId = "TextTableViewCell"
    static let nib = UINib(nibName: TextTableViewCell.reuseId, bundle: nil)
    
    @IBOutlet weak var textToDiplay: UILabel!
    
    func setUp(viewModel: TextTableViewCellViewModel){
        textToDiplay.text = viewModel.textToDisplay
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
