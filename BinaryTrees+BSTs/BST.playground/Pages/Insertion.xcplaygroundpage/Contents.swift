import Foundation

// MARK: INSERTION
extension BinarySearchTree {
    public func insert(value: T) {
        
        if value < self.value { // Check to see if there's a left value
            if let left = left {
                left.insert(value: value) // Recursively call insert to repeat the process
            } else { // Left is nil, create new node
                left = BinarySearchTree(value: value)
                left?.parent = self // ...and set parent to root
            }
        }
            
        // Repeat the process for right side
        else {
            if let right = right {
                right.insert(value: value)
            } else {
                right = BinarySearchTree(value: value)
                right?.parent = self
            }
        }
        
    }
}

// MARK: Insertion Test
let tree = BinarySearchTree<Int>(array: [7, 2, 5, 10, 12, 1])
print(tree.description)
tree.insert(value: 17)
//print(tree.description)




