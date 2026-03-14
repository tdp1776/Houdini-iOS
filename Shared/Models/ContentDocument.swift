import Foundation
import SwiftData

@Model
final class ContentDocument {
    var id: UUID
    var title: String
    @Attribute(.externalStorage) var bodyText: String
    var createdAt: Date
    var updatedAt: Date

    var project: Project?
    var chapter: ChapterEntry?

    init(title: String, bodyText: String = "") {
        self.id = UUID()
        self.title = title
        self.bodyText = bodyText
        self.createdAt = .now
        self.updatedAt = .now
    }
}
