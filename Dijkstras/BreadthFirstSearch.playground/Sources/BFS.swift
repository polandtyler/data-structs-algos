import Foundation

public enum Visit<Element: Hashable> {
    case source
    case edge(Edge<Element>)
}

extension AdjacencyList {
   public func breadthFirstSearch(
    from source: Vertex<Element>,
    to destination: Vertex<Element>
   ) -> [Edge<Element>]? {
    
    // create a queue for all vertices, and enqueues the source vertex
    var queue = Queue<Vertex<Element>>()
    queue.enqueue(source)
    
    // create a map/dictionary of vertex keys and visit values, and initializes with source
    var visits: [Vertex<Element> : Visit<Element>] = [source: .source]
    
    // dequeues a vertex from the queue and calls it a "visited vertex"
    // first iteration -> the visited vertex will be the source vertex and the queue will immediately be empty
    // but... if visiting the source vertex adds more vertices to the loop, the search will continue.
    while let visitedVertex = queue.dequeue() {
        
        if visitedVertex == destination {
            // store each vertex which is part of the route
            var vertex = destination
            // store the route itself
            var route: [Edge<Element>] = []
            
            // while loop continues as long as the visits Map/Dictionary has an entry for the vertex
            while let visit = visits[vertex],
                // also, the entry is an edge (if the entry is a source, the while loop will end.
                case .edge(let edge) = visit {
                    // we added that edge to the start of our route
                    // and set the vertex to that edge's source. This gets us one step closer to the beginning.
                    route = [edge] + route
                    vertex = edge.source
            }
            // while loop has exited, so route is now complete.
            return route
        }
        
        // enqueue the visited vertex's neighbors
        let neighbors = edges(from: visitedVertex) ?? [] // edges(from:) gets an optional array of edges from the specific parameter vertex
        for edge in neighbors {
            // if the map/dictionary has no entry for a node, then it hasnt been queued up yet
            if visits[edge.destination] == nil {
                // if we havent seen it before, add it to both queues ("vertices to process".... AKA the queue
                // and "vertices encountered" ... AKA enqueuedVertices
                queue.enqueue(edge.destination)
                // whenever you queue up a vertex, record the edge you took to reach it
                // which gives this algo a "path to destination" record
                visits[edge.destination] = .edge(edge)
            }
        }
    }
    // queue has run out of nodes
    return nil
   }
}
