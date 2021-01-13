//
//  VenueTypeCell.swift
//  AjmoClone
//
//  Created by Luka Šarčević on 13.01.2021..
//

import UIKit

class VenueTypeCell: UICollectionViewCell {
  typealias ViewModel = (title: String, color: UIColor)
  private lazy var containerView = UIView()
  private lazy var titleLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension VenueTypeCell {
  func update(_ viewModel: ViewModel) {
    titleLabel.text = viewModel.title
    containerView.backgroundColor = viewModel.color
    titleLabel.textColor = viewModel.color.isLight ? .black : .white
  }
}

// MARK: - Private Methods
private extension VenueTypeCell {
  func setupViews() {
    setupView()
    setupContainerView()
    setupTitleLabel()
  }
  
  func setupView() {
    contentView.backgroundColor = .clear
  }
  
  func setupContainerView() {
    contentView.addSubview(containerView)
    containerView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    containerView.layer.cornerRadius = 4
    containerView.clipsToBounds = true
  }
    
  func setupTitleLabel() {
    containerView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
    titleLabel.font = .systemFont(ofSize: 12)
    titleLabel.textColor = .black
  }
}
