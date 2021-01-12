//
//  HeaderView.swift
//  AjmoClone
//
//  Created by Luka Šarčević on 12.01.2021..
//

import UIKit
import SnapKit

class HeaderView: UICollectionReusableView {
  typealias ViewModel = (title: String, actionButtonTitle: String?)
  var actionTapHandler: Action?
  private lazy var titleLabel = UILabel()
  private lazy var actionButton = UIButton(type: .system)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension HeaderView {
  var titleFont: UIFont? {
    get { titleLabel.font }
    set { titleLabel.font = newValue }
  }
}

extension HeaderView {
  func update(_ viewModel: ViewModel) {
    titleLabel.text = viewModel.title
    actionButton.setTitle(viewModel.actionButtonTitle, for: .normal)
    actionButton.isHidden = viewModel.actionButtonTitle == nil
  }
}

// MARK: - Private Methods
private extension HeaderView {
  @objc func actionButtonTapped() {
    actionTapHandler?()
  }
}

private extension HeaderView {
  func setupViews() {
    setupView()
    setupTitleLabel()
    setupActionButton()
  }
  
  func setupView() {
    self.backgroundColor = .clear
  }
  
  func setupTitleLabel() {
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(16)
      $0.centerY.equalToSuperview()
    }
    titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
    titleLabel.textColor = .black
    titleLabel.textAlignment = .left
  }
  
  func setupActionButton() {
    addSubview(actionButton)
    actionButton.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(16)
      $0.centerY.equalToSuperview()
    }
    actionButton.setTitleColor(.black, for: .normal)
    actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
  }
}
