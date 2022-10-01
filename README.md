I would say that Adkarma has a point. The view is not "deiniting" as one might expect because they've "changed the path". 

The thing is it's identity is being preserved because (simplification/educated guess warning) it is  `NavigationStack[0] as? FruitView` and `NavigationStack[0] as FruitView` is still there. The `NavigationStack` will not fully clean it up until the RootView has reappeared. `NavigationStack` doesn't clean up any views until the new one has appeared. 

So, if you change `FruitViewController`  to:

```
    func openView(fruit: Fruit) {
        visibilityStack.append(fruit)
    }
```

The NavigationStack will work as expected and you will continue to add views to the stack - I've added a `counter` and the `visibilityStack` to the FruitView to make what's happening clearer as well as some messages to make it clearer when things get made and cleaned up. 

```
struct ContentView: View {
    @StateObject private var fruitController = FruitViewController()
    
    var body: some View {
        NavigationStack(path: $fruitController.visibilityStack) {
            VStack {
                ...
            }
            .onAppear() {
                print("RootView Appeared")
            }
            .navigationDestination(for: Fruit.self) {
                fruit in FruitView(fruit: fruit).environmentObject(fruitController)
            }
        }
    }

struct FruitView: View {
    // the state that will change and not be initialised
    @State private var showMoreText = false
    @State private var counter = 0
    @EnvironmentObject var fruitViewController: FruitViewController
    var fruit: Fruit
    
    var body: some View {
        VStack {
        Text("Selected fruit: " + fruit.id)
        Text("How many updates: \(counter)")
        if (showMoreText) {
            Text("The text should disappear when moving to another fruit")
            HStack(spacing: 10) {
                Text("Who is in the fruitList")
                ForEach(fruitViewController.fruitList) {
                    aFruit in Button(aFruit.id) {
                        counter += 1
                        fruitViewController.openView(fruit: aFruit)
                    }
                }
            }
            
            HStack(spacing:10) {
                Text("Who is in the visibility stack")
                ForEach(fruitViewController.visibilityStack) {
                    aFruit in Button(aFruit.id) {
                        counter += 1
                        fruitViewController.openView(fruit: aFruit)
                    }
                }
                
            }
        } else {
            Button("Show other fruits", action: showButtons)
        }
        }.onDisappear() {
            print("Fruit view \(fruit.id) is gone")
        }.onAppear() {
            print("Hi I'm \(fruit.id), I'm new here.")
            //dump(env)
        }
    }
    
    // let's change the state
    func showButtons() {
        showMoreText = true
    }
}

```

But this doesn't seem to be the behavior Adkarma wants. They don't want to go deeper and deeper. They want a hard swap at the identical position? Correct? The `NavigationStack` seems to try to increase efficiency by not destroying an existing view of the same type, which of course leaves the @State objects intact. 


The navigation path is being driven by a binding to an `Array` inside an `ObservableObject`. The `NavigationStack` continues to believe that it is at `fruitViewController.visibilityStack[0]` ... because it is. It doesn't seem to care about the content inside the wrapper beyond its Type. 

The preserved FruitView will re-run the body code, but since it isn't a "new view" (It's still good old NavigationStack[0] as FruitView)it will not hard refresh the @State vars.

But "I zero'd that out!" you say, but `NavigationStack` seems to have copy of it that DIDN'T, and it won't until it can make a new view appear, which it doesn't need to because there is in fact still something at NavigationStack[0] right away again. 


I think Adkarma is spot on that this is related to deep linking and here are some articles I quite liked about that:

- https://www.pointfree.co/blog/posts/78-reverse-engineering-swiftui-s-navigationpath-codability
- https://swiftwithmajid.com/2022/06/21/mastering-navigationstack-in-swiftui-deep-linking/

Also interesting:
- https://swiftui-lab.com/swiftui-id/

For what it's worth, to "get it done" I would just reset the variables in View when there is a content change in the Nav array explicitly checking with an `onReceive`, but I agree that seems a bit messy. I also would be interested if anyone has a more elegant solution to a hard swap of a navigation path that ends up at the same type of view at the same "distance" from the root like Adkarma's example.

```

struct FruitView: View {
    // the state that will change and not be initialised
    @State private var showMoreText = false
    @State private var counter = 0
    @EnvironmentObject var fruitViewController: FruitViewController
    var fruit: Fruit

    var body: some View {
        VStack {
            Text("Selected fruit: " + fruit.id)
            Text("How many updates: \(counter)")
            if (showMoreText) {
                Text("The text should disappear when moving to another fruit")
                HStack(spacing: 10) {
                    Text("Who is in the fruitList")
                    ForEach(fruitViewController.fruitList) {
                        aFruit in Button(aFruit.id) {
                            counter += 1
                            fruitViewController.openView(fruit: aFruit)
                        }
                    }
                }
            } else {
                Button("Show other fruits", action: showButtons)
            }
        }.onReceive(fruitViewController.$visibilityStack) { value in
            counter = 0
            showMoreText = false
            
        }
        
    }

    // let's change the state
    func showButtons() {
        showMoreText = true
    }
}

```

FWIW a `NavigationPath` it will also be looking at position rather than content so you will still need to look at it with `.onRecieve`

```
//Still cares about length/position not content.
class FruitNav: ObservableObject {
    @Published var path = NavigationPath()
    @Published var fruitList = [Fruit(name: "Banana"), Fruit(name: "Strawberry"), Fruit(name: "Pineapple")]

    // the functions that programatically call a 'new' view
    func openView(fruit: Fruit) {
        path.removeLast()
        path.append(fruit)
    }
    
    func replacePath(fruit: Fruit) {
        path = NavigationPath()
        path.append(fruit)
    }
    
    // another one giving an example of what could be a deep link
    func bananaAndStrawberry() {
        path.append(fruitList[0])
        path.append(fruitList[1])
    }

}
```
 


    
