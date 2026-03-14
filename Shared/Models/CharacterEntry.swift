import Foundation
import SwiftData

@Model
final class CharacterEntry {
    var id: UUID
    var name: String
    var backgroundNotes: String
    var personalityNotes: String
    var motivationNotes: String
    var arcNotes: String
    var generalNotes: String
    var createdAt: Date
    var updatedAt: Date

    var project: Project?

    init(name: String, generalNotes: String = "") {
        self.id = UUID()
        self.name = name
        self.backgroundNotes = ""
        self.personalityNotes = ""
        self.motivationNotes = ""
        self.arcNotes = ""
        self.generalNotes = generalNotes
        self.createdAt = .now
        self.updatedAt = .now
    }
}
