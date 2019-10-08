//
//  DashboardTableViewCell.swift
//  OpenJobs
//
//  Created by Nischal Hada on 27/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import UIKit
import RxSwift

class DashboardTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var contentBagroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postedDateLabel: UILabel!

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!

    @IBOutlet weak var viewDetailsButton: UIButton!

    var disposeBagCell:DisposeBag = DisposeBag()

    var newsInfo: JobModel? {
        didSet {
            guard let data = newsInfo else {
                return
            }
            titleLabel.text = data.category
            let postedDate = data.postedDate.yyyyMMddDate?.ddMMyyyyString ?? data.postedDate
            postedDateLabel.text =  "Posted: \(postedDate)"
            statusLabel.text = data.status.capitalized
            descriptionLabel.text = data.status
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.backgroundColor = .tableViewBackgroundColor
        contentBagroundView.backgroundColor = .white
        contentBagroundView.borderWidth = 1
        contentBagroundView.borderColor = .cellBorderColor

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
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
}
