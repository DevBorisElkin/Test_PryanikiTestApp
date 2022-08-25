//
//  SelectedCellViewModel.swift
//  PryanikiTestApp
//
//  Created by Boris on 25.08.2022.
//

import Foundation

struct SelectedCellViewModel {
    var idOfSelectedItem: Int = 0
    var nameOfSelectedItem: String = ""
    
    init(idOfSelectedItem: Int = 0, nameOfSelectedItem: String = ""){
        self.idOfSelectedItem = idOfSelectedItem
        self.nameOfSelectedItem = nameOfSelectedItem
    }
}
