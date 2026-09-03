//
//  UsersList.swift
//  SwiftUIFundamentals
//
//  Created by HIMANK on 03/09/26.
//

import SwiftUI


struct UserListView: View {
    let users = [
        User(name: "John"),
        User(name: "Sarah"),
        User(name: "Alex")
    ]

    var body: some View {
        List(users) { user in
            Text(user.name)
        }
        
    }
}


#Preview {
    UserListView()
}

/*13. SwiftUI vs UIKit
UIKit                         SwiftUI
Imperative                    Declarative
UIViewController              View
UILabel                       Text
UIButton                      Button
UIStackView                   VStack / HStack
UITableView                   List
Auto Layout                   Layout system
Delegates                     State/data flow
Manually update UI            UI reacts to state
Storyboards/XIBs              Swift code
More lifecycle management     State-driven*/
