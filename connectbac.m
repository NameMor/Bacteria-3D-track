function tracks=connectbac(xyzf,micron_search_radius)

x=xyzf(:,1)'; y=xyzf(:,2)'; z=xyzf(:,3)';frame=xyzf(:,4)';

pixels_per_micron=1/5.3;
pixel_search_radius=micron_search_radius*pixels_per_micron;

baclabel=zeros(size(x)); 
i=min(frame); spanA=find(frame==i); 
baclabel(1:length(spanA))=1:length(spanA); 
lastlabel=length(spanA); 

for i=min(frame):max(frame)-1, % loop over all frame(i),frame(i+1) pairs.
    spanA=find(frame==i);
    spanB=find(frame==i+1);
    dx = ones(length(spanA),1)*x(spanB) - x(spanA)'*ones(1,length(spanB));
    dy = ones(length(spanA),1)*y(spanB) - y(spanA)'*ones(1,length(spanB));
    dz = ones(length(spanA),1)*z(spanB) - z(spanA)'*ones(1,length(spanB));
    dr2 = dx.^2+dy.^2+dz.^2; 
    dr2test=(dr2<pixel_search_radius^2); % dr2test=1 if beads A and B could be the same.
    
    from=find(sum(dr2test,2)==1); % connected to only ONE bead in next frame:  from(i) -> 1 bead
    to=find(sum(dr2test,1)==1)'; % connected from only ONE bead in previous frame: 1 bead -> to(i)
    [i,j]=find(dr2test(from,to)); % returns list of row,column indices of nonzero entries in good subset of correction
    from=from(i); to=to(j);  % translate list indices to row,column numbers.
    orphan=setdiff(1:size(dr2test,2),to); % anyone not pointed to is an orphan

    from=spanA(from); to=spanB(to); orphan=spanB(orphan); % translate to ABSOLUTE indices
    baclabel(to)=baclabel(from); % propagate labels of connected beads
    if length(orphan)>0, % there is at least one new (or ambiguous) bead 
        baclabel(orphan)=lastlabel+(1:length(orphan)); % assign new labels for new beads.
        lastlabel=lastlabel+length(orphan); % keep track of running total number of beads
    end;
end;

emptybac.x=0; emptybac.y=0; emptybac.z=0; emptybac.frame=0;
tracks(1:lastlabel)=deal(emptybac); % initialize for purposes of speed and memory management.
for i=1:lastlabel, % reassemble beadlabel into a structured array 'tracks' containing all info
    baci=find(baclabel==i);
    tracks(i).x=x(baci);
    tracks(i).y=y(baci);
    tracks(i).z=z(baci);
    tracks(i).frame=frame(baci);
end;
