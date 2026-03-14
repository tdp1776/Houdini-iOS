import SwiftData
import Foundation

@MainActor
struct MapBuildService {
    func rebuildCharacterMap(for project: Project, in context: ModelContext) {
        for connection in project.mapConnections {
            context.delete(connection)
        }
        for node in project.mapNodes {
            context.delete(node)
        }

        project.mapConnections.removeAll()
        project.mapNodes.removeAll()

        let sortedCharacters = project.characters.sorted { $0.createdAt < $1.createdAt }
        var nodes: [MapNode] = []

        for character in sortedCharacters {
            let node = MapNode(name: character.name, nodeType: "character")
            node.project = project
            nodes.append(node)
            project.mapNodes.append(node)
            context.insert(node)
        }

        if nodes.count >= 2 {
            for idx in 0..<(nodes.count - 1) {
                let edge = MapConnection(label: "related", sourceNodeID: nodes[idx].id, targetNodeID: nodes[idx + 1].id)
                edge.project = project
                project.mapConnections.append(edge)
                context.insert(edge)
            }
        }

        project.updatedAt = .now
    }
}
