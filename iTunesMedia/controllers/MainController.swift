//
//  MainController.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 9/8/20.
//  Copyright © 2020 dummy. All rights reserved.
//

import RxCocoa
import RxSwift
import StatefulTableView
import UIKit

protocol MainControllerDelegate {
  
  func didTapMedia(forIndexPath indexPath: IndexPath, controller: MainController)
}

class MainController: UIViewController {
  
  var delegate: MainControllerDelegate?
  
  let disposeBag = DisposeBag()
  
  let viewModel = MainViewModel()

  @IBOutlet weak var tableView: StatefulTableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initViews()
    initTableView()
    initObservables()
  }
  
  private func initViews() {
    let accentColor = R.color.accentColor() ?? UIColor()
    
    if #available(iOS 13.0, *) {
      navigationController?.navigationBar.barTintColor = .systemBackground
    } else {
      navigationController?.navigationBar.barTintColor = .white
    }

    navigationController?
      .navigationBar
      .titleTextAttributes = [NSAttributedString.Key.foregroundColor: accentColor]
  }
  
  private func initTableView() {
    tableView.separatorStyle = .none
    tableView.innerTable.register(R.nib.mediaCell)
    
    tableView.delegate = self
    tableView.statefulDelegate = self
    tableView.canLoadMore = false
    tableView.canPullToRefresh = true
    
    tableView.triggerInitialLoad()
  }
  
  private func initObservables() {
    viewModel
      .cellViewModels()
      .bind(to: tableView
        .innerTable
        .rx
        .items(cellIdentifier: R.nib.mediaCell.identifier,
               cellType: MediaCell.self)) { index, cellViewModel, cell in
                 cell.initCell(cellViewModel)
    }.disposed(by: disposeBag)
    
    tableView
      .innerTable
      .rx
      .itemSelected
      .subscribe(onNext: { indexPath in
        self.delegate?.didTapMedia(forIndexPath: indexPath, controller: self)
      }).disposed(by: disposeBag)
  }
}

extension MainController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}

extension MainController: StatefulTableDelegate {
  
  func statefulTable(_ tableView: StatefulTableView,
                     initialLoadCompletion completion: @escaping InitialLoadCompletion) {
    statefulTable(tableView, pullToRefreshCompletion: completion)
  }
  
  func statefulTable(_ tableView: StatefulTableView,
                     pullToRefreshCompletion completion: @escaping InitialLoadCompletion) {
    viewModel.getMedia(completion: completion)
  }
  
  func statefulTable(_ tableView: StatefulTableView,
                     loadMoreCompletion completion: @escaping LoadMoreCompletion) {
    completion(false, nil, false)
  }
  
  func statefulTable(_ tableView: StatefulTableView,
                     initialLoadWithError errorOrNil: NSError?,
                     errorView: InitialLoadErrorView) -> UIView? {
    errorView.labelText = errorOrNil?.localizedDescription
    errorView.shouldShowRetryButton = true
    return errorView
  }
}
