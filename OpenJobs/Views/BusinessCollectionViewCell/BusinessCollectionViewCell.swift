//
//  BusinessCollectionViewCell.swift
//  OpenJobs
//
//  Created by Nischal Hada on 30/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import UIKit

class BusinessCollectionViewCell: UICollectionViewCell {
    @IBOutlet var backgroundContentView: UIView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var statusLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .tableViewBackgroundColor
        self.backgroundContentView.backgroundColor = .white
        self.profileImageView.contentMode = UIView.ContentMode.scaleAspectFit

        statusLabel.backgroundColor = .primary
        statusLabel.font = .statusTitle
        statusLabel.textColor = .statusTextColor
    }

    func configure(_ data: ConnectedBusinessDTO) {
        statusLabel?.text = data.description
        profileImageView.setImage(url: URL(string: data.thumbnail))
    }
}
