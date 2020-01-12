import Foundation

let airRoutes = AdjacencyList<String>()

// Add cities (vertices) to the list of routes (graph)
let austin = airRoutes.createVertex(data: "Austin")
let sydney = airRoutes.createVertex(data: "Sydney")
let berlin = airRoutes.createVertex(data: "Berlin")
let london = airRoutes.createVertex(data: "London")
let rome = airRoutes.createVertex(data: "Rome")

// Add routes (edges)
airRoutes.add(.undirected, from: austin, to: sydney)
airRoutes.add(.undirected, from: austin, to: london)
airRoutes.add(.undirected, from: sydney, to: berlin)
airRoutes.add(.undirected, from: berlin, to: rome)
airRoutes.add(.undirected, from: london, to: rome)

print(airRoutes.description)

print("SHORTEST ROUTE")
print("========================")

//print(airRoutes.breadthFirstSearch(from: austin, to: rome))
if let edges = airRoutes.breadthFirstSearch(from: austin, to: rome) {
  for edge in edges {
    print("\(edge.source) -> \(edge.destination)")
  }
}
