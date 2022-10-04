# Exploring Programmatic Navigation Strategies

How to move around an iOS app directly controlling the NavigationStack manually. 


## Resources
- https://www.pointfree.co/blog/posts/78-reverse-engineering-swiftui-s-navigationpath-codability
- https://swiftwithmajid.com/2022/06/21/mastering-navigationstack-in-swiftui-deep-linking/
- https://swiftui-lab.com/swiftui-id/
- https://stackoverflow.com/a/73900602/5946596
- https://developer.apple.com/documentation/swiftui/bringing_robust_navigation_structure_to_your_swiftui_app




## Misc Notes

- NavigationStack sees a view of the same Type at the same place as being of the same view identity, not refreshing @State variables unless the `.id(some Hashable)` modifier is assigned to the view. 
- NavigationStack does in fact see `DisplayView<Fruit>` and `DisplayView<Vehicle>` as different views. 
- 2022-Oct-3 NavigationStack has a very very sticky relationship to the app. The RootView and the NavigationStack do not appear to get fully cleaned up. ViewModels inited in that View do not appear to deinit, and will reinit.   
