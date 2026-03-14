import Foundation
import SwiftData

@Model
final class Project {
    var id: UUID
    var title: String
    var catalogueRawValue: String
    var createdAt: Date
    var updatedAt: Date
    var isArchived: Bool

    @Relationship(deleteRule: .cascade, inverse: \CharacterEntry.project)
    var characters: [CharacterEntry]

    @Relationship(deleteRule: .cascade, inverse: \ChapterEntry.project)
    var chapters: [ChapterEntry]

    @Relationship(deleteRule: .cascade, inverse: \ContentDocument.project)
    var contentDocuments: [ContentDocument]

    @Relationship(deleteRule: .cascade, inverse: \MapNode.project)
    var mapNodes: [MapNode]

    @Relationship(deleteRule: .cascade, inverse: \MapConnection.project)
    var mapConnections: [MapConnection]

    @Relationship(deleteRule: .cascade, inverse: \ConversationMessage.project)
    var messages: [ConversationMessage]

    init(title: String, catalogue: CatalogueType) {
        self.id = UUID()
        self.title = title
        self.catalogueRawValue = catalogue.rawValue
        self.createdAt = .now
        self.updatedAt = .now
        self.isArchived = false
        self.characters = []
        self.chapters = []
        self.contentDocuments = []
        self.mapNodes = []
        self.mapConnections = []
        self.messages = []
    }

    var catalogue: CatalogueType {
        get { CatalogueType(rawValue: catalogueRawValue) ?? .books }
        set { catalogueRawValue = newValue.rawValue }
    }
}
