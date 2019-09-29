//
//  DashboardTableViewCell.swift
//  OpenJobs
//
//  Created by Nischal Hada on 27/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {

    @IBOutlet weak var contentBagroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postedDateLabel: UILabel!

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!

    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var viewDetailsButton: UIButton!

    var newsInfo: JobModel? {
        didSet {
            guard let data = newsInfo else {
                return
            }
            titleLabel.text = data.category
            let postedDate = data.postedDate.yyyyMMddDate?.ddMMyyyyString ?? data.postedDate
            postedDateLabel.text =  "Posted: \(postedDate)"
            descriptionLabel.text = data.status

            if let array = data.connectedBusinesses,
                !array.isEmpty,
                let urlString = array[0].thumbnail,
                let url = URL(string: urlString) {
                thumbnailImage.setImage(url: url)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.contentView.backgroundColor = .tableViewBackgroundColor
        self.contentBagroundView.backgroundColor = .white
        self.contentBagroundView.borderWidth = 1
        self.contentBagroundView.borderColor = .cellBorderColor
        self.thumbnailImage?.contentMode =   UIView.ContentMode.scaleAspectFit

        self.titleLabel.font = .heading2
        self.postedDateLabel.font = .heading2
        self.statusLabel.font = .detailBody
        self.descriptionLabel.font = .heading2

        titleLabel.textColor = .titleColor
        postedDateLabel.textColor = .descriptionColor
        statusLabel.textColor = .statusColor
        descriptionLabel.textColor = .descriptionColor
    }

}
