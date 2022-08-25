//
//  PreparedEntities.swift
//  PryanikiTestApp
//
//  Created by Boris on 25.08.2022.
//

import Foundation
import UIKit

enum CellType {
    case text
    case textAndPicture
    case selector
    case none
}

class CommonData {
    var id: String
    var cellType: CellType
    
    var textToDisplay: String?
    var imageUrlToLoad: String?
    
    init(id: String, cellType: CellType, textToDisplay: String? = nil, imageUrlToLoad: String? = nil){
        self.id = id
        self.cellType = cellType
        self.textToDisplay = textToDisplay
        self.imageUrlToLoad = imageUrlToLoad
    }
}
