import java.util.ArrayList;
import java.util.List;

public class Main {

    public static void main(String[] args) {
        int V = 5;
        int source = 0;

        // adjacency list representation of the connected edges
        List<List<Node>> adj = new ArrayList<>();

        // init list for every node
        for (int i = 0; i < V; i++) {
            List<Node> item = new ArrayList<>();
            adj.add(item);
        }

        // Inputs for the DPQ graph
        adj.get(0).add(new Node(1, 9));
        adj.get(0).add(new Node(2, 6));
        adj.get(0).add(new Node(3, 5));
        adj.get(0).add(new Node(4, 3));

        adj.get(0).add(new Node(1, 2));
        adj.get(0).add(new Node(3, 4));

        // Calculate the single source shortest path
        DPQ dpq = new DPQ(V);
        dpq.dijkstra(adj, source);

        // Print the shortest path to all the nodes from the source node
        System.out.println("The shortest path from node: ");
        for (int i = 0; i < dpq.dist.length; i++) {
            System.out.println(source + " to " + i + " is " + dpq.dist[i]);
        }
    }


}
