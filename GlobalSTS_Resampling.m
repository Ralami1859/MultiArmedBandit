%% Discarding the worst expert.

function [Expert_Distribution, alphas, betas] = GlobalSTS_Resampling(Expert_Distribution, alphas, betas)
    [~, indiceMin] = min(Expert_Distribution);
    alphas(indiceMin,:) = [];
    betas(indiceMin,:) = [];
    Expert_Distribution(indiceMin) = [];
    
end
    
    