//
//  TaskViewModel.swift
//  SwiftUIFundamentals
//
//  Created by HIMANK on 04/09/26.
//


import Foundation
import Observation
import SwiftUI

@Observable
final class TaskViewModel {

    var tasks: [TaskItem] = [
        TaskItem(title: "Learn SwiftUI State"),
        TaskItem(title: "Practice @Binding"),
        TaskItem(title: "Understand View Lifecycle"),
        TaskItem(title: "Study SwiftUI Performance")
    ]

    var isLoading = false
    var errorMessage: String?

    func addTask(title: String) {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedTitle.isEmpty else {
            return
        }

        let task = TaskItem(title: trimmedTitle)
        tasks.append(task)
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    func toggleTask(_ task: TaskItem) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else {
            return
        }

        tasks[index].isCompleted.toggle()
    }

    func loadTasks() async {
        isLoading = true
        errorMessage = nil

        do {
            try await Task.sleep(for: .seconds(1))
        } catch {
            return
        }

        isLoading = false
    }

    func searchTasks(_ query: String) -> [TaskItem] {
        guard !query.isEmpty else {
            return tasks
        }

        return tasks.filter {
            $0.title.localizedCaseInsensitiveContains(query)
        }
    }
}
