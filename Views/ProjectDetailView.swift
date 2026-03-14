import SwiftUI
import SwiftData

struct ProjectDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = ProjectDetailViewModel()
    let project: Project

    var body: some View {
        VStack(spacing: 0) {
            header
            ConversationPanelView(messages: project.messages)
            tabSelector
            tabBody
            InputBarView(text: $viewModel.inputText) {
                viewModel.submit(for: project, in: modelContext)
            }
        }
        .navigationTitle(project.title)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $viewModel.showingParsePreview) {
            ParsePreviewView(
                items: viewModel.parsePreviewItems,
                onCancel: { viewModel.cancelPreview() },
                onCommit: { viewModel.commitPreview(for: project, in: modelContext) }
            )
        }
    }

    private var header: some View {
        HStack {
            Text("Mode: \(viewModel.mode.rawValue)")
                .font(.subheadline)
                .fontWeight(.semibold)
            Spacer()
            Button("Regenerate Map") {
                let command = ParsedCommand(type: .map, payload: "", confidence: 1)
                _ = ProjectWriteService().apply(command: command, to: project, in: modelContext)
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .background(.thinMaterial)
    }

    private var tabSelector: some View {
        Picker("Tab", selection: $viewModel.selectedTab) {
            ForEach(ProjectTab.allCases) { tab in
                Text(tab.rawValue).tag(tab)
            }
        }
        .pickerStyle(.segmented)
        .padding()
    }

    @ViewBuilder
    private var tabBody: some View {
        switch viewModel.selectedTab {
        case .characters:
            CharacterListView(project: project)
        case .chapters:
            ChapterListView(project: project)
        case .maps:
            MapCanvasView(project: project)
        case .content:
            ContentListView(project: project)
        }
    }
}
