//
//  TaskEditorView.swift
//  SwiftUIFundamentals
//
//  Created by HIMANK on 04/09/26.
//


import SwiftUI

struct TaskEditorView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var title = ""

    let onSave: (String) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section("Task") {
                    TextField("Task title", text: $title)
                }
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(title)
                        dismiss()
                    }
                    .disabled(
                        title.trimmingCharacters(
                            in: .whitespacesAndNewlines
                        ).isEmpty
                    )
                }
            }
        }
    }
}