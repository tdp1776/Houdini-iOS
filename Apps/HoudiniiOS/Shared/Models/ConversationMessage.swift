import Foundation
import SwiftData

@Model
final class ConversationMessage {
    var id: UUID
    var roleRawValue: String
    var body: String
    var createdAt: Date
    var modeAtTimeRawValue: String
    var project: Project?

    init(role: ConversationRole, body: String, modeAtTime: AppMode) {
        self.id = UUID()
        self.roleRawValue = role.rawValue
        self.body = body
        self.createdAt = .now
        self.modeAtTimeRawValue = modeAtTime.rawValue
    }

    var role: ConversationRole {
        get { ConversationRole(rawValue: roleRawValue) ?? .assistant }
        set { roleRawValue = newValue.rawValue }
    }

    var modeAtTime: AppMode {
        get { AppMode(rawValue: modeAtTimeRawValue) ?? .otc }
        set { modeAtTimeRawValue = newValue.rawValue }
    }
}
