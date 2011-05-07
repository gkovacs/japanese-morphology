################################ Grapher ##########################
# Grapher class, to take edges, add nodes, and lay them out in some sensible way.
# on the canvas in some sensible way.

# todo:
# make sure prints are gone
# remove \n from dot strings (line 2910)
# x add curved lines
# output to png  (limitation...)

# (c) Beracah Yankama, 2004-2007
# This is NOT GPL code!

import random

try:
	from numpy import *
except:
	from Numeric import *
	
	
class Node:
    def __init__(self, name, label='', color='grey', shape='oval', term=''):
        self.name = str(name)
        self.label = str(label)
        self.color = str(color)
        self.shape = str(shape)
        self.term = str(term)
        
        if not label:   # default label
            self.label = str(name)
        
        
        # !!! eventually to make transparent, define "trans"
        if not color:   # default colors
            self.color = 'grey'
        
        self.x = float(random.randint(0,400))       # initialize to a random position
        self.y = float(random.randint(0,400))       # when drawing, we will convert to an int
        
        self.fx = float(0.0)                    # sum of forces across the node    -> is +, <- is -
        self.fy = float(0.0)
            
class Edge:
    def __init__(self, fromname, toname, label, color = 'green'):
        self.fromname= str(fromname)
        self.toname = str(toname)
        self.label = str(label)
        self.color = str(color)
        
        self.labelx = 0.0
        self.labely = 0.0
        self.edgepoints = []
        
class Grapher:
    def __init__(self, direction, canvas = ''): # , nodes = [], edges = []):
        # setup variables
        self.nodes = [] # nodes
        self.edges = [] # edges
        self.direction = direction      # valid options are 'undirected', 'directed'
        
        self.edgenames = {} # edges by the name of nodes
        self.nodenames = {} # nodes by the name
        
        self.nodeDir = {}       # direction by node name
        
        # set up blank layout
        self.k = 0.0
        self.x = 0.0
        self.y = 0.0
        
        self.updated = 0
        
        self.gridsize = 10
        
        
        self.layoutgrid = resize(None,(2,2))    # only used in the hierarchical layout
        self.layoutx = 0.0
        self.layouty = 0.0
        
        self.start = None       # starting node (terminator)
        self.end = None     # ending node (terminator)
        
        
        if canvas:
            self.x = float(canvas.__getitem__('width'))
            self.y = float(canvas.__getitem__('height'))
            
            
            # open space attractor
            # setup a 10x10 grid, 
            self.grid = resize([float(self.k * 10)],(self.gridsize,self.gridsize))
            # each [i,j]
            self.gridx = self.x/self.gridsize
            self.gridy = self.y/self.gridsize
        
    def setCanvas(self, canvas):
        self.k = 0.0
        self.x = 0.0
        self.y = 0.0
        
        self.gridsize = 10
        
        self.layoutgrid = resize(None,(2,2))    # only used in the hierarchical layout
        self.layoutx = 0.0
        self.layouty = 0.0
        
        if canvas:
            self.x = float(canvas.__getitem__('width'))
            self.y = float(canvas.__getitem__('height'))
            
            
            # open space attractor
            # setup a 10x10 grid, 
            self.grid = resize([float(self.k * 10)],(self.gridsize,self.gridsize))
            # each [i,j]
            self.gridx = self.x/self.gridsize
            self.gridy = self.y/self.gridsize

    
    def destroy(self):
        self.nodes = None
        self.edges = None
    
    def __len__(self):
        return len(self.nodes)
    def addNode(self, name, label='', color='grey', shape='oval', term=''):
        node = Node(name,label,color, shape, term)
        self.nodes.append(node)
        self.nodenames[name] = node
        
        if term == 'start':
            self.start = node
        elif term == 'end':
            self.end = node
        
        # check if node name is already in this object.
        self.updated = 1
#       print name
    
    def addEdge(self, fromnode, tonode, label='',color='green', dup=True):
        edge = self.getEdge(fromnode, tonode)
        if dup or edge is None:
            edge = Edge(fromnode,tonode,label,color)
            
            if not self.edgenames.has_key(fromnode):
                self.edgenames[fromnode] = {}
            self.edgenames[fromnode][tonode] = edge
            
            self.edges.append(edge)
        else:
            if label:
                edge.label = '%s, %s' % (edge.label, label)
        
        self.updated = 1
    
    def getNodebyName(self,name):
        if self.nodenames.has_key(name):
            return self.nodenames[name]
        
#       for node in self.nodes:
#           if str(node.name) == str(name): return node
#       print str(name) + " not found";
        return ''
        
    def checkConnected(self, nodename1, nodename2):

        # for edge in self.edges:
        #   # print edge.fromname + ' ' + edge.toname
        #   if (nodename1 == edge.fromname) and (nodename2 == edge.toname):
        #       return 1
        #   if (nodename2 == edge.fromname) and (nodename1 == edge.toname):
        #       return 1
        
        if self.edgenames.has_key(nodename1):
            if self.edgenames[nodename1].has_key(nodename2): return 1
        if self.edgenames.has_key(nodename2):
            if self.edgenames[nodename2].has_key(nodename1): return 1
        
    def getEdge(self, nodename1, nodename2):

        # for edge in self.edges:
        #   # print edge.fromname + ' ' + edge.toname
        #   if (nodename1 == edge.fromname) and (nodename2 == edge.toname):
        #       return 1
        #   if (nodename2 == edge.fromname) and (nodename1 == edge.toname):
        #       return 1
        
        if self.edgenames.has_key(nodename1):
            if self.edgenames[nodename1].has_key(nodename2):
                return self.edgenames[nodename1][nodename2]
        return None
    
    def getChildren(self,nodename):
        # print 'from-> ' + nodename
        if self.edgenames.has_key(nodename):
            return self.edgenames[nodename].keys()

        # Rob added this
        return []

    def getParents(self,nodename):
        # print 'from-> ' + nodename
        parents = []
        for edge in self.edges:
            for noden in self.edgenames.keys():
                if self.edgenames[noden].has_key(nodename):
                    parents.append(noden)
                    
        return parents

    
    
    # for directed graphs, this provides a metric to find which nodes
    # are more "directional" (i.e. at the end or start) than others.
    def NodeDirection(self, nodename, node='',typeg='directed'):
        # we check to see if this node is at the end of an edge tree..
        # use better edge struct
        
        if not (nodename or node): return 0
        
        # check to see if termination node..
        if node:
            if node.term == 'start': return -1 * self.k
            elif node.term == 'end': return self.k
            elif not self.updated:
                return self.nodeDir[node]
        else:
            node = self.getNodebyName(nodename)
        
        # if there have been no updates, then the node direction will be the same
        if not self.updated:
            return self.nodeDir[node]
            
            
            
        endcount = 0.0
        startcount = 0.0
        totalconnect = 0.0
        for edge in self.edges:
            if str(node.name) == edge.toname: 
                endcount += 1.0
            if str(node.name) == edge.fromname:
                startcount += 1.0
                
            if (str(node.name) == edge.fromname) or (str(node.name) == edge.toname):
                totalconnect += 1.0
                
            

        # if this node is at the end of more edges than beginning, we
        # pull to the bottom
        
        if (totalconnect > self.k): totalconnect = float(self.k - 1)
         
        direction = 0   # zero means we know nothing about this node, its floating.
        
#       print node.name + ' ' + str(startcount) + ' ' + str(endcount)
        
        if (typeg == '' ): #  (typeg == 'directed'):
            # this node is both a beginning and end -- later we'll place it on heirarchy
            # for now we let the tensions resolve.
            if (endcount and startcount):
                direction = 0
        
        else:
            if endcount > startcount:
                direction = totalconnect * endcount/(startcount+endcount)
    
            elif startcount > endcount: # negative direction for start & how much of a "starter" this is
                direction = -1 * totalconnect * startcount/(startcount+endcount)


        self.nodeDir[node] = direction  
        
        return direction
        
    
    # chooses a random placement of nodes somewhat close to 
    # nodes they are connected to
    def intelligentRandomize(self):
        if self.direction == 'directed':
            # INITIAL LAYOUT
            # 1. if no grid set up, compute a grid with all nodes on it
            self.layoutx = int(1.5 * ceil(len(self.nodes)**.5) + 1) # len(self.nodes) # 
            self.layouty = self.layoutx 
            self.layoutgrid = resize(None,(self.layoutx,self.layouty))
            
            # the scale between the canvas and the layout
            self.scalex = self.x/(self.layoutx-1)
            self.scaley = self.y/(self.layouty-1)
            
            
            """     
            # 2. place the terminators on the top and bottom.
            i = 1   # start away from the edges.
            j = 1
            for node in self.nodes:
            # while i < len(self.nodes):
                self.layoutgrid[i][j] = node
                i+=1
                if (i >= (self.layoutx-1)):
                    i=1
                    j+=1
                    
                # print str(i) + ' ' + str(j)
            """
            
        else:
            # number of nodes = number of sections & circumference
            # for circle calc
            circum = 50 * len(self.nodes)
            rad = circum/(2 * 3.14)
            theta = 360/len(self.nodes)
            
        
            # !! check what the type of graph is!
    
    
            # using our knowledge of node connectivity, randomize the positions...
            # first version just randomizes x, positioning y.
            i = 0
            for node in self.nodes:
                nodedir = self.NodeDirection(node.name, node)
                # if nodedir != 0.0:
                node.y = (.5 * self.y) + .4 * self.y * nodedir #  + float(random.randint(0,10))
                node.x = float(random.randint(0,self.x))
                
                #else:
                    # place on outer positions of an oval.
                    # centered in the middle 
                    # opp = rad * math.sin(theta*i)
                    # adj = rad * math.cos(theta*i)
                    # node.x = adj + .5 * self.x
                    # node.y = (.2 * opp) + .5 * self.y
                #   _a = 1
                    # just leave where it is..
                    
                i+=1    
                    
                    
                # print 'node: ' + node.name + ' ' + str(node.x) + ' ' + str(node.y) 
    
            # ok, for all the edges, we want to place each node somewhat close to each other..
            self.randomCloserize()
            
            # now do it again, but move node1 to the midpoint between it and its node friend
            for edge in self.edges:
                node1 = self.getNodebyName(edge.fromname)
                node2 = self.getNodebyName(edge.toname)
                
                if node1 and node2:
                    xymid = FindMidpoint(node1.x,node1.y,node2.x,node2.y)
                    node1.x = xymid[0]
                    node1.y = xymid[1]
                
    
    
    def randomCloserize(self):
        for edge in self.edges:
            node1 = self.getNodebyName(edge.fromname)
            node2 = self.getNodebyName(edge.toname)
            
            if node1 and node2:
                xymid = FindMidpoint(node1.x,node1.y,node2.x,node2.y)
                node2.x = xymid[0]
                node2.y = xymid[1]
                # node2.x = float(random.randint(int(node1.x-50),int(node1.x+50)))
                # node2.y = float(random.randint(int(node1.y-50),int(node1.y+50)))
                
                
    
    
    def layout(self,canvas, method='spring', iterate=30):
        if self.direction == 'directed':
            self.HIERlayout(canvas, method, iterate)
        else:
            self.SPRINGlayout(canvas, method, iterate)
    
    
    # for hierarchical layout
    def getFirstfreeRow(self,currentrow, currentcol, spacesneeded):
        # choose whether to move the current nodes over, or go to the next row.
        # return row number and col number.
        
        
        i = currentrow
        while i < self.scalex:
            # check if there are any nodes in this row.
            # 
            availablespaces = 0
            for j in range(self.scaley):
                if self.layoutgrid[i][j]:
                    availablespaces = 0
                else:
                    availablespaces += 1
                
                if (availablespaces == spacesneeded):
                    return (j-availablespaces)
            
            i += 1  
        
    
    def findClosestFree(self,x, y, dirs):
        # look within 3
        # we prefer the same row
        if dirs == 'down':
            dn = range(0,self.layouty)      # [0, 1, 2, 3, 4,5,6]
        else:
            dn = range(0,(-1 * self.layouty),-1)    # [0, -1, -2, -3, -4,-5,-6]
            dn.append(1)
            dn.append(2)
            
        for j in dn:    # go down for now
            if y+j < 0: 
                continue
            elif y+j >= self.layouty: 
                continue
            else:
                for i in (0, 1, -1, 2, -2, 3, -3, 4, -4):
                    if x+i >= self.layoutx:
                        continue
                    elif x+i < 0:
                        continue 
                    elif self.layoutgrid[x+i][y+j]:
                        continue
                    else:
                        return [x+i,y+j]
        
    
    
    #######################
    # HIERARCHICAL LAYOUT
    # hierarchical layout for directed graphs.
    def HIERlayout(self, canvas, method='', iterate=30):
        unplaced = self.nodes
        # unplaced.append(self.start)   # ...
        
        placed = {}
        placements = {}

        parenti = 1
        parentj = 1
        thisi = 1
        thisj = 1
        childi = 1
        childj = 1
        iter = 0
        
        self.updated = 1
        
        if not self.start:
            largest = -1.0
            largestnode = ''
            for node in self.nodes:
                nd = self.NodeDirection('', node)
                if nd > largest:
                    largest = nd
                    largestnode = node
                    # print str(nd) + ' ' + largestnode.name
                    
            
            # artificially choose to make a node first.
            if largestnode:
                self.start = largestnode
                # print "START: " + self.start.name
                
        
        # find and place top and bottom
        
        if self.start:
            thisi = int(self.layoutx/2)
            thisj = 1
            self.layoutgrid[thisi][thisj] = self.start
            self.start.x = thisi*self.scalex
            self.start.y = thisj*self.scaley
            placements[self.start] = [thisi,thisj]


        # place the lowest?
        if self.end:
            thisi = int(self.layoutx/2)
            thisj = self.layouty-2
            self.layoutgrid[thisi][thisj] = self.end
            self.end.x = thisi*self.scalex
            self.end.y = thisj*self.scaley
            placements[self.end] = [thisi,thisj]

        
        
        toprocess = self.nodes
        while (len(toprocess) and (iter < 3 * len(self.nodes))):
            node = toprocess[0]
            toprocess = toprocess[1:]
            # toprocess.remove(node)    # does this delete the node?
            iter += 1           


            if not placements.has_key(node):
                toprocess.append(node)
                continue

            # if we know where this node is, then place the children below it.
                
            thisi = placements[node][0]
            thisj = placements[node][1]

            # place children below

            
            childj = thisj+1    # start in the row immediately below
            children = list(self.getChildren(node.name))
            childi = thisi - int(round(len(children)/2))    # start n/2 children to the left.

            for childname in children:
                
                cnode = self.getNodebyName(childname)

                if not cnode: continue
                
                # unplaced.append(cnode)
                
                # if this node is already placed, skip
                if placements.has_key(cnode): 
                    continue
                
                
                # this is a hard coded start and end.  If none of those,
                # try to predict the start and end
                if cnode == self.end: continue
                elif cnode == self.start: continue
                

                if (childi >= self.layoutx): childi = self.layoutx-1
                if (childi < 0): childi = 0
                if (childj >= self.layouty): childj = self.layouty-1
                if (childj <0 ): childj = 0
                
                # print 'Cnode: ' + cnode.name
                # check if this node would overlap
                
                # put this node back on the list for position
                # if (self.layoutgrid[childi][childj]):
                #   unplaced.append(self.layoutgrid[childi][childj])
                    # if (placed.has_key(self.layoutgrid[childi][childj])):
                    #   placed.delete(self.layoutgrid[childi][childj])
                
                # if there is already a node here, find the closest free node.
                
                x = self.findClosestFree(childi,childj,'down')
                
                # place blindly for now
                self.layoutgrid[x[0]][x[1]] = cnode
                placements[cnode] = [x[0],x[1]]
                # print placements.keys()

                childi += 1

        

        # now take care of parents, now that we did all children
        iter = 0
        toprocess = self.nodes
        while (len(toprocess) and (iter < 3 * len(self.nodes))):
            node = toprocess[0]
            toprocess = toprocess[1:]
            iter += 1           


            if not placements.has_key(node):
                toprocess.append(node)
                continue

            # if we know where this node is, then place the children below it.
                
            thisi = placements[node][0]
            thisj = placements[node][1]

            # now place the parents, a level higher..   
            parentj = thisj-1
            parents = self.getParents(node.name)
            parenti = thisi - int(round(len(parents)/2))

            for nodename in parents:
                
                pnode = self.getNodebyName(nodename)

                if not pnode: continue
                if pnode == node: continue

                if placements.has_key(pnode): 
                    continue

                # this is a hard coded start and end.  If none of those,
                # try to predict the start and end
                if pnode == self.end: continue
                elif pnode == self.start: continue
                

                if (parenti >= self.layoutx): parenti = self.layoutx-1
                if (parenti < 0 ): parenti = 1
                if (parentj >= self.layouty): parentj = self.layouty-1
                if (parentj < 0 ): parentj = 1
                
                x = self.findClosestFree(parenti,parentj,'up')
                
                self.layoutgrid[x[0]][x[1]] = pnode
                placements[pnode] = [x[0],x[1]]
            
                parenti += 1
                
#               print 'nodeP: ' + pnode.name + ' ' + str(parenti) + ' ' + str(parentj)  

        



        # print placements
            
        # update all the actual positions
        for pnode in placements.keys():
            pnode.x = placements[pnode][0] * self.scalex
            pnode.y = placements[pnode][1] * self.scaley
#           print pnode.name + ' ' + str(pnode.x) + ' ' + str(pnode.y) + ' [ ' + str(placements[pnode][0]) + ' ' + str(placements[pnode][1]) + ' ]'



        # update the label positions (no need, the scaler will do it)
        # for edge in self.edges:
        #   self.updateLabelPos(edge)


#       for pnode in self.nodes:
#           print 'pn: ' + pnode.name
#           if placements.has_key(pnode):
#               print '--' + pnode.name


        self.scaletoCanvas()




    ####################
    # SPRING LAYOUT:
    # edge (connection) springs
    # node-charge repulsion
    # open space attractors
    # label repulsion
    # outer edge springs force central collection
    def SPRINGlayout(self, canvas, method='spring', iterate=30):
        # get the size from the canvas

        self.k = 5
        self.x = float(canvas.__getitem__('width'))
        self.y = float(canvas.__getitem__('height'))

        # force proportional for 1/2 canvas distance
        self.canvas_fx = self.k * self.x # .5 * k * (x/2)**2
        self.canvas_fy = self.k * self.y # .5 * k * (y/2)**2    
        
        self.conversion = .6    # 30% conversion of force on each increment
                                # how much force is able to be realized each increment of time
                                # (bcs we have no grounding in seconds or mass)
        self.mass = .01

        self.addediterations = 0    # the number of iterations that WERE added over given one to prevent overlap
        
        self.i = 0
        # start with 5 iterations
        while self.i < iterate:
            self.i += 1
            
            # for each object, calculate force applied to it
            # and then new position.
            
            # FORCE FROM SIDES
            for node in self.nodes:     
            
                
                # edges are springs
                # print node.label + ':: ' + str(node.x) + ' ' + str(node.y)
                node.fx -= self.k * (node.x)  # .5 * k * (node.x)**2        # pull up is a negative force
                node.fx += self.k * ((self.x-node.x))  # .5 * k * (x-node.x)**2 # opposing forces
                
                node.fy -= self.k * ((node.y)) # .5 * k * (node.y)**2       # pull left if a negative force
                node.fy += self.k * ((self.y-node.y)) # .5 * k * (y-node.y)**2  # opposing forces
                
#               node.fx += self.k / (node.x/(1 * self.x))**2  # .5 * k * (node.x)**2        # pull up is a negative force
#               node.fx -= self.k / ((self.x-node.x)/(1 * self.x))**2  # .5 * k * (x-node.x)**2 # opposing forces
                
#               node.fy += self.k / ((node.y)/(1 * self.y))**2 # .5 * k * (node.y)**2       # pull left if a negative force
#               node.fy -= self.k / ((self.y-node.y)/(1 * self.y))**2
                
                # attract endpoints to the top and bottom...
                # multiply by the number of nodes to scale stretching
                # * len(self.nodes) 
                nodedir = .75 * self.NodeDirection(node.name, node)
                # print node.name + ' ' + str(nodedir)
                if nodedir > 0:     # pull to the bottom
                    node.fy +=  nodedir * self.k * (self.y-node.y) # 
                elif nodedir < 0:       # pull to the top
                    node.fy += nodedir * self.k * node.y
                
                
                lastdistance = 0.0
                # force in open space -- open space attractors...
                # look for closest attractors surrounding node
                # A A A
                # A ij 0
                # A 0 A
                # ij, i+1, i-1,
                ai = int(node.x/(self.x/self.gridsize))
                aj = int(node.y/(self.y/self.gridsize))
                for i in [ai-2,ai-1,ai,ai+1,ai+2]:
                    if i < 0 or i >= self.gridsize: continue
                    for j in [aj-2, aj-1, aj, aj+1, aj+2]:
                        if j < 0 or j >= self.gridsize: continue
                        # skip this grid
                        if (i == ai) and (j == aj): continue

                # for i in range(self.gridsize):
                #   for j in range(self.gridsize):
                        
                        # skip zeroed grids, attractors are just a few..
                        if not (self.grid[i][j] > 0.0): continue
                        
                        # [x][y]
                        tx = (i*self.gridx)
                        ty = (j*self.gridy)
                        # scaled distance
                        distance = ( ((tx-node.x)/float(self.x))**2 + ((ty-node.y)/float(self.y))**2 ) **.5
                        
                        # skip further nodes, open space attractors only operate on closes ones.
                        # if (distance > lastdistance): continue
                        
                        # we attract the closest, with a scaled force, so if there is already a 
                        # object here in this grid, it is half as powerful
                        if (distance < (self.gridx/10)):
                            force = 0.0
                        else:
                            force = self.grid[i][j]/(distance**2)
                        
                        # what is the distance from this grid to the node
                        # what force from the grid to the node.
                        if self.gridy == node.y:
                            force_y = 0
                            force_x = force
                        elif self.gridx == node.x:
                            force_x = 0
                            force_y = force
                        else:
                            force_y = force / (1 + ((self.gridx - node.x)/(self.gridy - node.y))**2)
                            force_x = force - force_y

                        direction = -1
                        if i*self.gridx > node.x: direction = 1 # position of node is right of grid, create left (attract) force
                        node.fx += direction * force_x # k /(xdis**2)

                        direction = -1
                        if j*self.gridy > node.y: direction = 1
                        node.fy += direction * force_y          # k /(ydis**2)
                        
                        
                        last_distance = distance
                
                
                # reset the grid again
                self.grid = resize([float(self.k * 10)],(self.gridsize,self.gridsize))
                        
            
            # forces are X and Y
            # first compute the sum of forces from the outside edge
    
            # FORCE FROM EACH OTHER
            # then compute the sum of forces from the other objects
            # for each object
            for node1 in self.nodes:
                for node2 in self.nodes:
                    if (node1 == node2):
                        continue
                    
                    # repulsive force from each other; treat as two repelling charges
                    
                    # nodes are in the same place, give them full canvas-worth of force
                    # apart                     
                    # i.e., relative scale.
                    
                    # calculate distance between the two objects..
                    # print str((node1.x-node2.x)/float(x))
                    distance = ( ((node1.x-node2.x)/float(self.x))**2 + ((node1.y-node2.y)/float(self.y))**2 ) **.5

                    
                    # complete overlap, force apart in some way
                    if (int(node1.x) == int(node2.x)) and (int(node1.y) == int(node2.y)):
                        node1.fx += -1* self.canvas_fx/4
                        node2.fx += self.canvas_fx/4
                        node1.fy += -1 * self.canvas_fy/4
                        node2.fy += self.canvas_fy/4
                        
                    # allow close location nodes to "pass through" each other
                    elif (abs(node1.x - node2.x) < 0) or (abs(node1.y - node2.y) < 0):  

                        if abs(node1.x - node2.x) < 10:
                            node1.fx += 0
                            node2.fx += 0
                        
                        if abs(node1.y - node2.y) < 10:
                            node2.fy += 0
                            node1.fy += 0
                        
                    else:
                        
                        # dis_scale = distance/x
                        # print 'distance: ' + str(distance)
                        force = self.k/(distance**2)    # perhaps scaled distance at some point.. (to make a certain screen spacing)
                        
                        # cap the force so that it result so much jumping
                        # if force > (self.canvas_fx * .5):
                        #   force = self.canvas_fx * .5
                        
                        
                        # force components... x^2:y^2
                        # distance to force ratio is inverse, so x:y is actually the force
                        # contributions for x  ;  x/y*y + y = ft
                        if node1.y == node2.y:
                            force_y = 0
                            force_x = force
                        elif node1.x == node2.x:
                            force_x = 0
                            force_y = force
                        else:
                            force_y = force / (1 + ((node1.x - node2.x)/(node1.y - node2.y))**2)
                            force_x = force - force_y

                        # print 'ft:'+ str(force) + ' ' + str(force_x) + ' ' + str(force_y)

                        direction = 1
                        if node1.x < node2.x: direction = -1    # position of node 1 is left of node 2, subtract the force to create a leftward force
                        node1.fx += direction * force_x # k /(xdis**2)
                        node2.fx += -1 * direction * force_x # k /((xdis)**2)

                        direction = 1
                        if node1.y < node2.y: direction = -1
                        node1.fy += direction * force_y             # k /(ydis**2)
                        node2.fy += -1 * direction * force_y    # k /(ydis**2)
                    
                
                    # if the nodes are connected..
                    # then we give them a pulling spring force
                    if self.checkConnected(node1.name, node2.name):
                        # almost same equations for connected spring
                        # just different forces and directions
                        # we want this to have some grounding in actual sizes...
                        force = 10 * self.k * (.8+distance)**2 # k/(distance**2)    # perhaps scaled distance at some point.. (to make a certain screen spacing)
                        
                        
                        # force components... x^2:y^2
                        # distance to force ratio is inverse, so x:y is actually the force
                        # contributions for x  ;  x/y*y + y = ft
                        if (node1.y == node2.y): 
                            force_y = 0
                            force_x = force
                        elif (node1.x == node2.x): 
                            force_x = 0
                            force_y = force
                        else:
                            force_y = force / (1 + ((node1.x-node2.x)/(node1.y-node2.y))**2)
                            force_x = force - force_y


                        direction = 1
                        if node1.x > node2.x: direction = -1    # position of node 1 is left of node 2, subtract the force to create a leftward force
                        node1.fx += direction * force_x # k /(xdis**2)
                        node2.fx += -1 * direction * force_x # k /((xdis)**2)

                        direction = 1
                        if node1.y > node2.y: direction = -1
                        node1.fy += direction * force_y # k /(ydis**2)
                        node2.fy += -1 * direction * force_y # k /(ydis**2)
                        
            
            
            # FORCE FROM EDGE LABELS
            # we don't want the labels to be overlapped, so we want space for them.
            
            for edge1 in self.edges:
                for node in self.nodes:
                    distance = ( ((edge1.labelx-node.x)/float(self.x))**2 + ((edge1.labely-node.y)/float(self.y))**2 ) **.5
                    
                    
                    if (int(edge1.labelx) == int(node.x)) and (int(edge1.labely) == int(node.y)):
                        node.fx += -1* self.canvas_fx/10
                        node.fy += -1 * self.canvas_fy/10
                    else:
                        # dis_scale = distance/x
                        # labels put in 1/4 the force -- they just need to be pushed apart..
                        force = .25 * self.k/(distance**2)  # perhaps scaled distance at some point.. (to make a certain screen spacing)
                        
                        # cap the force so that it result so much jumping
                        if force > (self.canvas_fx):
                            force = self.canvas_fx
                        
                        
                        # force components... x^2:y^2
                        # distance to force ratio is inverse, so x:y is actually the force
                        # contributions for x  ;  x/y*y + y = ft
                        if edge1.labely == node.y:
                            force_y = 0
                            force_x = force
                        elif edge1.labelx == node.x:
                            force_x = 0
                            force_y = force
                        else:
                            force_y = force / (1 + ((edge1.labelx - node.x)/(edge1.labely - node.y))**2)
                            force_x = force - force_y
                    
                    
                        direction = 1
                        if edge1.labelx < node.x: direction = -1    # position of node 1 is left of node 2, subtract the force to create a leftward force
                        node.fx += -1 * direction * force_x # k /((xdis)**2)
                    
                        direction = 1
                        if edge1.labely < node.y: direction = -1
                        node.fy += -1 * direction * force_y     # k /(ydis**2)
                
                
                
                # edges are pushed apart.
                for edge2 in self.edges:
                    _a = 1
            
            
    
            # NEW POSITIONS
            # make new layout, using the force, determine the new position      
            # new positions of the points
            for node in self.nodes:
                # compute new position using the force potentials (and direction)
                # 400 = distance, 200 is balanced match 
                # F = .5 k 200^2
                # to convert the force to the distance we need to move,
                # w*(node.fx/canvas_fx)^(1/2) = d    # (2*F/k)
                # use direction to decide to add/subtract..
                # print 'F: ' + str(node.fx) + ' ' + str(node.fy)
                
                direction = 1
                if node.fx < 0: direction = -1
                # node.x += direction * self.conversion * (x/2)*(abs(node.fx/canvas_fx))**(.5)
                
                # f = f/world_force_distance as related to pixels.
                # a = f/m
                # d = 1/2 a t^2
                # cap the distance travelled to 20% of the window.
                xdis = .5 * ((node.fx/self.canvas_fx)/self.mass)*1  # each iteration is 1 second...
                if xdis > (self.x/5): xdis = self.x/5
                node.x += xdis
                
                direction = 1
                if node.fy < 0: direction = -1
                # node.y += direction * self.conversion * (y/2)*(abs(node.fy/canvas_fy))**(.5)
                ydis = .5 * ((node.fy/self.canvas_fy)/self.mass)*1  # each iteration is 1 second...
                if ydis > (self.y/5): ydis = self.y/5
                node.y += ydis
                
                # MARGIN PROTECTION
                # if the nodes are past the sides, do not allow past
                if (node.y < 20): node.y = 20 + random.randint(0,10)
                if (node.y > (self.y-20)): node.y = self.y - 20 - random.randint(0,10)
                if (node.x < 20): node.x = 20 + random.randint(0,10)
                if (node.x > (self.x-20)): node.x = self.x - 20 - random.randint(0,10)
                
                
                # update the frequency grid with the new pulling power.
                # EMPTY SPACE ATTRACTORS
                self.grid[int(node.x/(self.x/self.gridsize))][int(node.y/(self.y/self.gridsize))]/=4
                

                # CHECK IF ANY NODE IS WITHIN 10 of another - 
                # add an iteration, up to 5 iterations
                # but only if we are near the end of our iteration..
                if (self.i == iterate) and (self.addediterations < 0):
                    for node2 in self.nodes:
                        if self.i < iterate: continue
                        elif (node2.x > (node.x - 15)) and (node2.x < (node.x + 15)) and (node2.y > (node.y - 15)) and (node2.y < (node.y + 15)):
                            _a = 1
                            iterate += 1
                            self.addediterations += 1
                

                
                # after computing position, reset the forces
                node.fx = 0.0
                node.fy = 0.0
    
        
            # find new positions of the labels
            for edge in self.edges:
                self.updateLabelPos(edge)
                # we also want to remove the attractors where lines(edges) pass through..
                # so we get the midpoint
                # and the midpoint midponts (leaving 3 points)
                if edge.label:
                    self.grid[int(edge.labelx/(self.x/self.gridsize))][int(edge.labely/(self.y/self.gridsize))] = 0 # /=3
                
                

            
            # empty space attractors    
            # collect into a few empty space attractors, instead of a field
            for i in range(self.gridsize/2):
                for j in range(self.gridsize):
                    # divide the forward by two and add to this one
                    if (2*i+1) < self.gridsize:
                        self.grid[2*i+1][j]/=2
                        self.grid[2*i][j] += (self.grid[2*i+1][j])
                    
                    # add the reverse (already halved) to this one
                    if (2*i-1) >= 0:
                        self.grid[2*i][j] += (self.grid[2*i-1][j])
                        self.grid[2*i-1][j] = 0.0
                    
                    if (2*i+1) < self.gridsize:
                        self.grid[2*i+1][j] = 0.0
                    

            for i in range(self.gridsize):
                for j in range(self.gridsize/2):
                    # divide the forward by two and add to this one
                    if (2*j+1) < self.gridsize:
                        self.grid[i][2*j+1]/=2
                        self.grid[i][2*j] += (self.grid[i][2*j+1])
                    
                    # add the reverse (already halved) to this one
                    if (2*j-1) >= 0:
                        self.grid[i][2*j] += (self.grid[i][2*j-1])
                        self.grid[i][2*j-1] = 0.0
                    
                    if (2*j+1) < self.gridsize:
                        self.grid[i][2*j+1] = 0.0

        self.updated = 0
        
            

    def updateLabelPos(self,edge):
        # compute new edge positions
        # and edge label position
        nodefrom = self.getNodebyName(edge.fromname)
        nodeto = self.getNodebyName(edge.toname)
        
        # position of the label..
        if nodefrom and nodeto:
            labelxy = FindMidpoint(nodefrom.x,nodefrom.y,nodeto.x,nodeto.y)
            edge.labelx = labelxy[0]
            edge.labely = labelxy[1]
        

    
    def scaletoCanvas(self):
        # re-adjust the position to take up the entire canvas.
        # smallest and largest node x and y positions
        smallx = self.x # /2
        largex = 0 # self.x/2
        smally = self.y # /2
        largey = 0 # self.y/2
        
        for node in self.nodes:
            if node.x < smallx: smallx = node.x
            if node.y < smally: smally = node.y
            if node.x > largex: largex = node.x
            if node.y > largey: largey = node.y
            
        
        # left ship over all by smallest
        xshift = smallx
        yshift = smally
        
        xscale = .8 * self.x/(largex-smallx)
        yscale = .8 * self.y/(largey-smally)
        
#       print 'xs ' + str(xshift)
#       print 'ys ' + str(yshift)
#       print 'xscale ' + str(xscale)
#       print 'yscale ' + str(yscale)
        
        
        for node in self.nodes:
            node.y -= yshift
            node.x -= xshift
            
            node.x *= xscale
            node.y *= yscale

            # move over .5 of the 20% space
            node.y += .1 * self.y #yshift
            node.x += .1 * self.x #xshift
            
            
    
        # scale all by the difference
        
        
        # no re-adjust the positions...
        
        
        for edge in self.edges:
                self.updateLabelPos(edge)       
        

    
# find the midpoint between two points  
def FindMidpoint(x1,y1,x2,y2):
    opp = float(abs(x1-x2))
    adj = float(abs(y1-y2))
    linelength = float(((opp)**2 + (adj)**2)**.5)
    hyp = float(linelength)
                    
    if adj == 0.0:
        new_opp = float(linelength/2)
        new_adj = 0.0
                    
    elif opp == 0.0:
        new_adj = float(linelength/2)
        new_opp = 0.0
        
    else:
        # print "opp: " + str(opp)
        # print "adj: " + str(adj)
        tan_th = float(opp/adj)
        # print "tan_th: " + str(tan_th)
        sine_th = float(opp/hyp)
        newlength = float(linelength/2)
        new_opp = float(sine_th * newlength)
        new_adj = float(new_opp/tan_th)
    
    direction = -1
    if (x2 > x1): direction = 1
    newx = x1 + direction * new_opp
    
    direction = -1
    if (y2 > y1): direction = 1
    newy = y1 + direction * new_adj
    
    return [newx, newy]
    
