//
//  Item.swift
//  DiffableDataSourceSample
//
//  Created by Kevin Clark on 1/1/20.
//  Copyright © 2020 Kevin Clark. All rights reserved.
//

import Foundation

enum Category: String, CaseIterable {
  case fruit = "Fruit"
  case vegetable = "Vegetable"
}

struct Item: Hashable {
  let name: String
  let category: Category
  let identifier = UUID()

  func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
  }

  static func ==(lhs: Item, rhs: Item) -> Bool {
    return lhs.identifier == rhs.identifier
  }
}
