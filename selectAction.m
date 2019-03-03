function [res, BestProba] = selectAction(Proba, alphas, betas)
    
    Proba = cumsum(Proba);
    u = rand();
    a = Proba > u;
    a = find(a == 1);
    
    if(isempty(a))
        BestProba = 1;
    else
        BestProba = a(1);
    end

    Theta = [];
    
    for i = 1:size(alphas,2);
        Theta = [Theta betarnd(alphas(BestProba,i),betas(BestProba,i))];
    end
    [a, res] = max(Theta);
    
end