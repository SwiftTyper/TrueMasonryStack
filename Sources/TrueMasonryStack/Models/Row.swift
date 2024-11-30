//
//  File.swift
//  TrueMasonryStack
//
//  Created by Wit Owczarek on 29/11/2024.
//

import Foundation
import SwiftUI

struct Row {
    var items: [Item] = []
    var yOffset: CGFloat = 0
    
    var height: CGFloat {
        items.max(by: {$0.frame.height < $1.frame.height })?.frame.height ?? 0
    }
    
    func findAvailableSpace(
        for size: CGSize,
        horizontalSpacing: CGFloat,
        verticalSpacing: CGFloat,
        containerWidth: CGFloat
    ) -> CGRect? {
        // If row is empty, start at the beginning
        guard !items.isEmpty else { return .zero }
        
        // Try to add horizontally after the last item
        let lastItem = items.max(by: { $0.frame.maxX < $1.frame.maxX })!
        let newX = lastItem.frame.maxX + horizontalSpacing
        
        // If it fits horizontally after the last item, use that position
        if newX + size.width <= containerWidth {
            return CGRect(origin: .init(x: newX, y: 0), size: size)
        }
        
        // If it doesn't fit horizontally, try to stack vertically
        let sortedItems = items.sorted { $0.frame.minX < $1.frame.minX }
        //combine with max values + remove duplicates
        
        for i in 0..<sortedItems.count {
            let currentItem = sortedItems[i]
            let candidateX = currentItem.frame.minX
            let candidateX2 = currentItem.frame.maxX + horizontalSpacing
            
            let candidateY = currentItem.frame.maxY + verticalSpacing
            if candidateY + size.height <= height {
                if isHorizontalContainerConstraintSatisfied(
                    size: size,
                    containerWidth: containerWidth,
                    horizontalSpacing: horizontalSpacing,
                    xPosition: candidateX
                ) {
                    let proposedFrame = CGRect(
                        x: candidateX,
                        y: candidateY,
                        width: size.width,
                        height: size.height
                    )
                    
                    if !hasOverlapWithOthers(items: items, proposedFrame: proposedFrame, horizontalSpacing: horizontalSpacing, verticalSpacing: verticalSpacing) {
                        return proposedFrame
                    }
                }
            } else if !isRedundentXPosition(for: candidateX2, sortedItems: sortedItems, i: i){
                let candidateY = currentItem.frame.minY
                guard candidateY + size.height <= height else { break }
                
                guard isHorizontalContainerConstraintSatisfied(
                    size: size,
                    containerWidth: containerWidth,
                    horizontalSpacing: horizontalSpacing,
                    xPosition: candidateX2
                ) else {
                    continue
                }
                
                let proposedFrame = CGRect(
                    x: candidateX2,
                    y: candidateY,
                    width: size.width,
                    height: size.height
                )
                
                if !hasOverlapWithOthers(items: items, proposedFrame: proposedFrame, horizontalSpacing: horizontalSpacing, verticalSpacing: verticalSpacing) {
                    return proposedFrame
                }
            }
        }
        return nil
    }
    
    private func isHorizontalContainerConstraintSatisfied(
        size: CGSize,
        containerWidth: CGFloat,
        horizontalSpacing: CGFloat,
        xPosition: CGFloat
    ) -> Bool {
        let neededWidth = xPosition + size.width
        return neededWidth <= containerWidth
    }
    
    private func hasOverlapWithOthers(
        items: [Item],
        proposedFrame: CGRect,
        horizontalSpacing: CGFloat,
        verticalSpacing: CGFloat
    ) -> Bool {
        let hasOverlap = items.contains { item in
            let spacingExpanded = item.frame.insetBy(dx: -horizontalSpacing/2, dy: -verticalSpacing/2)
            return spacingExpanded.intersects(proposedFrame)
        }
        return hasOverlap
    }
    
    private func isRedundentXPosition(
        for maxXBasedCandidate: CGFloat,
        sortedItems: [Item],
        i: Int
    ) -> Bool {
        for j in i+1..<sortedItems.count {
            let currentMinX = sortedItems[j].frame.minX
            if currentMinX == maxXBasedCandidate {
                return true
            } else if currentMinX > maxXBasedCandidate {
                return false
            }
        }
        return false
    }
}
