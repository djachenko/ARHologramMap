from itertools import product
from typing import List

from models.graph.edge import Edge
from models.graph.vertex import Vertex


class Graph:
    def __init__(self, vertices: List[Vertex], edges: List[Edge]) -> None:
        super().__init__()

        for edge in edges:
            assert edge.first in vertices
            assert edge.second in vertices

        self.__vertices = vertices
        self.__edges = edges

    # https://stackoverflow.com/questions/4022662/find-all-chordless-cycles-in-an-undirected-graph

    def edges_for_vertex(self, vertex: Vertex) -> List[Edge]:
        return [edge for edge in self.__edges if vertex == edge.first or vertex == edge.second]

    def find_circles(self):
        circles = []

        candidate_vertices = self.__vertices.copy()

        for start_vertex in candidate_vertices:
            chains = [[start_vertex]]

            while chains:
                next_chains = []

                for chain in chains:
                    # print(chain)

                    last_vertex = chain[-1]

                    adjacent_edges = self.edges_for_vertex(last_vertex)

                    adjacent_edges = [edge for edge in adjacent_edges if not edge.is_loop()]

                    next_vertices = []

                    for adjacent_edge in adjacent_edges:
                        if adjacent_edge.first == last_vertex:
                            next_vertex = adjacent_edge.second
                        else:
                            next_vertex = adjacent_edge.first

                        if next_vertex == start_vertex:
                            circles.append(chain)

                            continue

                        if next_vertex in chain:
                            continue

                        next_vertices.append(next_vertex)

                    for next_vertex in next_vertices:
                        next_chain = chain.copy()

                        next_chain.append(next_vertex)

                        next_chains.append(next_chain)

                chains = next_chains

            candidate_vertices.remove(start_vertex)

        return circles


def main():
    edge = [0, 1, ]

    prod = list(product(edge, repeat=3))

    vertices = [Vertex(t) for t in prod]
    edges = []

    for a, b in product(vertices, repeat=2):
        if sum(abs(x - y) for x, y in zip(a.item, b.item)) == 1:
            edges.append(Edge(a, b))

    graph = Graph(vertices, edges)

    circles = graph.find_circles()

    a = 7


if __name__ == '__main__':
    main()
