function [Proba, alphas, betas] = Resampling(Proba, alphas, betas)
    [threshold, indiceMin] = min(Proba);
%     indice = find(Proba > threshold);
%     alphas = alphas(indice,:);
%     betas = betas(indice,:);
%     Proba = Proba(indice);

    %    indice = find(Proba > threshold);
    alphas(indiceMin,:) = [];
    betas(indiceMin,:) = [];
    Proba(indiceMin) = [];
    %ValRunlength(indiceMin) = [];
end
    
    