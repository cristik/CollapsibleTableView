//
//  NSArray+Utiles.swift
//  CollapsibleTableView
//
//  Created by Cristian Kocza on 29/03/16.
//  Copyright © 2016 Cristik. All rights reserved.
//

import Foundation

typealias ArrayDiff = (added: [Int], deleted: [Int], moved: [(from: Int, to: Int)])

extension Array {
    func diff(other: [Element], equals: (Element, Element) -> Bool) -> ArrayDiff {
        var added: [Int] = []
        var deleted: [Int] = []
        var moved: [(from: Int, to: Int)] = []
        for (i, item) in self.enumerate() {
            if let j = other.indexOf({equals($0, item)}) {
                if i != j {
                    moved.append((from: i, to: j))
                }
            } else {
                deleted.append(i)
            }
        }
        for (i, item) in other.enumerate() {
            if self.indexOf({equals($0, item)}) == nil {
                added.append(i)
            }
        }
        return (added: added, deleted: deleted, moved: moved)
    }
}

extension Array where Element: Equatable {
    func diff(other: [Element]) -> ArrayDiff {
        return diff(other, equals: ==)
    }

}






//func diff<Element: AnyObject>(array: [Element], array: [Element], other: [Element]) -> (added: [Int], deleted: [Int], moved: [(from: Int, to: Int)]) {
//    return diff(array, other: other, equals: ===)
//}