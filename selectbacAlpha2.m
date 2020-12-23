function TEMP=selectbacAlpha2(tracks,NumofFrames,YorN)
level2=2;
if length(NumofFrames)==1
    mark=0;
    for i=1:length(tracks)
        if length(tracks(i).x)>NumofFrames(1)
            mark=mark+1;
            TEMP(mark).x=dwt1DforTrack(tracks(i).x,level2);
            TEMP(mark).y=dwt1DforTrack(tracks(i).y,level2);
            TEMP(mark).z=dwt1DforTrack(tracks(i).z,level2);
            TEMP(mark).bac=i;
            len(mark)=length(tracks(i).x);
        end
    end

    if YorN=='Y'||YorN=='y'
        hTrace=figure;
        colors=prism(length(TEMP));
        for i=1:length(TEMP)
            plot3(TEMP(i).x,TEMP(i).y,TEMP(i).z,'-o','Color',colors(i,1:3)); hold on;
            text(TEMP(i).x(1),TEMP(i).y(1),TEMP(i).z(1),['tracks',(num2str(i))],'HorizontalAlignment','left')
        end
    end

    disp('    chosen one    length');
    disp([[TEMP.bac]',len'])
elseif length(NumofFrames)==2
    mark=0;
    for i=1:length(tracks)
        if length(tracks(i).x)>NumofFrames(1)&&length(tracks(i).x)<NumofFrames(2)
            mark=mark+1;
            TEMP(mark).x=dwt1DforTrack(tracks(i).x,level2);
            TEMP(mark).y=dwt1DforTrack(tracks(i).y,level2);
            TEMP(mark).z=dwt1DforTrack(tracks(i).z,level2);
            TEMP(mark).bac=i;
            len(mark)=length(tracks(i).x);
        end
    end

    if YorN=='Y'||YorN=='y'
        hTrace=figure;
        colors=prism(length(TEMP));
        for i=1:length(TEMP)
            plot3(TEMP(i).x,TEMP(i).y,TEMP(i).z,'-o','Color',colors(i,1:3)); hold on;
            text(TEMP(i).x(1),TEMP(i).y(1),TEMP(i).z(1),['tracks',(num2str(i))],'HorizontalAlignment','left')
        end
    end

    disp('    chosen one    length');
    disp([[TEMP.bac]',len'])
    
end