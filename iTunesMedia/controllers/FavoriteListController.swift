//
//  FavoriteListController.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 4/28/21.
//  Copyright © 2021 dummy. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class FavoriteListController: UIViewController {

  var viewModel: FavoriteViewModel?
  
  private let disposeBag = DisposeBag()
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initViews()
    initObservables()
  }
  
  private func initViews() {
    tableView.register(R.nib.mediaCell)
    
    tableView.delegate = self
  }
  
  private func initObservables() {
    viewModel?.getFavorites()
    
    viewModel?
      .cellViewModels()
      .bind(to: tableView
              .rx
              .items(cellIdentifier: R.nib.mediaCell.identifier,
                     cellType: MediaCell.self)) { index, cellViewModel, cell in
        cell.initCell(cellViewModel)
        cell.delegate = self
      }.disposed(by: disposeBag)
  }
}

extension FavoriteListController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}

extension FavoriteListController: MediaCellDelegate {
  
  func didTapFavorites(_ cellViewModel: MediaCellViewModel) {
    viewModel?.removeFromFavorites(cellViewModel)
  }
}
