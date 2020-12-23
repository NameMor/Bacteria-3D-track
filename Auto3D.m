clear
clc
cd D:\data\
File=dir('D:\data\*.avi');
% matlabpool 
pool=parpool;
for fnum=1:length(File)
    disp(['calculating video number ' num2str(fnum) '  ... ']);
    try
        movobj = VideoReader(['D:\desktop\data\1a\' File(fnum).name]);% read data from a movie
    catch
        continue
    end

FrameRate = movobj.FrameRate;
Magnification=20;%the magnification of the objective
pixels_per_micron=1/5.3;%1/(pixels size)

xyzf=calccoord(movobj,Magnification);%calculate the coordinates of bacteria
tracks=connectbac(xyzf,120);%connect the same bacteria's coordinates 

%prefilter the trace
xyzfnew=[];
for i=1:length(tracks)
    if length(tracks(i).x)>11
        tracks(i).x=sgolayfilt(tracks(i).x,1,11);
        tracks(i).y=sgolayfilt(tracks(i).y,1,11);
        tracks(i).z=sgolayfilt(tracks(i).z,1,11);
    end
    xyzfnew=[xyzfnew,cat(1,tracks(i).x,...
    tracks(i).y,tracks(i).z,tracks(i).frame)];
end

xyzfnew=xyzfnew';
tracks=connectbac(xyzfnew,80);%do connect again to connect traces belong to one bacteria as much as possible
    try
        TEMP=selectbacAlpha2(tracks,250,'N');%select the bacteria whose num of frame is longer than 250 
    catch
        save(movobj.Name(1:end-4),'xyzf','tracks','FrameRate','movobj');
        clearvars -except File fnum
        continue
    end
    
[dotproduct,velocity,normvelo,omega]=calcvelocity(TEMP,FrameRate);

save(movobj.Name(1:end-4),'xyzf','tracks','dotproduct','velocity','omega','normvelo','FrameRate','movobj');

clearvars -except File fnum
close all
    
end
% matlabpool close
delete(pool)

