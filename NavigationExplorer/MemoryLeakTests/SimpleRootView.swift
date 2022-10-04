//
//  SimpleRootView.swift
//  NavigationExplorer
//
//  Created by Labtanza on 10/3/22.
//

import SwiftUI

class DoNothingVM:ObservableObject {
    deinit {
        print("ViewModel DEINIT")
    }
    
    init() {
        print("ViewModel INIT")
    }
}

struct SimpleRootView: View {
    @StateObject var viewModel = DoNothingVM()
    @State var path = NavigationPath()
    
    let int = Int.random(in: 0...100)
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Text("Hello \(int)")
                Button("Go Forward") {
                    path.append(Int.random(in: 0...100))
                }
            }.navigationDestination(for: Int.self) { int in
                DetailIntView(int: int, path: $path)
            }.navigationTitle("\(int)")
        }
    }
}

struct DetailIntView:View {
    let int:Int
    @Binding var path:NavigationPath
    
    var body: some View {
        VStack {
            Text("Hello \(int)")
            Button("Go Forward") {
                path.append(Int.random(in: 0...100))
            }
        }.navigationTitle("\(int)")
    }
}

struct SimpleRootView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleRootView()
    }
}
