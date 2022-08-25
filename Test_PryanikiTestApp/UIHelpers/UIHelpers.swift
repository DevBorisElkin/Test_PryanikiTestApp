//
//  UIHelpers.swift
//  PryanikiTestApp
//
//  Created by Boris on 25.08.2022.
//

import Foundation
import UIKit

class UIHelpers {
    static func createAlertController(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel))
        return alert
    }
    
    static func createAlertControllerForSelectedRow(viewModel: SelectedCellViewModel) -> UIAlertController {
        createAlertController(title: "Selected item", message: "Selected item with id: \(viewModel.idOfSelectedItem)\n Name of selected item: \(viewModel.nameOfSelectedItem)")
    }
}
