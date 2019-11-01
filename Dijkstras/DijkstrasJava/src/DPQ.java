import java.util.*;

/*
DijkstrasPriorityQueue
 */
public class DPQ {
    public int[] dist;
    private Set<Integer> settled;
    private PriorityQueue<Node> pq;
    private int V; // number of vertices
    List<List<Node>> adj;

    public DPQ(int V) {
        this.V = V;
        dist = new int[V];
        settled = new HashSet<>();
        pq = new PriorityQueue<>(V, new Node());
    }

    public void dijkstra(List<List<Node>> adj, int src) {
        this.adj = adj;

        for (int i = 0; i < V; i++) {
            dist[i] = Integer.MAX_VALUE;
        }

        // Add source node to the priority queue
        pq.add(new Node(src, 0));

        // Distance to the source is 0
        dist[src] = 0;
        while (settled.size() != V) {
            // remove the minimum distance node from the queue
            int u = pq.remove().node;

            // adding the node whose distance is finalized
            settled.add(u);

            neighbors(u);
        }
    }

    // state-mutating
    private void neighbors(int u) {
        int edgeDistance = -1;
        int newDistance = -1;

        // for all neighbors of Vertex V
        for (int i = 0; i < adj.get(u).size(); i++) {
            Node v = adj.get(u).get(i);

            // if current node has NOT been processed
            if (!settled.contains(v.node)) {
                edgeDistance = v.weight;
                newDistance = dist[u] + edgeDistance;

                if (newDistance < dist[v.node]) {
                    dist[v.node] = newDistance;
                }

                pq.add(new Node(v.node, dist[v.node]));
            }
        }
    }
}

class Node implements Comparator<Node> {
    public int node;
    public int weight;

    public Node() {}

    public Node (int node, int weight) {
        this.node = node;
        this.weight = weight;
    }


    @Override
    public int compare(Node o1, Node o2) {
        return Integer.compare(o1.weight, o2.weight);
    }
}
