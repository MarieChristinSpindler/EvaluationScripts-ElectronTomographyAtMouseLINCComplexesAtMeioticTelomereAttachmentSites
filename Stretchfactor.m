% Requires distances.m output as "GefilterteFilemente"
for i=1:size(GefilterteFilamente,2)
    Filament=GefilterteFilamente{1, i};
    x1 = Filament{1,1};
    y1 = Filament{1,3};
    z1 = MaxZ - Filament{1,2};
    x2 = Filament{size(Filament,1),1};
    y2 = Filament{size(Filament,1),3};
    z2 = MaxZ - Filament{size(Filament,1),2};
    EuclidDistance = sqrt((x1-x2)^2 + (y1-y2)^2 + (z1-z2)^2);
    GefilterteFilamente{6, i} = EuclidDistance;
end