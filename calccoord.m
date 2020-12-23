function xyzf=calccoord(movobj,Magnification)

    nframes = movobj.NumberOfFrames;
    xyrf=[];
%     movobjT = VideoReader([movobj.Path '\' movobj.Name]);
% matlabpool
parfor index=1:nframes
    im=read(movobj,index);
    im=im(:,:,1);
    I=imadjust(im);

    background=imopen(I,strel('disk',45));
    J=I-background;

    L=wiener2(J,[5 5]);
    
    warning off
    
    
    bw=im2bw(L,0.25);
    bw1=imfill(bw,'holes');
    bw2=bwareaopen(bw1,200,8);
    [centers1,radii1]=imfindcircles(bw2,[110 160],'Sensitivity',0.98);

    bw=im2bw(L,0.3);
    bw1=imfill(bw,'holes');
    bw2=bwareaopen(bw1,200,8);
        
    [centers2,radii2]=imfindcircles(bw2,[60 110],'Sensitivity',0.96);
    
    bw=im2bw(L,0.35);
    bw1=imfill(bw,'holes');
    bw2=bwareaopen(bw1,200,8);
    
    [centers3,radii3]=imfindcircles(bw2,[15,60],'Sensitivity',0.85);

    centers=cat(1,centers1,centers2,centers3); radii=cat(1,radii1,radii2,radii3);
    
    frames=zeros(length(radii),1);
    if ~isempty(centers)
        [frames(1:length(frames))]=index;
        xyrf=[xyrf;cat(2,centers,radii,frames)];
    end
end
% matlabpool close
xyzf=xyrf;
xyzf(:,3)=(xyzf(:,3)*0.8137-1.637)*Magnification/5.3;%% the calibration curve


