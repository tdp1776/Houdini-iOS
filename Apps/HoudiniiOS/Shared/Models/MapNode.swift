import Foundation
import SwiftData

@Model
final class MapNode {
    var id: UUID
    var name: String
    var nodeType: String
    var x: Double
    var y: Double

    var project: Project?

    init(name: String, nodeType: String = "character", x: Double = 0, y: Double = 0) {
        self.id = UUID()
        self.name = name
        self.nodeType = nodeType
        self.x = x
        self.y = y
    }
}
