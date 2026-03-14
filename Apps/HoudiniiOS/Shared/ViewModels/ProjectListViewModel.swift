import Foundation
import SwiftData
internal import Combine

@MainActor
final class ProjectListViewModel: ObservableObject {

    @Published var selectedCatalogue: CatalogueType = .books

    init() { }

    func createProject(title: String, in context: ModelContext) {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let project = Project(title: trimmed, catalogue: selectedCatalogue)
        context.insert(project)
    }
}
