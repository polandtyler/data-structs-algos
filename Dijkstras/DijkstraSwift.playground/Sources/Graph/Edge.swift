
public enum EdgeType {
	case directed, undirected
}

public struct Edge<T: Hashable> {
	public var source: Vertex<T>
	public var destination: Vertex<T>
	public let weight: Double?
}

extension Edge: Hashable {}
