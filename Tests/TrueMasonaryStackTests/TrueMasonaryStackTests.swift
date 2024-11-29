import Testing
import SwiftUI
@testable import TrueMasonaryStack

@Suite("MStack Layout Tests")
struct MStackTests {
  
    func framesOverlap(_ frame1: CGRect, _ frame2: CGRect) -> Bool {
        frame1.intersects(frame2)
    }
    
    func verifyNoOverlaps(in frames: [CGRect]) -> (hasOverlap: Bool, overlappingPair: (CGRect, CGRect)?) {
        for i in 0..<frames.count {
            for j in (i + 1)..<frames.count {
                if framesOverlap(frames[i], frames[j]) {
                    return (true, (frames[i], frames[j]))
                }
            }
        }
        return (false, nil)
    }
    
    func createSubviews() -> [TestSubview] {
        var subviews: [TestSubview] = []
        for _ in 0..<100 {
            let size = CGSize(
                width: CGFloat.random(in: 50...250),
                height: CGFloat.random(in: 50...250)
            )
            subviews.append(.init(size: size))
        }
        return subviews
    }
    
    @MainActor
    @Test("Subviews shouldn't overlap")
    func testLayoutSubviewsOverlap() throws {
        for _ in 0..<100 {
            let mstack = MStack()
            let proposal = ProposedViewSize(
                width: UIScreen.main.bounds.size.width,
                height: UIScreen.main.bounds.size.height
            )
            let subviews = createSubviews()
            var cache = MStack.Cache()
            let size = mstack.sizeThatFits(proposal: proposal, subviews: subviews, cache: &cache)
            
            mstack.placeSubviews(
                in: CGRect(origin: .zero, size: size),
                proposal: proposal,
                subviews: subviews,
                cache: &cache
            )
            
            let frames = subviews.map { $0.placement ?? .zero }
            let (hasOverlap, overlappingPair) = verifyNoOverlaps(in: frames)
            #expect(!hasOverlap, "Found overlapping views: \(String(describing: overlappingPair))")
        }
    }
}
