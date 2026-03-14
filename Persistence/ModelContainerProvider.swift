import SwiftData

struct ModelContainerProvider {
    static let shared = ModelContainerProvider()
    let container: ModelContainer

    init() {
        do {
            let schema = Schema([
                Project.self,
                CharacterEntry.self,
                ChapterEntry.self,
                ContentDocument.self,
                MapNode.self,
                MapConnection.self,
                ConversationMessage.self
            ])
            let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            self.container = try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Failed to create SwiftData container: \(error)")
        }
    }
}
