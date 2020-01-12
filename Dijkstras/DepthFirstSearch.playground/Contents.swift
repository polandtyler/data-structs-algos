import Foundation

//let graph = AdjacencyList<String>.createTestAdjacencyList()

let adjacencyList = AdjacencyList<String>()
let s = adjacencyList.createVertex(data: "S")
let a = adjacencyList.createVertex(data: "A")
let b = adjacencyList.createVertex(data: "B")
let c = adjacencyList.createVertex(data: "C")
let d = adjacencyList.createVertex(data: "D")
let f = adjacencyList.createVertex(data: "F")
let g = adjacencyList.createVertex(data: "G")
let e = adjacencyList.createVertex(data: "E")

adjacencyList.add(.undirected, from: s, to: a)
adjacencyList.add(.undirected, from: a, to: b)
adjacencyList.add(.undirected, from: a, to: d)
adjacencyList.add(.undirected, from: a, to: c)
adjacencyList.add(.undirected, from: b, to: d)
adjacencyList.add(.undirected, from: d, to: g)
adjacencyList.add(.undirected, from: d, to: f)
adjacencyList.add(.undirected, from: f, to: e)

print(Search().depthFirstSearch(from: s, to: e, graph: adjacencyList))
