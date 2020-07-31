//
//  CollectionViewCenteredFlowLayout.swift
//  OpenJobs
//
//  Created by Nischal Hada on 1/10/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//
// swiftlint:disable all

import UIKit

class CollectionViewCenteredFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let layoutAttributesForElements = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        guard let collectionView = collectionView else {
            return layoutAttributesForElements
        }
        // we group copies of the elements from the same row/column
        var representedElements: [UICollectionViewLayoutAttributes] = []
        var cells: [[UICollectionViewLayoutAttributes]] = [[]]
        var previousFrame: CGRect?
        if scrollDirection == .vertical {
            for layoutAttributes in layoutAttributesForElements {
                guard layoutAttributes.representedElementKind == nil else {
                    representedElements.append(layoutAttributes)
                    continue
                }
                // copying is required to avoid "UICollectionViewFlowLayout cache mismatched frame"
                let currentItemAttributes = layoutAttributes.copy() as! UICollectionViewLayoutAttributes
                // if the current frame, once stretched to the full row doesn't intersect the previous frame then they are on different rows
                if previousFrame != nil,
                    !currentItemAttributes.frame.intersects(CGRect(x: -.greatestFiniteMagnitude, y: previousFrame!.origin.y, width: .infinity, height: previousFrame!.size.height)) {
                    cells.append([])
                }
                cells[cells.endIndex - 1].append(currentItemAttributes)
                previousFrame = currentItemAttributes.frame
            }
            // we reposition all elements
            return representedElements + cells.flatMap { group -> [UICollectionViewLayoutAttributes] in
                guard let section = group.first?.indexPath.section else {
                    return group
                }
                let evaluatedSectionInset = evaluatedSectionInsetForSection(at: section)
                let evaluatedMinimumInteritemSpacing = evaluatedMinimumInteritemSpacingForSection(at: section)
                var origin = (collectionView.bounds.width + evaluatedSectionInset.left - evaluatedSectionInset.right - group.reduce(0, { $0 + $1.frame.size.width }) - CGFloat(group.count - 1) * evaluatedMinimumInteritemSpacing) / 2
                // we reposition each element of a group
                return group.map {
                    $0.frame.origin.x = origin
                    origin += $0.frame.size.width + evaluatedMinimumInteritemSpacing
                    return $0
                }
            }
        } else {
            for layoutAttributes in layoutAttributesForElements {
                guard layoutAttributes.representedElementKind == nil else {
                    representedElements.append(layoutAttributes)
                    continue
                }
                // copying is required to avoid "UICollectionViewFlowLayout cache mismatched frame"
                let currentItemAttributes = layoutAttributes.copy() as! UICollectionViewLayoutAttributes
                // if the current frame, once stretched to the full column doesn't intersect the previous frame then they are on different columns
                if previousFrame != nil,
                    !currentItemAttributes.frame.intersects(CGRect(x: previousFrame!.origin.x, y: -.greatestFiniteMagnitude, width: previousFrame!.size.width, height: .infinity)) {
                    cells.append([])
                }
                cells[cells.endIndex - 1].append(currentItemAttributes)
                previousFrame = currentItemAttributes.frame
            }
            // we reposition all elements
            return representedElements + cells.flatMap { group -> [UICollectionViewLayoutAttributes] in
                guard let section = group.first?.indexPath.section else {
                    return group
                }
                let evaluatedSectionInset = evaluatedSectionInsetForSection(at: section)
                let evaluatedMinimumInteritemSpacing = evaluatedMinimumInteritemSpacingForSection(at: section)
                var origin = (collectionView.bounds.height + evaluatedSectionInset.top - evaluatedSectionInset.bottom - group.reduce(0, { $0 + $1.frame.size.height }) - CGFloat(group.count - 1) * evaluatedMinimumInteritemSpacing) / 2
                // we reposition each element of a group
                return group.map {
                    $0.frame.origin.y = origin
                    origin += $0.frame.size.height + evaluatedMinimumInteritemSpacing
                    return $0
                }
            }
        }
    }
}

extension UICollectionViewFlowLayout {
    internal func evaluatedSectionInsetForSection(at section: Int) -> UIEdgeInsets {
        return (collectionView?.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(collectionView!, layout: self, insetForSectionAt: section) ?? sectionInset
    }

    internal func evaluatedMinimumInteritemSpacingForSection(at section: Int) -> CGFloat {
        return (collectionView?.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(collectionView!, layout: self, minimumInteritemSpacingForSectionAt: section) ?? minimumInteritemSpacing
    }
}
