import Foundation

struct ExportService {
    func buildRTFPlaceholder(for project: Project) -> Data {
        let body = """
        Project: \(project.title)

        Characters: \(project.characters.count)
        Chapters: \(project.chapters.count)
        Content Documents: \(project.contentDocuments.count)
        """
        return Data(body.utf8)
    }

    func buildJSONBackupPlaceholder(for project: Project) -> Data {
        let payload = [
            "title": project.title,
            "catalogue": project.catalogue.rawValue,
            "characters": String(project.characters.count),
            "chapters": String(project.chapters.count),
            "contentDocuments": String(project.contentDocuments.count)
        ]
        let data = try? JSONSerialization.data(withJSONObject: payload, options: [.prettyPrinted])
        return data ?? Data()
    }
}
