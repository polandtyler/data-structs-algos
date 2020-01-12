import Foundation

public struct Stack<Element> {
    fileprivate var array: [Element] = []
    public init() {}
    
    public mutating func push(_ element: Element) {
        array.append(element)
    }
    
    public mutating func pop() {
        array.popLast()
    }
    
    public func peek() -> Element? {
        return array.last
    }
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
}

extension Stack : CustomStringConvertible {
    public var description: String {
        let top = "---Stack---\n"
        let bottom = "\n-----------\n"
        
        let stackElements = array.map { "\($0)" }.reversed().joined(separator: "\n")
        return top + stackElements + bottom
    }
    
    public var shortestPath: String {
        return array.map { "\($0)" }.joined(separator: " -> ")
    }
}
