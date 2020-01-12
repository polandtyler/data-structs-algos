import Foundation

public struct Vertex<T: Hashable> {
    public var data: T
}

extension Vertex: Hashable {}

extension Vertex: CustomStringConvertible {
    public var description: String {
        return "\(data)"
    }
}
