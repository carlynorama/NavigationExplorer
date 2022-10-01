//
//  DetailView.swift
//  NavigationExplorer
//
//  Created by Labtanza on 9/30/22.
//

//import SwiftUI
//
//
//protocol Displayable:Identifiable {
//    var name:String  { get }
//    var id:String { get }
//}
//
//
//
//
//struct DisplayView<Item:Displayable>: View {
//
//    @State private var counter = 0
//    @EnvironmentObject var navigation: NavigationManager
//    var item:Item
//
//    //@Environment(\.self) var env
//
//    var body: some View {
//
//        VStack {
//            Text("Selected: " + item.name)
//            Text("How many updates: \(counter)")
//            HStack(spacing:10) {
//                Text("Who is in the visibility stack")
//                ForEach(navigation.visibilityStack, id:\.id) { item in
//                    Text(item.name)
//                }
//
//            }
//
//            Spacer()
//            Text("Fruit")
//            HStack(spacing: 10) {
//                Text("Swap View")
//                ForEach(Fruit.fruitList) { item in
//                    Button(item.name) {
//                        counter += 1
//                        navigation.swapView(item)
//                    }
//                }
//            }
//
//            HStack(spacing: 10) {
//                Text("Load New Item View")
//                ForEach(Fruit.fruitList) { item in
//                    Button(item.name) {
//                        counter += 1
//                        navigation.loadView(item)
//                    }
//                }
//            }
//
//
//
//
//        }.onDisappear() {
//            print("Display view for \(item.id) is gone")
//        }.onAppear() {
//            print("Hi I'm \(item.id). I'm new here.")
//            //dump(env)
//        }
//
//        //        }.onReceive(fruitViewController.$visibilityStack) { value in
//        //            counter = 0
//        //            showMoreText = false
//        //
//        //        }
//        
//    }
//}
//
//
