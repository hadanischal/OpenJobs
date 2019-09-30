//
//  BusinessCollectionViewCell.swift
//  OpenJobs
//
//  Created by Nischal Hada on 30/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import UIKit

class BusinessCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backgroundContentView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!

    var businessValue: ConnectedBusinessModel? {
        didSet {
            guard let data = businessValue else {
                return
            }
            statusLabel?.text = data.isHired ?? false ? " Hired " : " Not Hired "

            if let urlString = data.thumbnail,
                let url = URL(string: urlString) {
                profileImageView.setImage(url: url)
            }

        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .tableViewBackgroundColor
        self.backgroundContentView.backgroundColor = .white
        self.profileImageView.contentMode =   UIView.ContentMode.scaleAspectFit

        statusLabel.backgroundColor = .primary
        statusLabel.font = .statusTitle
        statusLabel.textColor = .titleTintColor
    }
}
