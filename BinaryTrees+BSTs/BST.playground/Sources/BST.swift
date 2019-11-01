import Foundation

public class Node<T: Comparable> {
    public var value: T
    public var leftChild: Node?
    public var rightChild: Node?
    
    
    public init(value: T) {
        self.value = value
    }
}


// clean this up
// makw BST implement only in Node struct
public class BinarySearchTree<T: Comparable> {
    public var value: T
    public var parent: BinarySearchTree?
    public var left: BinarySearchTree?
    public var right: BinarySearchTree?
    
    public init(value: T) {
        self.value = value
    }
}
