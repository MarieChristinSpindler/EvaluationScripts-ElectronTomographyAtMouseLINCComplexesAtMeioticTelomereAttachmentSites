% Requires MODEL2POINT output as "input"
LilaAnfang=1;
while input{LilaAnfang,1} ~= 3
    LilaAnfang=LilaAnfang+1;
end

LilaEnde=1;
while input{LilaEnde,1} ~= 4
    LilaEnde=LilaEnde+1;
end
LilaEnde = LilaEnde -1;

Lila=input(LilaAnfang:LilaEnde, 1:5);

INManfang=1;
while input{INManfang,1} ~= 6
    INManfang=INManfang+1;
end

[Zeilen,Spalten]=size(input);
alleFilamente=input(INManfang:Zeilen,1:5);

Filamentbeginn=1;
aktuelleFilamentnummer=1;
Speicherort=1;
Filamente={};

for i=1:size(alleFilamente,1)
    if aktuelleFilamentnummer~=alleFilamente{i,2}
        Filamente{Speicherort}=alleFilamente(Filamentbeginn:i-1,3:5);
        aktuelleFilamentnummer=alleFilamente{i,2};
        Filamentbeginn=i;
        Speicherort=Speicherort+1;
    end
end
Filamente{Speicherort}=alleFilamente(Filamentbeginn:size(alleFilamente,1),3:5);

GefilterteFilamente={};
Speicherort=1;
for i=1:size(Filamente ,2)
    if size(Filamente{i},1)>=10
        GefilterteFilamente{Speicherort}=Filamente{i};
        Speicherort = Speicherort+1;
    end
end

for l=1:size(GefilterteFilamente,2)
    FilamentA=GefilterteFilamente{1, l};
    NearestNeighbourDistance=1000000;
    for k=1:size(GefilterteFilamente,2)
        if k ~= l
            FilamentB=GefilterteFilamente{1, k};
            currentMinDistance=1000000;

            for i=1:size(FilamentA,1)
                for j=1:size(FilamentB,1)
                    x1=FilamentA{i,1};
                    y1=FilamentA{i,3};
                    z1=MaxZ - FilamentA{i,2};
                    x2=FilamentB{j,1};
                    y2=FilamentB{j,3};
                    z2=MaxZ - FilamentB{j,2};
                    EuclidDistance = sqrt((x1-x2)^2 + (y1-y2)^2 + (z1-z2)^2);
                    if EuclidDistance<currentMinDistance
                       currentMinDistance=EuclidDistance;
                    end
                end
            end

            if currentMinDistance<NearestNeighbourDistance
                NearestNeighbourDistance=currentMinDistance;
            end
        end
    end 
    GefilterteFilamente{2,l}=NearestNeighbourDistance;
end

INManfang=1;
while input{INManfang,1} ~= 2
    INManfang=INManfang+1;
end

INMende=1;
while input{INMende,1} ~= 3
    INMende=INMende+1;
end
INM=input(INManfang:(INMende-1),1:5);

 
for l=1:size(GefilterteFilamente,2)
    FilamentA=GefilterteFilamente{1, l};
    currentMinDistance=1000000;
    closestPoint2membrane={};
    for i=1:size(FilamentA,1)
                    for j=1:size(INM,1)
                        x1=FilamentA{i,1};
                        y1=FilamentA{i,3};
                        z1=MaxZ - FilamentA{i,2};
                        x2=INM{j,3};
                        y2=INM{j,5};
                        z2=MaxZ - INM{j,4};
                        EuclidDistance = sqrt((x1-x2)^2 + (y1-y2)^2 + (z1-z2)^2);
                        if EuclidDistance<currentMinDistance
                           currentMinDistance=EuclidDistance;
                           closestPoint2membrane=FilamentA(i,1:3);
                        end
                    end
    end
    GefilterteFilamente{3,l}=closestPoint2membrane;
end

for i=1:size(GefilterteFilamente,2)
    BodenpunktA=GefilterteFilamente(3,i);
    currentMinDistance=1000000;
    x1=BodenpunktA{1,1}{1,1};
    y1=BodenpunktA{1,1}{1,3};
    z1=MaxZ - BodenpunktA{1,1}{1,2};
    for j=1:size(GefilterteFilamente,2)
        if i~= j
            BodenpunktB=GefilterteFilamente(3,j);
            x2=BodenpunktB{1,1}{1,1};
            y2=BodenpunktB{1,1}{1,3};
            z2=MaxZ - BodenpunktB{1,1}{1,2};
            EuclidDistance = sqrt((x1-x2)^2 + (y1-y2)^2 + (z1-z2)^2);
            if EuclidDistance<currentMinDistance
                currentMinDistance=EuclidDistance;
            end
        end

    end
    GefilterteFilamente{4,i}=currentMinDistance;
end

for i=1:size(GefilterteFilamente,2)
    Bodenpunkt=GefilterteFilamente(3,i);
    x1=Bodenpunkt{1,1}{1,1};
    y1=Bodenpunkt{1,1}{1,3};
    z1=MaxZ - Bodenpunkt{1,1}{1,2};
    currentMinDistance=1000000;
    currentContourNumber=-1;
    for j=1:size(Lila,1)
        x2=Lila{j,3};
        y2=Lila{j,5};
        z2=MaxZ - Lila{j,4};
        EuclidDistance = sqrt((x1-x2)^2 + (y1-y2)^2 + (z1-z2)^2);
        if EuclidDistance<currentMinDistance
            currentMinDistance=EuclidDistance;
            currentContourNumber = Lila{j, 2};
        end
    end
    GefilterteFilamente{5,i}=currentContourNumber;
end
