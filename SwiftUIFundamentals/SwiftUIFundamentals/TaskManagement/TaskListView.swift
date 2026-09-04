//
//  TaskListView.swift
//  SwiftUIFundamentals
//
//  Created by HIMANK on 04/09/26.
//


import SwiftUI

struct TaskListView: View {

    @State private var viewModel = TaskViewModel()

    @State private var searchText = ""
    @State private var showingAddTask = false

    private var filteredTasks: [TaskItem] {
        viewModel.searchTasks(searchText)
    }

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading tasks...")
            } else if filteredTasks.isEmpty {
                ContentUnavailableView(
                    searchText.isEmpty
                    ? "No Tasks"
                    : "No Results",
                    systemImage: "checklist",
                    description: Text(
                        searchText.isEmpty
                        ? "Add a task to get started."
                        : "Try a different search."
                    )
                )
            } else {
                List {
                    ForEach(
                        $viewModel.tasks
                            .filter {
                                searchText.isEmpty ||
                                $0.wrappedValue.title
                                    .localizedCaseInsensitiveContains(searchText)
                            }
                    ) { $task in
                        TaskRow(task: $task)
                    }
                    .onDelete {
                        viewModel.deleteTask(at: $0)
                    }
                }
            }
        }
        .navigationTitle("My Tasks")
        .searchable(
            text: $searchText,
            prompt: "Search tasks"
        )
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingAddTask = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddTask) {
            TaskEditorView { title in
                viewModel.addTask(title: title)
            }
        }
        .task {
            await viewModel.loadTasks()
        }
        .onAppear {
            print("TaskListView appeared")
        }
        .onDisappear {
            print("TaskListView disappeared")
        }
    }
}

/*@State
 ↓
TaskListView owns ViewModel

@Binding
 ↓
TaskRow modifies parent state

@Observable
 ↓
TaskViewModel publishes changes

Derived State
 ↓
filteredTasks

Identifiable
 ↓
Stable ForEach identity

.task
 ↓
Async loading

onAppear
 ↓
Lifecycle

onDisappear
 ↓
Lifecycle

body
 ↓
Declarative rendering*/
