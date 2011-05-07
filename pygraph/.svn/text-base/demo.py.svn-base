"""
to use, include code in your program's directory and import:
from pygraph import *

notice that you can drag nodes around and save.

# (c) Beracah Yankama, 2004-2007
# This is NOT GPL code!
"""

from tkgraphview import *		# just for demo purposes.


# the tkgraphview sort of converts from an old node-edge representation
# to the cleaner pygraph representation internally. 
# if you want, you can rewrite the tkgraphview to accept a properly 
# formed (separated) list of nodes and edges

# startup tkgraphview, see below

node_edge_old_style = []

tmpnode = {}
tmpnode['node'] = 'A'
tmpnode['features'] = ''		# style=filled		# holdover from .dot generation days
tmpnode['edges'] = ['B','C']
tmpnode['edgenames'] = ['to B','to C']
tmpnode['shape'] = 'rect'		# options: rect, oval
tmpnode['color'] = 'green'		# color name, or in hex: #FFf0FF
node_edge_old_style.append(tmpnode)

tmpnode = {}
tmpnode['node'] = 'B'
tmpnode['features'] = ''
tmpnode['edges'] = ['B','C']
tmpnode['edgenames'] = ['yay me','B to C']
tmpnode['shape'] = ''
tmpnode['color'] = 'blue'
node_edge_old_style.append(tmpnode)

tmpnode = {}
tmpnode['node'] = 'C'
tmpnode['features'] = ''
tmpnode['edges'] = []
tmpnode['edgenames'] = []
tmpnode['shape'] = ''
tmpnode['color'] = ''
node_edge_old_style.append(tmpnode)


if __name__ == '__main__':
	
	# print node_edge_old_style
	filename = 'test'
	# startTk = True if tkgraphview should start tk
	tkGraphView(node_edge_old_style, "Graph Viewer Title", root=None, outfile=filename, graphtype='directed',startTk=True)