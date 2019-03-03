function [res] = selectActionAllRunlengths(Proba, alphas, betas)
    
    Theta = [];
    
    for i = 1:size(alphas,2);
        Theta = [Theta Proba*betarnd(alphas(:,i),betas(:,i))];
    end
    [~, res] = max(Theta);
    
end