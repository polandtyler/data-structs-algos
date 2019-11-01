// Graph representation:
// https://hackernoon.com/hn-images/1*lzYuC6dIVTVl0gt3MOuCyw.jpeg

const graph = {
    start: {A: 5, B: 2},
    A: {C: 4, D: 2},
    B: {A: 8, D: 7},
    C: {D: 6, finish: 3},
    D: {finish: 1},
    finish: {},
};

// track the lowest cost to reach each node
const weights = {
    A: 5,
    B: 2,
    finish: Infinity
  };

  // track ther cheapest path
  const cheapestParents = {
    A: 'start', 
    B: 'start', 
    finish: null
  };

  // track which nodes have already been processed
  const processed = [ "start", "A", "B" ];

  const lowestCostNode = (weights, processed) => {
      return Object.keys(weights).reduce( (lowest, node) => {
          if (lowest === null || weights[node] < weights[lowest]) {
              if (!processed.includes(node)) {
                  lowest = node;
              }
          }
          return lowest
      }, null);
  };

  const dijkstra = (graph) => {
      const weight = Object.assign({finish: Infinity}, graph.start);
      const parents = { finish: null };
      for (let child in graph.start) { // add children of start node
        parents[child] = 'start';
      }
      const processed = [];
      let node = lowestCostNode(weights, processed);

      while (node) {
          let weight = weights[node]; // weight of the current node
          let children = graph[node]; // get all children of current node

          // 1. loop through all children
          // 1a. calculate cost (weight) to reach that current node
          // 1b. update weight in the weights object if it is the CHEAPEST (or the only weight available)
          // 1c. update parents object so that we can retrace steps in the end
          for (let n in children) {
              let newWeight = weight + children[n];
              
              if (!weights[n]) {
                  weights[n] = newWeight;
                  parents[n] = node;
              }

              if (weights[n] > newWeight) {
                  weights[n] = newWeight;
                  parents[n] = node;
              }
          }
          // after node is fully processed, push it onto the processed object
          processed.push(node);
          // reset the value of the current node to the cheapest unprocessed node, and repeat
          node = lowestCostNode(weights, processed);
      }

      // build optimal path
      let optimalPath = ['finish'];
      let parent = parents.finish;
      
      while (parent) {
          optimalPath.push(parent);
          parent = parents[parent];
      }
      // reverse optimal path to get correct order
      optimalPath.reverse();

      const results = {
          distance: weights.finish,
          path: optimalPath
      };

      return results;
  };
  // EOFunc

  console.log(dijkstra(graph));



