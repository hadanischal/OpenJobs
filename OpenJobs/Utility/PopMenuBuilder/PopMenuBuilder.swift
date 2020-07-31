//
//  PopMenuBuilder.swift
//  OpenJobs
//
//  Created by Nischal Hada on 30/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import PopMenu
import UIKit

struct PopMenuBuilder {
    private let cornerRadius: CGFloat = 8

    func buildPopMenuClose(_ sourceView: AnyObject) -> PopMenuViewController {
        let actions = [
            PopMenuDefaultAction(title: "Close")
        ]
        let popMenu = PopMenuViewController(sourceView: sourceView, actions: actions)
        popMenu.appearance.popMenuFont = UIFont.body1
        popMenu.appearance.popMenuCornerRadius = cornerRadius
        popMenu.appearance.popMenuColor.backgroundColor = .solid(fill: .tableViewBackgroundColor)
        popMenu.appearance.popMenuColor.actionColor = .tint(.titleColor)
        return popMenu
    }
}
