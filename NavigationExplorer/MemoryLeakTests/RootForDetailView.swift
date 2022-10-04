//
//  RootForDetail.swift
//  NavigationExplorer
//
//  Created by Labtanza on 10/4/22.
//

import SwiftUI

class DetailDoNothingVM:ObservableObject {
    @Published var optionSet:String
    
    deinit {
        print("DetailDoNothingVM DEINIT")
    }
    
//    init() {
//        print("DetailDoNothingVM INIT")
//        self.optionSet = "default"
//    }
    
    init(_ optionSet:String) {
        print("DetailDoNothingVM INIT")
        self.optionSet = optionSet
    }
}

struct RootForDetailView: View {
    @StateObject var viewModel:DetailDoNothingVM
    
    //let optionSet:String

    init(for optionSet:String) {
        self._viewModel = StateObject(wrappedValue: DetailDoNothingVM(optionSet))
    }
    
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
                DetailOptionIntView(int: int, path: $path).environmentObject(viewModel)
            }.navigationTitle("\(viewModel.optionSet): \(int)")
        }
    }
}

struct DetailOptionIntView:View {
    let int:Int
    @Binding var path:NavigationPath
    @EnvironmentObject var viewModel:DetailDoNothingVM
    
    var body: some View {
        VStack {
            Text("Hello \(int)")
            Button("Go Forward") {
                path.append(Int.random(in: 0...100))
            }
        }.navigationTitle("\(viewModel.optionSet): \(int)")
    }
}

struct RootForDetail_Previews: PreviewProvider {
    static var previews: some View {
        RootForDetailView(for: "Thing")
    }
}
