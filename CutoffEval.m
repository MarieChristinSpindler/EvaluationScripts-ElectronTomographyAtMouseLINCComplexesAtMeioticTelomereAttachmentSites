% Requires MODEL2POINT output as "Points"
% Requires distances.m output as "GefilterteFilamente"

MicrotubuleStart=2700000;
while Points{MicrotubuleStart,1} ~= 7
    MicrotubuleStart=MicrotubuleStart+1;
end
MicrotubuleEnd=size(Points,1);
Microtubule={};
Microtubule=Points(MicrotubuleStart:MicrotubuleEnd,3:5);


for l=1:size(GefilterteFilamente,2)
    Filament=GefilterteFilamente{1, l};
    Bodenpunkt=GefilterteFilamente(3,l);
    Bodenpunkt=Bodenpunkt{1,1};
    Firstpoint=Filament(1,1:3);
    LastPoint=Filament(size(Filament,1),1:3);
    FirstPointDistance=sqrt((Firstpoint{1,1}-Bodenpunkt{1,1})^2 + (Firstpoint{1,2}-Bodenpunkt{1,2})^2 + (Firstpoint{1,3}-Bodenpunkt{1,3})^2);
    LastPointDistance=sqrt((LastPoint{1,1}-Bodenpunkt{1,1})^2 + (LastPoint{1,2}-Bodenpunkt{1,2})^2 + (LastPoint{1,3}-Bodenpunkt{1,3})^2);
    if (FirstPointDistance>LastPointDistance)
        GefilterteFilamente{7,l} = LastPoint;
    else 
        GefilterteFilamente{7,l} = Firstpoint;
    end
end

for l=1:size(GefilterteFilamente,2)
    TopPunkt=GefilterteFilamente{7, l};
    currentMinDistance=1000000;
    for j=1:size(Microtubule,1)
        x1=TopPunkt{1,1};
        y1=TopPunkt{1,3};
        z1=MaxZ - TopPunkt{1,2};
        x2=Microtubule{j,1};
        y2=Microtubule{j,3};
        z2=MaxZ - Microtubule{j,2};
        EuclidDistance = sqrt((x1-x2)^2 + (y1-y2)^2 + (z1-z2)^2);
        if EuclidDistance<currentMinDistance
           currentMinDistance=EuclidDistance;
        end
    end
    GefilterteFilamente{8,l}=currentMinDistance;
end

numberOfClose = 0;
numberOfFar = 0;
sumOfClose = 0;
sumOfFar= 0;
Close = [];
Far = [];
for l=1:size(GefilterteFilamente,2)
    if (GefilterteFilamente{8,l} > cutoff)
       numberOfFar = numberOfFar + 1;
       sumOfFar = sumOfFar + GefilterteFilamente{6,l};
       Far = [Far, GefilterteFilamente{6,l}];
    else
       numberOfClose = numberOfClose + 1;
       sumOfClose = sumOfClose + GefilterteFilamente{6,l};
       Close = [Close, GefilterteFilamente{6,l}];
    end
end
res = sumOfClose/numberOfClose - sumOfFar/numberOfFar
