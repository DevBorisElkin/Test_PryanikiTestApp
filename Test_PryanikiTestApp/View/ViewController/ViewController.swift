//
//  ViewController.swift
//  PryanikiTestApp
//
//  Created by Boris on 25.08.2022.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var responseViewModel: ResponseViewModel? = ResponseViewModel()
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        loadData()
    }
    
    private func prepareTableView(){
        tableView.register(TextTableViewCell.nib, forCellReuseIdentifier: TextTableViewCell.reuseId)
        tableView.register(ImageTableViewCell.nib, forCellReuseIdentifier: ImageTableViewCell.reuseId)
        tableView.register(TextSelectorTableViewCell.nib, forCellReuseIdentifier: TextSelectorTableViewCell.reuseId)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        responseViewModel?.bindDataToTableView(tableView: tableView)
        responseViewModel?.bindHeightForRowAt(tableView: tableView)
        subscribeToSelectedItemChanged()
    }
    
    private func loadData() {
        NetworkingFetcher.makeDataRequest { [weak self] data in
            self?.responseViewModel?.data.accept(data)
        }
    }
    
    private func subscribeToSelectedItemChanged(){
        guard let viewModel = responseViewModel else { return }
        
        viewModel.selectedCellViewModel.skip(1).subscribe{ [weak self] selectedModel in
            if let element = selectedModel.element {
                let alertController = UIHelpers.createAlertControllerForSelectedRow(viewModel: element)
                self?.present(alertController, animated: true)
            }
        }.disposed(by: disposeBag)
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = responseViewModel else { return }
        viewModel.selectRow(atIndexPath: indexPath)
    }
}

