import SwiftUI
import SwiftData

struct ProjectListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\Project.updatedAt, order: .reverse)]) private var projects: [Project]

    @StateObject private var viewModel = ProjectListViewModel()
    @State private var showingNewProject = false
    @State private var newProjectTitle = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredProjects) { project in
                    NavigationLink {
                        ProjectDetailView(project: project)
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(project.title).font(.headline)
                            Text(project.catalogue.rawValue)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Houdini")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingNewProject = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .safeAreaInset(edge: .top) {
                Picker("Catalogue", selection: $viewModel.selectedCatalogue) {
                    ForEach(CatalogueType.allCases) { catalogue in
                        Text(catalogue.rawValue).tag(catalogue)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                .background(.thinMaterial)
            }
            .sheet(isPresented: $showingNewProject) {
                NavigationStack {
                    Form {
                        TextField("Project Title", text: $newProjectTitle)
                    }
                    .navigationTitle("New Project")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") { showingNewProject = false }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Create") {
                                viewModel.createProject(title: newProjectTitle, in: modelContext)
                                newProjectTitle = ""
                                showingNewProject = false
                            }
                        }
                    }
                }
            }
        }
    }

    private var filteredProjects: [Project] {
        projects.filter { !$0.isArchived && $0.catalogue == viewModel.selectedCatalogue }
    }
}
