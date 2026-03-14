import Foundation
import SwiftData

@Model
final class MapConnection {
    var id: UUID
    var label: String
    var sourceNodeID: UUID
    var targetNodeID: UUID
    var project: Project?

    init(label: String, sourceNodeID: UUID, targetNodeID: UUID) {
        self.id = UUID()
        self.label = label
        self.sourceNodeID = sourceNodeID
        self.targetNodeID = targetNodeID
    }
}
