# Exploring Programmatic Navigation Strategies

How to move around an iOS app directly controlling the NavigationStack manually. 

## Current Main Examples

Each of these is listed in `NavigationExplorerApp` as a possible first page. 

Exploring how view persistence / identity works:
- `RootView()`
            
Memory Leak Concerns:
- `BooleanLanding()`  Leaks
- `SplitViewLanding()`  Doesn't appear to leak
- `EnumSwapLandingView(coordinator: CoordinatorStore())`  Leaks
            
How to make a non-leaking splash page / first time user path:
- `SplashPathView(navigation: SplashPathCoordinator())`  meh. works alright but mushes concerns together
- `SplashBoolView(navigation: SplashBoolCoordinator())`  the .navDest(isPresented:) init seems flakey
- `SplashTVTEView()`  Uses two enums and two views but 1 manager class. So far the favorite because it separates the path concerns. 


## Resources
- https://www.pointfree.co/blog/posts/78-reverse-engineering-swiftui-s-navigationpath-codability
- https://swiftwithmajid.com/2022/06/21/mastering-navigationstack-in-swiftui-deep-linking/
- https://swiftui-lab.com/swiftui-id/
- https://stackoverflow.com/a/73900602/5946596
- https://developer.apple.com/documentation/swiftui/bringing_robust_navigation_structure_to_your_swiftui_app
- https://stackoverflow.com/questions/73941284/why-are-objects-still-in-memory-after-emptying-navigationstack-path/


## Misc Notes

- NavigationStack sees a view of the same Type at the same place as being of the same view identity, not refreshing @State variables unless the `.id(some Hashable)` modifier is assigned to the view. 
- NavigationStack does in fact see `DisplayView<Fruit>` and `DisplayView<Vehicle>` as different views. 
- 2022-Oct NavigationStack has a very very sticky relationship to the app. The RootView and the NavigationStack do not appear to get fully cleaned up if disappeared by flow control outside of the Navigation framework. 
