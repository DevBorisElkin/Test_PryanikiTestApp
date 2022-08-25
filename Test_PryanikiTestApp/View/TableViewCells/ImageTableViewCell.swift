//
//  ImageTableViewCell.swift
//  PryanikiTestApp
//
//  Created by Boris on 25.08.2022.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    static let reuseId = "ImageTableViewCell"
    static let nib = UINib(nibName: ImageTableViewCell.reuseId, bundle: nil)
    
    @IBOutlet weak var webImageView: WebImageView!
    @IBOutlet weak var textToDiplay: UILabel!
    
    func setUp(viewModel: ImageTableViewCellViewModel){
        webImageView.set(imageURL: viewModel.imageUrlToLoad)
        textToDiplay.text = viewModel.textToDisplay
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
