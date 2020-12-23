warning off
n=input('please input the number of the bac: ');
r=[];z=[];

bacnum = TEMP(n).bac;
j=0;figure;
for i=min(tracks(bacnum).frame):max(tracks(bacnum).frame)
    j=j+1;
    im=read(movobj,i);
    imshow(im); viscircles([TEMP(n).x(j),TEMP(n).y(j)],(TEMP(n).z(j)*5.3/20/0.8137));

end


