let dungeon = AdjacencyList<String>()

let entranceRoom = dungeon.createVertex(data: "Entrance")
let spiderRoom = dungeon.createVertex(data: "Spider")
let goblinRoom = dungeon.createVertex(data: "Goblin")
let ratRoom = dungeon.createVertex(data: "Rat")
let treasureRoom = dungeon.createVertex(data: "Treasure")

dungeon.add(.undirected, from: entranceRoom, to: spiderRoom, weight: 9)
dungeon.add(.undirected, from: entranceRoom, to: ratRoom, weight: 31)
dungeon.add(.undirected, from: spiderRoom, to: goblinRoom, weight: 12)
dungeon.add(.undirected, from: goblinRoom, to: treasureRoom, weight: 5)
dungeon.add(.undirected, from: ratRoom, to: treasureRoom, weight: 12)

// NOTE: WHAT HAPPENS IF ONE OF THESE WEIGHTS IS NEGATIVE??

print(dungeon.description)

print("SHORTEST ROUTE")
print("========================")
if let edges = dungeon.dijkstra(from: entranceRoom, to: treasureRoom) {
  for edge in edges {
    print("\(edge.source) -> \(edge.destination)")
  }
}
