//
//  ContentView.swift
//  SwiftUIFundamentals
//
//  Created by HIMANK on 03/09/26.
//
//SwiftUI — Declarative
import SwiftUI

//Everything we display in SwiftUI is generally a View. and view is a protocol
struct ContentView: View {
    
    @State private var isLoggedIn = false
    @State private var count = 0
//    @State is used for local view state.
    var body: some View {
        //Stack
        VStack(spacing: 24) {
            //Image
            Image(systemName: "heart.fill")
            
            
            //ConditionalUI
            if isLoggedIn {
                Text("Welcome !")
            } else {
                Text("Please log in")
            }
            
            //Text
            Text(isLoggedIn ? "Welcome" : "Please Login")
                .font(.title)
                .foregroundStyle(.red)
                .padding()
            
            //Button
            Button("Login") {
                isLoggedIn = true
            }
            
            HStack{
                Text("Count: \(count)")

                Button("Increment") {
                    count += 1
                }
            }
        }
    }
}

//"When isLoggedIn is true, show Welcome; otherwise show Please Login."
//SwiftUI takes care of updating the UI.

#Preview {
    ContentView()
}

//Modifiers

//SwiftUI uses modifiers to describe how a view should look or behave.
/*.font(.title)
 .foregroundStyle(.blue)
 .padding()*/


/*count = 0
 ↓
Button tapped
 ↓
count = 1
 ↓
SwiftUI detects state change
 ↓
body is evaluated again
 ↓
Text("Count: 1")
 
 
 not doing
 label.text = "Count: 1"

 SwiftUI handles the UI update.

 The mental model
 STATE
   ↓
 BODY
   ↓
 UI

 When state changes:

 STATE changes
       ↓
 SwiftUI recomputes affected UI
       ↓
 New UI representation*/

/*DATA FLOW
 
 Source of Truth
 │
 ↓
State
 │
 ↓
View
 │
 ↓
User Action
 │
 ↓
State changes
 │
 └──────────→ View updates*/
