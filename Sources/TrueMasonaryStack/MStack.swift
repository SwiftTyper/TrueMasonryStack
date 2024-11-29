// The Swift Programming Language
// https://docs.swift.org/swift-book
//
//  MStack.swift
//  Wigion
//
//  Created by Wit Owczarek on 22/10/2024.
//

import SwiftUI

public struct MStack: Layout {
    public init(horizontalSpacing: CGFloat = 8, verticalSpacing: CGFloat = 8) {
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
    }
    
    let horizontalSpacing: CGFloat
    let verticalSpacing: CGFloat
    
    public func makeCache(subviews: some Subviews) -> Cache {
        Cache()
    }
    
    public func sizeThatFits(proposal: ProposedViewSize, subviews: some Subviews, cache: inout Cache) -> CGSize {
        calculateLayout(in: proposal, subviews: subviews, cache: &cache)
        
        let maxWidth = proposal.width ?? 0
        var height: CGFloat = .zero
        
        if let lastRow = cache.rows.last {
            height = lastRow.yOffset + lastRow.height
        }
        
        return CGSize(width: maxWidth, height: height)
    }
    
    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: some Subviews, cache: inout Cache) {
        calculateLayout(in: proposal, subviews: subviews, cache: &cache)
        
        for row in cache.rows {
            for item in row.items {
                let adjustedFrame = item.frame.offsetBy(dx: bounds.minX, dy: bounds.minY + row.yOffset)
                subviews[item.index].place(
                    at: adjustedFrame.origin,
                    anchor: .topLeading,
                    proposal: proposal
                )
            }
        }
    }
    
    func calculateLayout(in proposal: ProposedViewSize, subviews: some Subviews, cache: inout Cache) {
        guard let containerWidth = proposal.width, !subviews.isEmpty else { return }
        cache = Cache()
        let sizes = subviews.map { $0.sizeThatFits(proposal) }
        
        for index in subviews.indices {
            let size = sizes[index]
            var itemPlaced = false
            
            for rowIndex in 0..<cache.rows.count {
                if let availableSpace = cache.rows[rowIndex].findAvailableSpace(
                    for: size,
                    horizontalSpacing: horizontalSpacing,
                    verticalSpacing: verticalSpacing,
                    containerWidth: containerWidth
                ) {
                    cache.rows[rowIndex].items.append(.init(index: index, frame: availableSpace))
                    itemPlaced = true
                    break
                }
            }
            
            if !itemPlaced {
                let newY = cache.rows.last?.height ?? 0 + verticalSpacing
                let itemFrame = CGRect(origin: .zero, size: size)
                
                let newRow = Row(
                    items: [.init(index: index, frame: itemFrame)],
                    yOffset: newY
                )
                
                cache.rows.append(newRow)
            }
        }
        
        var y: CGFloat = 0
        for index in 0..<cache.rows.count {
            cache.rows[index].yOffset = y
            y += cache.rows[index].height + verticalSpacing
        }
    }
}

extension MStack {
    public struct Cache {
        var rows: [Row] = []
    }
}
