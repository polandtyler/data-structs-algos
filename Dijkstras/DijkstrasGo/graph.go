package main

type edge struct {
	node   string
	weight int
}

type graph struct {
	nodes map[string][]edge
}

func newGraph() *graph {
	return &graph{nodes: make(map[string][]edge)}
}

func (g *graph) addEdge(origin, destination string, weight int) {
	g.nodes[origin] = append(g.nodes[origin], edge{node: destination, weight: weight})
	g.nodes[destination] = append(g.nodes[destination], edge{node: origin, weight: weight})
}

func (g *graph) getEdges(node string) []edge {
	return g.nodes[node]
}

func (g *graph) getPath(origin, destination string) (int, []string) {
	h := newHeap()
	h.push(path{
		value: 0,
		nodes: []string{origin},
	})
	visited := make(map[string]bool)

	for len(*h.values) > 0 {
		// find the nearest yet-to-visit node
		p := h.pop()
		node := p.nodes[len(p.nodes)-1]

		if visited[node] {
			continue
		}

		if node == destination {
			return p.value, p.nodes
		}

		for _, e := range g.getEdges(node) {
			if !visited[e.node] {
				// calculate total spend so far + cost and path of getting to this node
				h.push(path{
					value: p.value + e.weight,
					nodes: append([]string{}, append(p.nodes, e.node)...),
				})
			}
		}

		visited[node] = true
	}

	return 0, nil
}
