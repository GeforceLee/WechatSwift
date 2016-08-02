//
//  TSFullyHorizontalFlowLayout.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/1.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation

class TSFullyHorizontalFlowLayout: UICollectionViewFlowLayout {
    internal var nbColumns: Int = -1
    internal var nbLines: Int = -1
    
    override init() {
        super.init()
        self.scrollDirection = .Horizontal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(code:) has not ben implemented")
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else {
            return UICollectionViewLayoutAttributes()
        }
        
        let nbColumns: Int = self.nbColumns != -1 ? self.nbColumns : Int(self.collectionView!.width / self.itemSize.width)
        let nbLines: Int = self.nbLines != -1 ? self.nbLines : Int(collectionView.height / self.itemSize.height)
        
        let idxPage: Int = Int(indexPath.row) / (nbColumns * nbLines)
        let O: Int = indexPath.row - (idxPage * nbColumns * nbLines)
        let xD: Int = Int(O / nbColumns)
        let yD: Int = O % nbColumns
        let D: Int = xD + yD  * nbLines + idxPage * nbColumns * nbLines
        let fakeIndexPath: NSIndexPath = NSIndexPath(forItem: D, inSection: indexPath.section)
        let attributes: UICollectionViewLayoutAttributes = super.layoutAttributesForItemAtIndexPath(fakeIndexPath)!
        return attributes
        
    }
    
    
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let newX: CGFloat = min(0, rect.origin.x - rect.width / 2)
        let newWidth: CGFloat = rect.width * 2 + (rect.origin.x - newX)
        let newRect: CGRect = CGRectMake(newX, rect.origin.y, newWidth, rect.height)
        
        let attributes = super.layoutAttributesForElementsInRect(newRect)!
        var attributesCopy = [UICollectionViewLayoutAttributes]()
        
        
        for itemAttributes in attributes {
            let itemAttributesCopy = itemAttributes.copy() as! UICollectionViewLayoutAttributes
            attributesCopy.append(itemAttributesCopy)
        }
        
        
        return attributesCopy.map{attr in
            let newAttr: UICollectionViewLayoutAttributes = self.layoutAttributesForItemAtIndexPath(attr.indexPath)
            attr.frame = newAttr.frame
            attr.center = newAttr.center
            attr.bounds = newAttr.bounds
            attr.hidden = newAttr.hidden
            attr.size = newAttr.size
         return attr
        }
    }
    
    
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    
    override func collectionViewContentSize() -> CGSize {
        let size: CGSize = super.collectionViewContentSize()
        let collectionViewWith: CGFloat = self.collectionView!.frame.width
        let nbOfScreens: Int = Int(ceil(size.width / collectionViewWith))
        let newSize: CGSize = CGSizeMake(collectionViewWith * CGFloat(nbOfScreens), size.height)
        return newSize
    }
    
    
    
    
    
    
    
    
    
    
}