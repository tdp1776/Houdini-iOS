import SwiftUI

struct MapCanvasView: View {
    let project: Project
    private let layoutEngine = GraphLayoutEngine()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.08))

                if project.mapNodes.isEmpty {
                    ContentUnavailableView("No Map Data Yet", systemImage: "point.3.connected.trianglepath.dotted")
                } else {
                    let positions = layoutEngine.positions(for: project.mapNodes, canvasSize: geometry.size)

                    ForEach(project.mapConnections) { connection in
                        if let start = positions[connection.sourceNodeID],
                           let end = positions[connection.targetNodeID] {
                            Path { path in
                                path.move(to: start)
                                path.addLine(to: end)
                            }
                            .stroke(Color.secondary.opacity(0.5), lineWidth: 1.5)
                        }
                    }

                    ForEach(project.mapNodes) { node in
                        let point = positions[node.id] ?? CGPoint(x: 80, y: 80)

                        Text(node.name)
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(.thinMaterial)
                            .clipShape(Capsule())
                            .position(point)
                    }
                }
            }
            .padding()
        }
    }
}
