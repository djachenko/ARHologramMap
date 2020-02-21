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


# void chordless_cycles(int* adjacency, int dim)
# {
#     for (int i=0; i<dim-2; i++)
#     {
#         for(int j=i+1; j<dim-1; j++)
#         {
#             if(!adjacency[i][j])
#                 continue;

#             list<vector<int> > candidates;

#             for(int k=j+1; k<dim; k++)
#             {
#                 if(!adjacency[i][k])
#                     continue;

#                 if(adjacency[j][k])
#                 {
#                     cout << i+1 << " " << j+1 << " " << k+1 << endl;
#                     continue;
#                 }

#                 vector<int> v;

#                 v.resize(3);

#                 v[0]=j;
#                 v[1]=i;
#                 v[2]=k;

#                 candidates.push_back(v);
#             }
#             while(!candidates.empty())
#             {
#                 vector<int> v = candidates.front();
#                 candidates.pop_front();
#                 int k = v.back();
#                 for(int m=i+1; m<dim; m++)
#                 {
#                     if(find(v.begin(), v.end(), m) != v.end())
#                         continue;
#                     if(!adjacency[m][k])
#                         continue;
#                     bool chord = false;
#                     int n;
#                     for(n=1; n<v.size()-1; n++)
#                         if(adjacency[m][v[n]])
#                             chord = true;
#                     if(chord)
#                         continue;
#                     if(adjacency[m][j])
#                     {
#                         for(n=0; n<v.size(); n++)
#                             cout<<v[n]+1<<" ";
#                         cout<<m+1<<endl;
#                         continue;
#                     }
#                     vector<int> w = v;
#                     w.push_back(m);
#                     candidates.push_back(w);
#                 }
#             }
#         }
#     }
# }