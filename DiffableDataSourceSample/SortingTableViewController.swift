//
//  SortingTableViewController.swift
//  DiffableDataSourceSample
//
//  Created by Kevin Clark on 1/1/20.
//  Copyright © 2020 Kevin Clark. All rights reserved.
//

import UIKit

class SortingTableViewController: UITableViewController {

  enum Section {
    case main
  }

  let items = [
    Item(name: "Apple", category: .fruit),
    Item(name: "Avocado", category: .fruit),
    Item(name: "Banana", category: .fruit),
    Item(name: "Blueberries", category: .fruit),
    Item(name: "Broccoli", category: .vegetable),
    Item(name: "Carrot", category: .vegetable),
    Item(name: "Potato", category: .vegetable),
    Item(name: "Pumpkin", category: .vegetable)
  ]

  var dataSource: UITableViewDiffableDataSource<Section, Item>!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Add segmented control
    var filters = ["All"]
        filters.append(contentsOf: Category.allCases.map({ $0.rawValue }))
    let segmentedControl = UISegmentedControl(items: filters)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(valueChanged(segmentedControl:)), for: .valueChanged)
    navigationItem.titleView = segmentedControl

    // Register default cell
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")

    // Setup diffable data source
    dataSource = UITableViewDiffableDataSource(tableView: tableView) { (tableView, indexPath, item) -> UITableViewCell? in
      let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
          cell.textLabel?.text = item.name
      return cell
    }

    // Apply Snapshot
    updateList()
  }

  @objc func valueChanged(segmentedControl: UISegmentedControl) {
    let index = segmentedControl.selectedSegmentIndex

    if index == 0 { // All
      updateList()
    } else { // Fruit or Vegetable
      let selectedCategory = Category.allCases[index - 1] // Account for the fact that All is the first segment
      updateList(selectedCategory: selectedCategory)
    }
  }

  func updateList(selectedCategory: Category? = nil) {
    var filteredItems = items

    // If a selected category is passed, only show that one
    if let selectedCategory = selectedCategory {
      filteredItems = items.filter({ (item) -> Bool in
        item.category == selectedCategory
      })
    }

    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filteredItems)

    dataSource.apply(snapshot, animatingDifferences: true)
  }

}
