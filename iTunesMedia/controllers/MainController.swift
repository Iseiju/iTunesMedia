//
//  MainController.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 9/8/20.
//  Copyright © 2020 dummy. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

protocol MainControllerDelegate {
  
  func didTapMedia(forCellViewModel cellViewModel: MediaCellViewModel,
                   controller: MainController)
}

class MainController: UIViewController {
  
  var delegate: MainControllerDelegate?
  
  var viewModel: MainViewModel?
  
  let disposeBag = DisposeBag()

  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var activityIndicatorView: UIView!
  
  @IBOutlet weak var errorStackView: UIStackView!
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var messageLabel: UILabel!
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initViews()
    initObservables()
    
    getMedia()
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
    
    tableView.register(R.nib.mediaCell)
    
    tableView.delegate = self
  }
  
  private func getMedia() {
    showActivityIndicator()
    
    viewModel?.getMedia(completion: { isSuccess, errorOrNil in
      if isSuccess {
        self.hideActivityIndicator()
      } else {
        self.showErrorMessage(title: "Something went wrong",
                              message: errorOrNil?.localizedDescription ?? "")
      }
    })
  }
  
  private func initObservables() {
    viewModel?
      .cellViewModels()
      .bind(to: tableView
        .rx
        .items(cellIdentifier: R.nib.mediaCell.identifier,
               cellType: MediaCell.self)) { index, cellViewModel, cell in
                 cell.initCell(cellViewModel)
    }.disposed(by: disposeBag)
    
    tableView
      .rx
      .itemSelected
      .subscribe(onNext: { [weak self] indexPath in
        guard let s = self,
              let cellViewModel = s.viewModel?.cellViewModels().value[indexPath.row]
        else { return }
        
        s.delegate?.didTapMedia(forCellViewModel: cellViewModel, controller: s)
      }).disposed(by: disposeBag)
  }
  
  private func showActivityIndicator() {
    activityIndicatorView.isHidden = false
    errorStackView.isHidden = true
    activityIndicator.startAnimating()
  }
  
  private func hideActivityIndicator() {
    activityIndicator.stopAnimating()
    activityIndicatorView.isHidden = true
  }
  
  private func showErrorMessage(title: String, message: String) {
    activityIndicator.stopAnimating()
    errorStackView.isHidden = false
    
    titleLabel.text = title
    messageLabel.text = message
  }
  
  @IBAction func didTapTryAgain(_ sender: Any) {
    getMedia()
  }
}

extension MainController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}
