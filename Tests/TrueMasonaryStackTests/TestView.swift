//
//  File.swift
//  TrueMasonaryStack
//
//  Created by Wit Owczarek on 29/11/2024.
//

import Foundation
import SwiftUI
@testable import TrueMasonaryStack

public class TestSubview: TrueMasonaryStack.Subview {
    var placement: CGRect?
    var size: CGSize

    init(size: CGSize) {
        self.size = size
    }

    public func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
        size
    }
  
    public func place(at position: CGPoint, anchor: UnitPoint, proposal: ProposedViewSize) {
        let size = sizeThatFits(proposal)
        placement = CGRect(origin: position, size: size)
    }
}

extension [TestSubview]: TrueMasonaryStack.Subviews {}
