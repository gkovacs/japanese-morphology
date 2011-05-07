# // --------------------------------------- //
"""
PyGraph is a collection of routines to do some
basic directed graph rendering in pure python.

It is somewhat similar to the Dot & GraphViz 
modules, but without requiring them (or external source)
to be installed.  

It isn't fast, but it *is* portable...

tkgraphview takes care of drawing edges and placing names/etc
	allowing drag/drop, etc.
	
pygraph class renders & places nodes according to different
	models: spring and heirarchical are supported.


(c) Beracah Yankama, 2004-2007

This is NOT GPL code!
"""
# // --------------------------------------- //

import Tkinter, tkFileDialog

from pygraph import *



class tkGraphView(object):
    # Global identifiers for Application Status
    __AS_CREATE = 1
    __AS_MOVE = 2
    __AS_RESIZE = 3

    # Global identifiers for Dragging Status
    __DS_NODRAG = 1
    __DS_DRAGGING = 2
    
    # nodeEdgeAry is an old-style hack container that we use.  You can see it parsed into the new
    	# node and edge objects below
    # title = window title string
    # outfile = basename of output.ps file == i.e. "myfile" becomes "myfile.ps"
    # root = window/frame for the graph to appear in.  If none, then it assumes a toplevel window
    	# if this graph is the only tk running, then 'onlyroot' must be set to True
    # graphtype = type of graph, valid options: 'directed' and 'spring';  spring is good for undirected/cyclic graphs
    	# whereas directed is good for heirarchical type graphs.
    # startTk = True if the grapher is the only instance of tk running -- will then start up
    	# tk.mainloop on its own.
    
    def __init__(self, nodeEdgeAry, title, outfile='',root=None, graphtype='directed',startTk=False):
        if root is None:	# don't have a window to place in.
        	if startTk:		# there is no tk instance running
        		self._root = Tkinter.Tk()
        	else:					# there is a tk instance running, place new window
        		self._root = Tkinter.Toplevel() # (use this one when in main prog)
        else: self._root = root
        
        self.dragmode = self.__DS_NODRAG
        self.imagefile = outfile
        
        self.selected = ''
        
        self.tagNodeMap = {}
        self.nodeTagMap = {}
        self.tagPos = {}    # totally a hack to get the position.

        self.highlightTags = []
        
        # add a "save" button
        Tkinter.Button(self._root, text='Save diagram...',
                           background='#a0f0c0', foreground='black', 
                           command=self.writeImage).pack(side='bottom')
                           
        #Tkinter.Label(self._root, text='( '+self.imagefile+'.ps )').pack(side='top')

        
        # choose canvas sizing..
        # ok, we want to check the number of nodes to estimate the size of graph we should make
        # if each node gets 75x75 pixels of area...  then 50% of the area goes unused in rendering...
        if False:
            self.totalarea = 10000 * len(nodeEdgeAry) * 2
            self.xdim = self.totalarea ** .5
            self.ydim = self.xdim   # square area for now...
            if (self.ydim > 600):
                areadiff = self.xdim * (self.ydim-600)
                self.ydim = 600
                self.xdim += areadiff/600
            
            # enforce a max size
            if (self.xdim > 600):
                self.xdim = 600
        
        self.xdim = 500
        self.ydim = 500
        
        self.canvas = Tkinter.Canvas(self._root, height=self.ydim, width=self.xdim, background='white')
        self.canvas.pack()

        # write "loading"
        # draw some test stuff.
        # self.canvas.create_oval(200,200,300,300)
        # we actually want to draw all the nodes on the graph here...
        # so we create a rendering object
        self.graph = Grapher(graphtype,self.canvas)
        
        """
        self.graph.addNode('1')
        self.graph.addNode(2,'hey there','','rect')
        self.graph.addNode(3)
        self.graph.addNode(4)
        self.graph.addNode(5)
        self.graph.addNode(6)
        self.graph.addNode(7)
        self.graph.addNode(8)
        self.graph.addNode(9)
        self.graph.addNode(10)
        self.graph.addEdge(1,2)
        self.graph.addEdge(3,4)
        self.graph.addEdge(1,4)
        self.graph.addEdge(4,6)
        """
        

        # integrate the old format edge array
        if isinstance(nodeEdgeAry, Grapher):
            self.graph = nodeEdgeAry
            self.graph.setCanvas(self.canvas)
        else:
            for x in nodeEdgeAry:
                if x['node'] == 'Begin': 
                    self.graph.addNode(x['node'],x['node'],'lightblue','rect','start')
                elif x['node'] == 'End': 
                    self.graph.addNode(x['node'],x['node'],'Light Coral','rect','end')
                elif x['node']:
                    self.graph.addNode(x['node'],x['node'],x['color'],x['shape'])
                
                for e in range(len(x['edges'])):
                    tmpedgename = ''
                    if e < len(x['edgenames']): tmpedgename = x['edgenames'][e]
                    
                    #print str(x['node']) + ' ' + str(x['edges'][e]) + ' ' + str(tmpedgename)
                    
                    self.graph.addEdge(x['node'], x['edges'][e], tmpedgename)
        
        
        self.graph.intelligentRandomize()
        
        # just here to watch the bodies behave...
        if graphtype=='directed':
            self.graph.layout(self.canvas,'',1)

        else:
            for i in range(35):
                self.graph.layout(self.canvas,'spring',1)
                self.draw()
                self.canvas.update()

        # scale it and redraw
        self.graph.scaletoCanvas()
        self.draw()

        # write to file
        #self.writeImage()
        
        

        # setup window handlers
        # allow to destroy
        # self._root.protocol("WM_DELETE_WINDOW", self.destroy)
        # self._root.bind("<Destroy>", self.destroy)
        
        # setup the dragable nature
        self.canvas.bind("<Button-1>", self.OnCanvasClicked)
        self.canvas.bind("<B1-Motion>", self.OnCanvasMouseDrag)
        self.canvas.bind("<ButtonRelease-1>", self.OnCanvasMouseUp)
        # self.canvas.bind("<Button-3>", self.OnCanvasB3Clicked)
        
        self.dragmode = self.__DS_DRAGGING
        
        if startTk:	# no window was defined, 
        	self._root.mainloop()
        
        
    
    def writeImage(self):
        import Tkinter,tkFileDialog
        if not self.imagefile: return

        myFormats = [('Postscript image','*.ps')]

        fileName = tkFileDialog.asksaveasfilename(parent=self._root,filetypes=myFormats, title="Save as...", initialfile=self.imagefile+'.ps')
        if len(fileName) > 0:
            # 75 dpi
            self.canvas.postscript(file=fileName, width=self.xdim, height=self.ydim, pagewidth=self.xdim,pageheight=self.ydim)
        
        # run system command to conver to .png
        
            
    
        
    def destroy(self):
        # print "destroy"
        if self._root:
            self._root.destroy()

        self._root = None
        self.canvas = None
        self.graph.destroy()
        self.graph = None
        

    def OnCanvasMouseUp(self, event):
        self.selected = ''
        self.clickx = 0.0
        self.clicky = 0.0
        self.draw()
    
    
    def OnCanvasClicked(self,event):
        self.clickx = self.canvas.canvasx(event.x)
        self.clicky = self.canvas.canvasx(event.y)
        self.selected = ''
        
        # there are only specific kinds that can be selected...
        neartags = self.canvas.find_overlapping(self.clickx-20, self.clicky-20, self.clickx+20, self.clicky+20) # find_closest(self.clickx, self.clicky)
        # print neartags
        for tag in neartags:
            if self.selected: continue
            if self.tagNodeMap.has_key(tag):
                self.selected = tag
        
        if self.selected:
            # reposition center to mouse cursor
            pos = self.tagPos[self.selected]
                
            dx = event.x - pos[0]
            dy = event.y - pos[1]

            self.tagNodeMap[self.selected].x = event.x
            self.tagNodeMap[self.selected].y = event.y

            self.canvas.move(self.selected,dx,dy)
            self.tagPos[self.selected] = [event.x, event.y]

            # just for testing hight funcs
            # self.HighlightNode('',self.tagNodeMap[self.selected])

            
        else:
            self.selected = ''
            self.clickx = 0.0
            self.clicky = 0.0
            

      
    
    def OnCanvasMouseDrag(self,event):
        if not self.selected: return
        
        if (self.canvas.find_withtag(self.selected)):
            dx = event.x - self.clickx
            dy = event.y - self.clicky
            self.canvas.move(self.selected, dx, dy);
            self.clickx = event.x
            self.clicky = event.y
                        
            self.tagNodeMap[self.selected].x = event.x
            self.tagNodeMap[self.selected].y = event.y

            # keep the current position up to date.
            self.tagPos[self.selected] = [event.x, event.y]
            self.draw()
            
        else:
            self.selected = ''
            self.clickx = 0.0
            self.clicky = 0.0
            self.canvas.coords(self.selected, self.clickx, self.clicky, event.x, event.y)



    def draw(self):
        # remove all non-node objects from screen
        for tag in self.canvas.find_all():
            if not self.tagNodeMap.has_key(tag):
                self.canvas.delete(tag)
        
        
        # draw the edges first, now that they have been rendered so that the
        # nodes overwrite them on the screen.
        for edge in self.graph.edges:
            nodefrom = self.graph.getNodebyName(edge.fromname)  # inefficient, do this on adding edges.
            nodeto = self.graph.getNodebyName(edge.toname)  # inefficient, do this on adding edges.
            
            # prune if either is not found, 
            if (nodefrom and nodeto) :
                # make the arrows visible...
                
                self.opp = float(abs(nodefrom.x-nodeto.x))
                self.adj = float(abs(nodefrom.y-nodeto.y))
                self.linelength = ((self.opp)**2 + (self.adj)**2)**.5
                self.hyp = float(self.linelength)
                
                # linelength depends on the width of the end node
                endwidth = 10 + 5 * (len(nodeto.name)-1)
                endheight = 10
                
                if self.adj == 0.0:
                    self.new_opp = float(self.linelength - endwidth)
                    self.new_adj = 0.0
                
                elif self.opp == 0.0:
                    self.new_adj = float(self.linelength - endheight)
                    self.new_opp = 0.0
                    
                else:
                    self.tan_th = float(self.opp/self.adj)
                    self.sine_th = float(self.opp/self.hyp)
                    self.cos_th = float(self.adj/self.hyp)
                    sin_rad = math.asin(self.sine_th)/(.5*3.142)
                    diff = (endwidth - endheight) * (sin_rad**4) + endheight
                    self.newlength = float(self.linelength - diff)
                    self.new_opp = self.sine_th * self.newlength
                    self.new_adj = self.new_opp/self.tan_th
                    
                    
                
                
                # create a curve to the lines...
                xshift = 0
                yshift = 0
                xshift2 = 0
                
                labelshiftx = 0
                labelshifty = 0
                
                if edge.label:
                    if nodeto.y > nodefrom.y:
                        xshift = 20
                    if nodeto.y < nodefrom.y:
                        xshift = -20
                    if nodeto.x > nodefrom.x:
                        yshift = -20
                    if nodeto.x < nodefrom.x:
                        yshift = 20


                    labelshiftx = xshift
                    labelshifty = yshift
                                
                if nodeto == nodefrom:
                    xshift = .05*self.xdim 
                    yshift = 0
                    xshift2 = .05*self.xdim 
                    yshift2 = .05*self.ydim 
                    xshift3 =  0
                    yshift3 =  .05*self.ydim 
                    
                    labelshiftx = .05*self.xdim
                    labelshifty = .05*self.ydim

                points = [nodefrom.x,nodefrom.y]

                midshift = FindMidpoint(nodefrom.x+xshift,nodefrom.y+yshift,nodeto.x+xshift,nodeto.y+yshift)
                
                if (xshift2):
                    points.append(nodefrom.x+xshift)
                    points.append(nodefrom.y+yshift)
                    
                    points.append(nodefrom.x+xshift2)
                    points.append(nodefrom.y+yshift2)
                    
                    points.append(nodefrom.x+xshift3)
                    points.append(nodefrom.y+yshift3)
                else:

                    points.append(midshift[0])
                    points.append(midshift[1])


                    
                
                self.direction = -1
                if (nodeto.x > nodefrom.x): self.direction = 1
                self.newx = nodefrom.x + self.direction * self.new_opp
                
                self.direction = -1
                if (nodeto.y > nodefrom.y): self.direction = 1
                self.newy = nodefrom.y + self.direction * self.new_adj

                points.append(self.newx)
                points.append(self.newy)

                self.canvas.create_line(points, arrow='last', smooth='true')
                # self.canvas.create_line([nodefrom.x,nodefrom.y, midshift[0],midshift[1], self.newx,self.newy], arrow='last', smooth='true')

                # add label
                if edge.label:
                    self.graph.updateLabelPos(edge) # we always make sure the label is updated..
                    self.canvas.create_text(edge.labelx+labelshiftx, edge.labely+labelshifty, text=edge.label, fill='black',anchor=Tkinter.NW)
        
        
        # draw the nodes now that they have been lay'ed out.
        for node in self.graph.nodes:
            tmpwidth = 10
            # add 10 for every letter of label..
            tmpwidth += 5 * (len(node.name)-1)
            
            # if this node is already being altered...
            
            if self.selected:
                if self.nodeTagMap.has_key(self.selected):
                    if node == self.nodeTagMap[self.selected]:
                        continue
            
            # check if this node is already in tmpnodes
            # just update the position
            if self.nodeTagMap.has_key(node): 
                tag = self.nodeTagMap[node]

                pos = self.tagPos[tag]
                
                dx = node.x-pos[0]
                dy = node.y-pos[1]
                
                
                self.canvas.move(tag,dx,dy)
                self.tagPos[tag] = [node.x,node.y]

                # stay on top
                self.canvas.lift(tag)

            # create the objects from new           
            else:
                
                if node.shape == 'rect':
                    tag = self.canvas.create_rectangle(node.x-tmpwidth,node.y-10,node.x+tmpwidth,node.y+10, fill=node.color)
                else:
                    tag = self.canvas.create_oval(node.x-tmpwidth,node.y-10,node.x+tmpwidth,node.y+10, fill=node.color)
                
                # add the tag to the node map
                self.tagNodeMap[tag] = node
                self.nodeTagMap[node] = tag
                self.tagPos[tag] = [node.x,node.y]

            
            # name the node
            self.canvas.create_text(node.x,node.y, text=node.label)

        
        # write in the strength of the attractors
#       for i in range(self.graph.gridsize):
#           for j in range(self.graph.gridsize):
#               self.canvas.create_text( i*self.graph.gridx  , j*self.graph.gridy, text=self.graph.grid[i][j])

    def HighlightNode(self,nodename,node_in):
        if not node_in:
            node = self.graph.getNodebyName(nodename)
        else:
            node = node_in
        
        # get the node position
        if node:
            # hack for node width, make dedicated functions/etc.
            tmpwidth = 10 + 5 * (len(node.name)-1)
            
            tag = self.canvas.create_oval(node.x-tmpwidth-3,node.y-13,node.x+tmpwidth+3,node.y+13, outline='orange', fill='yellow', width=2)
            self.canvas.lower(tag)
            
            self.highlightTags.append(tag)
        
        # add another shape behind this one.
        
        
        
    def deHighlightNodes(self):
        for tag in self.highlightTags:
            self.canvas.delete(tag)
        self.highlightTags = []

