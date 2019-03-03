function [Proba, alphas, betas] = GlobalS_BayesUCB_Resampling(Proba, alphas, betas)
    [~, indiceMin] = min(Proba);
    alphas(indiceMin,:) = [];
    betas(indiceMin,:) = [];
    Proba(indiceMin) = [];
    
end
    
   