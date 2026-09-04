//
//  TaskRow.swift
//  SwiftUIFundamentals
//
//  Created by HIMANK on 04/09/26.
//


import SwiftUI

struct TaskRow: View {

    @Binding var task: TaskItem

    var body: some View {
        HStack(spacing: 12) {

            Button {
                task.isCompleted.toggle()
            } label: {
                Image(
                    systemName: task.isCompleted
                    ? "checkmark.circle.fill"
                    : "circle"
                )
                .font(.title2)
            }
            .buttonStyle(.plain)

            Text(task.title)
                .strikethrough(task.isCompleted)
                .foregroundStyle(
                    task.isCompleted
                    ? .secondary
                    : .primary
                )

            Spacer()
        }
        .padding(.vertical, 4)
    }
}
