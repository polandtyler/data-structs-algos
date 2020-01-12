/*
 Kindly adapted from wonderful tutorials by
 the brilliant minds at RayWenderlich.com
*/

//PROBLEM: Find the shortest path from ATX to Rome!
// Create the flight paths graph
let airRoutes = AdjacencyList<String>()

// Add cities (vertices) to the list of routes (graph)
let austin = airRoutes.createVertex(data: "Austin")
let sydney = airRoutes.createVertex(data: "Sydney")
let berlin = airRoutes.createVertex(data: "Berlin")
let london = airRoutes.createVertex(data: "London")
let rome = airRoutes.createVertex(data: "Rome")

// Add routes (edges)
airRoutes.add(.undirected, from: austin, to: sydney, weight: 9)
airRoutes.add(.undirected, from: austin, to: london, weight: 31)
airRoutes.add(.undirected, from: sydney, to: berlin, weight: 12)
airRoutes.add(.undirected, from: berlin, to: rome, weight: 5)
airRoutes.add(.undirected, from: london, to: rome, weight: 12)

print(airRoutes.description)

print("SHORTEST ROUTE")
print("========================")

if let edges = airRoutes.dijkstra(from: austin, to: rome) {
  for edge in edges {
    print("\(edge.source) -> \(edge.destination)")
  }
}
