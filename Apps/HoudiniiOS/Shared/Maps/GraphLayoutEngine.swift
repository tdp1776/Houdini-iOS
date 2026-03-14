import Foundation
import CoreGraphics

struct GraphLayoutEngine {
    func positions(for nodes: [MapNode], canvasSize: CGSize) -> [UUID: CGPoint] {
        guard !nodes.isEmpty else { return [:] }

        let center = CGPoint(x: canvasSize.width / 2, y: canvasSize.height / 2)
        let radius = min(canvasSize.width, canvasSize.height) * 0.32
        let step = (2 * CGFloat.pi) / CGFloat(nodes.count)

        var result: [UUID: CGPoint] = [:]

        for (index, node) in nodes.enumerated() {
            let angle = CGFloat(index) * step
            result[node.id] = CGPoint(
                x: center.x + cos(angle) * radius,
                y: center.y + sin(angle) * radius
            )
        }

        return result
    }
}
