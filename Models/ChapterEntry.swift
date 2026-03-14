import Foundation
import SwiftData

@Model
final class ChapterEntry {
    var id: UUID
    var orderIndex: Int
    var title: String
    var summary: String
    var notes: String
    var createdAt: Date
    var updatedAt: Date

    var project: Project?
    var contentDocument: ContentDocument?

    init(orderIndex: Int, title: String, summary: String = "", notes: String = "") {
        self.id = UUID()
        self.orderIndex = orderIndex
        self.title = title
        self.summary = summary
        self.notes = notes
        self.createdAt = .now
        self.updatedAt = .now
    }
}
