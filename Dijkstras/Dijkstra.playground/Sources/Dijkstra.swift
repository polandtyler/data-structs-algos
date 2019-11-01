import Foundation

extension AdjacencyList {
    public func route(to destination: Vertex<Element>, in tree: [Vertex<Element> : Visit<Element>]) -> [Edge<Element>] {
        var vertex = destination // track current vertex
        var path: [Edge<Element>] = [] // track edges from root to destination ('visited' paths)
        
        // while loop to 'gather' the edges
        // also tests that there is a visit entry for the current vertex and that the entry is an edge
        // loop ends when condition fails
        while let visit = tree[vertex], case .edge(let edge) = visit {
            // add the edge to the beginning of the path
            path = [edge] + path
            // and set vertex to the edge's source vertex (moves one step closer to the root)
            vertex = edge.source
        }
        // return the array of edges
        return path
    }
    
    // Assumes that all edges which make up part of a route actually DO have a weight
    public func distance(to destination: Vertex<Element>, in tree: [Vertex<Element>: Visit<Element>]) -> Double {
        // get the list of edges in the path
        let path = route(to: destination, in: tree)
        // map each edge into its weight. if an edge's weight is nil, that edge gets ignored
        let distances = path.compactMap { $0.weight }
        // reduce the array of distances to their total (assumes a path with no edges has 0.0 distance)
        return distances.reduce(0.0, { $0 + $1 })
    }
    
    public func dijkstra(from source: Vertex<Element>, to destination: Vertex<Element>) -> [Edge<Element>]? {
        // Pre-load a visits-tracking variable with the source vertex and the visit.source state
        var visits: [Vertex<Element>: Visit<Element>] = [source: .source]
        
        // create queue of vertices to explore - prioritized based on distance from source
        var priorityQueue = PriorityQueue<Vertex<Element>>(sort: {
            self.distance(to: $0, in: visits) < self.distance(to: $1, in: visits)
        })
        // set the source as the "entry point"
        priorityQueue.enqueue(source)
        
        // begin exploring the graph
        // 1. dequeue the first element from the queue, call it visited
        while let visited = priorityQueue.dequeue() {
            // 1a. if its the one youre looking for...
            if visited == destination {
                // 1b. return that route!
                return route(to: destination, in: visits)
            }
            // ...not the one youre looking for, continue exploring
            // 2. get list of neighboring edges, or creating an empty list if none
            let neighbors = edges(from: visited) ?? []
            // 3. iterate through list of neighbors (if nomne, no iterations)
            for edge in neighbors {
                // 3a. test if the neighboring edge has a weight
                if let weight = edge.weight {
                    // test whether visits already has an entry for the current vertex's neighbor
                    if visits[edge.destination] != nil {
                        // if there is an entry, test to see if the distance to the current vertex + edge weight
                        // is less than the distance the priority queue is already using to prioritize the neighbor
                        if distance(to: visited, in: visits) + weight < distance(to: edge.destination, in: visits) {
                            // create or override the entry in the visits tree.
                            // tree will now use this entry to prioritize the vertex
                            visits[edge.destination] = .edge(edge)
                            // add the neighbor to the priority queue
                            priorityQueue.enqueue(edge.destination)
                        }
                    } else {
                        visits[edge.destination] = .edge(edge)
                        priorityQueue.enqueue(edge.destination)
                    }
                }
            }
        }
        
        return nil
    }
}
