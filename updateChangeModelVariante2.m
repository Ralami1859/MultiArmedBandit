function [Proba] = updateChangeModelVariante2(Proba,alphas,betas,action,reward,gamma)
    likelihood = [];
    if(reward == 1)
        for i=1:length(Proba);
            likelihood = [likelihood betarnd(alphas(i,action),betas(i,action))];
        end
    else
        for i=1:length(Proba);
            likelihood = [likelihood betarnd(alphas(i,action),betas(i,action))];
        end
    end
    Proba0 = gamma*sum(likelihood.*Proba);
    Proba = (1-gamma).*likelihood.*Proba;
    Proba = [Proba0  Proba];
    Proba = Proba/sum(Proba);
end