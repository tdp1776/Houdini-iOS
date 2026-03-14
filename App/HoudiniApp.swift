import SwiftUI
import SwiftData

@main
struct HoudiniApp: App {
    var body: some Scene {
        WindowGroup {
            ProjectListView()
        }
        .modelContainer(ModelContainerProvider.shared.container)
    }
}
