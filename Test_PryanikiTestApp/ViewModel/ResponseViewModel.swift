//
//  ResponseViewModel.swift
//  PryanikiTestApp
//
//  Created by Boris on 25.08.2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxRelay

class ResponseViewModel {
    
    var disposeBag = DisposeBag()
    
    var data: BehaviorRelay<[CommonData]> = BehaviorRelay(value: [])
    var selectedCellViewModel: BehaviorRelay<SelectedCellViewModel> = BehaviorRelay(value: SelectedCellViewModel())
    
    func bindDataToTableView(tableView: UITableView){
        data.bind(to: tableView.rx.items){(tv, row, item) -> UITableViewCell in

            let textToDisplay: String = item.textToDisplay ?? ".None"
            let imageUrl: String = item.imageUrlToLoad ?? ".Selector.None"
            
            if item.cellType == .text {
                let textCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.reuseId, for: IndexPath.init(row: row, section: 0)) as! TextTableViewCell
                let cellViewModel = TextTableViewCellViewModel(textToDisplay: textToDisplay)
                textCell.setUp(viewModel: cellViewModel)
                return textCell
            }else if item.cellType == .textAndPicture{
                let imageCell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.reuseId, for: IndexPath.init(row: row, section: 0)) as! ImageTableViewCell
                let cellViewModel = ImageTableViewCellViewModel(textToDisplay: textToDisplay, imageUrlToLoad: imageUrl)
                imageCell.setUp(viewModel: cellViewModel)
                return imageCell
            }else if item.cellType == .selector{
                let selectorCell = tableView.dequeueReusableCell(withIdentifier: TextSelectorTableViewCell.reuseId, for: IndexPath.init(row: row, section: 0)) as! TextSelectorTableViewCell
                let cellViewModel = SelectorTableViewCellViewModel(textToDisplay: textToDisplay)
                selectorCell.setUp(viewModel: cellViewModel)
                return selectorCell
            }else{
                return UITableViewCell()
            }
            
        }.disposed(by: disposeBag)
    }
    
    func bindHeightForRowAt(tableView: UITableView) {
        data.map { Dictionary(uniqueKeysWithValues: $0.enumerated().map { [weak self] in (IndexPath(row: $0.offset, section: 0), self?.getCellHeight(data: $0.element) ?? 100
            )}) }
            .bind(to: tableView.rx.heightForRowAt)
            .disposed(by: disposeBag)
    }
    
    private func getCellHeight(data: CommonData) -> CGFloat{
        switch data.cellType {
        case .text:
            return 40
        case .textAndPicture:
            return 138
        case .selector:
            return 62
        default:
            return 200
        }
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        selectedCellViewModel.accept(SelectedCellViewModel(idOfSelectedItem: indexPath.row, nameOfSelectedItem: data.value[indexPath.row].id))
    }
}
