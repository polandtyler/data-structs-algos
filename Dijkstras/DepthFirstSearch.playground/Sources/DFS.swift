import Foundation
/*
Example Usages:
 - Topological sorting
 - Detecting a cycle
 - Pathfinding (our example)
 - Finding connected components in a sparse graph
*/

public class Search {
    public init() {}
    
    public func depthFirstSearch(
        from start: Vertex<String>,
        to end: Vertex<String>,
        graph: AdjacencyList<String>
        ) -> Stack<Vertex<String>> {
        
        // create set to store all vertices - prevents infinite loops
        var visited = Set<Vertex<String>>()
        // create stack to store the path as a stack
        var stack = Stack<Vertex<String>>()
        
        stack.push(start)
        visited.insert(start)
        
        // syntax note: the outerLoop is a labeled statement
        // which allows us to break out of an inner loop
        
        // Begin peeking at the stack's top vertex
        // as long as the vertex is not at the end, keep going
        outerLoop: while let vertex = stack.peek(), vertex != end {
            // check to see if that vertex has any neighbors
            // if none, dead end.
            // then backtrack by popping the current vertex off the stack
            guard let neighbors = graph.edges(from: vertex), neighbors.count > 0 else {
                print("Backtrack from \(vertex)")
                stack.pop()
                continue
            }
            
            // if there are neighbors, however....
            for edge in neighbors {
                // assuming it has not been visited...
                if !visited.contains(edge.destination) {
                    // mark the vertex as visited
                    visited.insert(edge.destination)
                    // push the vertex onto the stack
                    stack.push(edge.destination)
                    // print current path -- for demo purposes
                    // print(stack.description)
                    // continue to the outer `while` loop to branch off the vertex we just pushed
                    // tl;dr - restart the process from the outer loop
                    continue outerLoop
                }
            }
            // if all the edges have been visited
            // so backtrack and pop it off the stack
            print("backtrack from \(vertex)")
            stack.pop()
        }
        
        // demo purposes
        print(stack.shortestPath)
        // once the search completes, stack contains path
        return stack
    }
}
