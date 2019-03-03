function [ArmToPlay, Theta] = GlobalS_BayesUCB_RecommendArm(Proba, alphas, betas, gamma, t, Horizon)
    
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
    NewHorizon = 1/gamma*(floor(BestProba.*gamma)+1);
    for i = 1:size(alphas,2);
        Theta = [Theta betainv(1 - 1./(BestProba.*log(NewHorizon)),alphas(BestProba,i), betas(BestProba,i))];
        %Theta = [Theta betainv(alphas(BestProba,i), betas(BestProba,i),1 - 1./(t.*log(Horizon)))];
    end
    [~, ArmToPlay] = max(Theta);
    
end