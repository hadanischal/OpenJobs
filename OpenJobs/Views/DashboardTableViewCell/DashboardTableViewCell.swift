//
//  DashboardTableViewCell.swift
//  OpenJobs
//
//  Created by Nischal Hada on 27/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import RxSwift
import UIKit

class DashboardTableViewCell: UITableViewCell {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var contentBagroundView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var postedDateLabel: UILabel!

    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var separatorView: UIView!

    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var moreButton: UIButton!

    @IBOutlet var viewDetailsButton: UIButton!

    var disposeBagCell: DisposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.backgroundColor = .tableViewBackgroundColor
        contentBagroundView.roundedCorners(radius: 5)
        contentBagroundView.backgroundColor = .white
        contentBagroundView.drawShadow(offset: CGSize(width: 0, height: 2), radius: 4.0, opacity: 0.2)

        titleLabel.font = .heading2
        postedDateLabel.font = .heading2
        statusLabel.font = .detailBody
        descriptionLabel.font = .heading2

        titleLabel.textColor = .titleColor
        postedDateLabel.textColor = .descriptionColor
        statusLabel.textColor = .statusColor
        descriptionLabel.textColor = .descriptionColor

        collectionView.register(BusinessCollectionViewCell.self)
        collectionView.isScrollEnabled = false
    }

    override func prepareForReuse() {
        disposeBagCell = DisposeBag()
    }

    func configure(_ data: JobsListDTO) {
        titleLabel.text = data.category
        postedDateLabel.text = data.postedDate
        statusLabel.text = data.status
        descriptionLabel.text = data.description
    }
}

extension DashboardTableViewCell {
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated: false)
        collectionView.reloadData()
    }

    var collectionViewContentOffsett: CGFloat {
        set {
            collectionView.contentOffset.x = newValue
        }
        get {
            collectionView.contentOffset.x
        }
    }
}
