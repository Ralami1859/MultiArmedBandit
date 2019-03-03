function [Proba, successes, successes2] = GlobalS_UCB_Tuned_Resampling(Proba, successes, successes2, NbrPlayArm)
    [~, indiceMin] = min(Proba);
    successes(indiceMin,:) = [];
    successes2(indiceMin,:) = [];
    NbrPlayArm(indiceMin,:) = [];
    Proba(indiceMin) = [];
    
end
    
    