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

// MARK: - Delegate functions
protocol MainControllerDelegate {
  
  func pushFavorites(controller: MainController)
  func pushDetailView(forCellViewModel cellViewModel: MediaCellViewModel, controller: MainController)
}

class MainController: UIViewController {
  
  var delegate: MainControllerDelegate?
  
  var viewModel: MainViewModel?
  
  private lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshMediaList), for: .valueChanged)
    refreshControl.tintColor = R.color.accentColor()
    return refreshControl
  }()
  
  private lazy var favoritesButton = UIBarButtonItem(image: R.image.icStar(),
                                                     style: .plain,
                                                     target: self,
                                                     action: #selector(didTapStar))
  
  private var searchController: UISearchController?
  
  private let disposeBag = DisposeBag()

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
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    getMedia()
  }
  
  // MARK: - Setup Views
  private func initViews() {
    let accentColor = R.color.accentColor() ?? UIColor()
    
    if #available(iOS 13.0, *) {
      navigationController?.navigationBar.barTintColor = .systemBackground
    } else {
      navigationController?.navigationBar.barTintColor = .white
    }

    navigationController?.navigationBar.tintColor = R.color.accentColor()
    navigationController?
      .navigationBar
      .titleTextAttributes = [NSAttributedString.Key.foregroundColor: accentColor]

    favoritesButton.tintColor = R.color.accentColor()
    
    searchController = UISearchController(searchResultsController: nil)
    searchController?.searchResultsUpdater = self
    searchController?.obscuresBackgroundDuringPresentation = false
    searchController?.searchBar.placeholder = "Search Media"
    definesPresentationContext = true
    
    navigationItem.hidesSearchBarWhenScrolling = false
    navigationItem.searchController = searchController
    navigationItem.rightBarButtonItem = favoritesButton
    
    tableView.addSubview(refreshControl)

    tableView.register(R.nib.mediaCell)
    
    tableView.delegate = self
  }
  
  // MARK: - Main network request
  private func getMedia() {
    showActivityIndicator()
    
    viewModel?.getMedia(completion: { [weak self] isSuccess, errorOrNil in
      if isSuccess {
        self?.hideActivityIndicator()
      } else {
        self?.showErrorMessage(title: "Something went wrong",
                               message: errorOrNil?.localizedDescription ?? "")
      }
    })
  }
  
  // MARK: - @objc functions
  @objc private func refreshMediaList() {
    refreshControl.beginRefreshing()
    
    viewModel?.getMedia(completion: { isSuccess, errorOrNil in
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
        self?.refreshControl.endRefreshing()
      }
    })
  }
  
  @objc private func didTapStar() {
    delegate?.pushFavorites(controller: self)
  }
  
  // MARK: - Initialize Observable bindings
  private func initObservables() {
    viewModel?
      .cellViewModels()
      .bind(to: tableView
        .rx
        .items(cellIdentifier: R.nib.mediaCell.identifier,
               cellType: MediaCell.self)) { index, cellViewModel, cell in
        cell.initCell(cellViewModel)
        cell.delegate = self
    }.disposed(by: disposeBag)
    
    searchController?
      .searchBar
      .rx
      .text
      .orEmpty
      .distinctUntilChanged()
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .subscribe(onNext: { [weak self] query in
        self?.viewModel?.filterMedia(query: query)
      }).disposed(by: disposeBag)

    tableView
      .rx
      .itemSelected
      .subscribe(onNext: { [weak self] indexPath in
        guard let s = self,
              let cell = s.tableView.cellForRow(at: indexPath) as? MediaCell,
              let cellViewModel = cell.cellViewModel
        else { return }
        
        s.delegate?.pushDetailView(forCellViewModel: cellViewModel, controller: s)
      }).disposed(by: disposeBag)
  }
  
  // MARK: - Private functions
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
  
  // MARK: - IBActions
  @IBAction func didTapTryAgain(_ sender: Any) {
    getMedia()
  }
}

extension MainController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}

extension MainController: UISearchResultsUpdating {
  
  func updateSearchResults(for searchController: UISearchController) { }
}

extension MainController: MediaCellDelegate {
  
  func didTapFavorites(_ cellViewModel: MediaCellViewModel) {
    viewModel?.addToFavorites(cellViewModel)
  }
}
