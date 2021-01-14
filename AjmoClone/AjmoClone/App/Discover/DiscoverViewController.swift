//
//  DiscoverViewController.swift
//  AjmoClone
//
//  Created Luka Šarčević on 11.01.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit

protocol DiscoverDisplayLogic: class { }

class DiscoverViewController: UIViewController {
  var presenter: DiscoverViewPresentingLogic?
  private lazy var contentView = DiscoverContentView()
  private var dataSource: DiscoverDataSource?
  
  override func loadView() {
    view = contentView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    presenter?.onViewLoaded()
  }
}

// MARK: - DiscoverDisplayLogic
extension DiscoverViewController: DiscoverDisplayLogic { }

private extension DiscoverViewController {
  func setupView() {
    setupContentView()
  }
  
  func setupContentView() {
    contentView.backgroundColor = .systemPink
  }
}
