//
//  NSArray+Utiles.swift
//  CollapsibleTableView
//
//  Created by Cristian Kocza on 29/03/16.
//  Copyright © 2016 Cristik. All rights reserved.
//

import Foundation

typealias ArrayDiff = (added: [Int], deleted: [Int], moved: [(from: Int, to: Int)])

func diff<Element>(array: [Element], other: [Element], equals: (Element, Element) -> Bool) -> ArrayDiff {
    var added: [Int] = []
    var deleted: [Int] = []
    var moved: [(from: Int, to: Int)] = []
    for (i, item) in array.enumerate() {
        if let j = other.indexOf({equals($0, item)}) {
            if i != j {
                moved.append((from: i, to: j))
            }
        } else {
            deleted.append(i)
        }
    }
    for (i, item) in other.enumerate() {
        if array.indexOf({equals($0, item)}) == nil {
            added.append(i)
        }
    }
    return (added: added, deleted: deleted, moved: moved)
}


func diff<Element: Equatable>(array: [Element], other: [Element]) -> ArrayDiff {
    return diff(array, other: other, equals: ==)
}


//func diff<Element: AnyObject>(array: [Element], array: [Element], other: [Element]) -> (added: [Int], deleted: [Int], moved: [(from: Int, to: Int)]) {
//    return diff(array, other: other, equals: ===)
//}