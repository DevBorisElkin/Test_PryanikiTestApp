//
//  NetworkingFetcher.swift
//  PryanikiTestApp
//
//  Created by Boris on 25.08.2022.
//

import Foundation
import UIKit

class NetworkingFetcher {
    private static var urlToLoadDataFrom = "https://pryaniky.com/static/json/sample.json"
    
    static func makeDataRequest(completion: @escaping ([CommonData]) -> ()){
        
        WebService.executeUrl(urlString: urlToLoadDataFrom, type: PryanikiResultWrapped.self) { result, error in
            
            if let result = result {
                let populatedData = populateData(from: result)
                completion(populatedData)
            }else if let error = error {
                print("Error making request \(error)")
            }
        }
    }
    
    private static func populateData(from data: PryanikiResultWrapped) -> [CommonData] {
        let dataTypes: [CommonData] = data.data.map { data in
            if let textDescr = data.data.text, data.data.url == nil { // text obj
                return CommonData(id: data.name, cellType: .text, textToDisplay: textDescr)
            }else if let textDescr = data.data.text, let imageUrl = data.data.url { // image obj
                return CommonData(id: data.name, cellType: .textAndPicture, textToDisplay: textDescr, imageUrlToLoad: imageUrl)
            }else if let selectedId = data.data.selectedId, let variants = data.data.variants { // selector obj
                if let selectedText = variants.first(where: { $0.id == selectedId}) {
                    return CommonData(id: data.name, cellType: .selector, textToDisplay: selectedText.text)
                }
            }
            return CommonData(id: "none", cellType: .none)
        }
        
        var populatedData: [CommonData] = []
        for viewId in data.view {
            if let appropriateElement = dataTypes.first(where: { $0.id == viewId }) {
                populatedData.append(appropriateElement)
            }
        }
        
        return populatedData
    }
}
