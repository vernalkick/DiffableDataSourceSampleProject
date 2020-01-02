# DiffableDataSourceSampleProject

The new diffable data sources introduced in iOS 13 [are pretty great](https://www.swiftjectivec.com/ios-13-notable-uikit-additions/#diffing). They make it easier to apply changes by calculating the differences in data for you and transitioning the UI to the new state with an animation.

Passing `true` to the `animatingDifferences` parameter of the `apply()` method on the data source is all you need to let the system will automatically generate the animation for you:

```swift
dataSource.apply(snapshot, animatingDifferences: true)
```

When you update the snapshot with a list that has elements in common with the previous snapshots, you get a vertical animation, as expected. 

![All](https://user-images.githubusercontent.com/1269855/71647886-91d6a280-2cca-11ea-9527-8203b1d4e1f2.gif)


# However

I noticed that when there are no elements in common between the two snapshots, the automatic animation is horizontal which is pretty strange and distracting.

![Horizontal](https://user-images.githubusercontent.com/1269855/71647908-dfeba600-2cca-11ea-990d-65bd7f4e8f51.gif)

---

I'm not sure if there's anything that _I'm_ doing wrong, if it's a known bug or if it's intended behavior. I'd be curious to hear if this is something anyone has run into and if there's a workaround.

Feel free to email me at kevin@kevinclark.ca. Thanks! ✌️
