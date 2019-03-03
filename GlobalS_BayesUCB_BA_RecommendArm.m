function [ArmToPlay, Theta] = GlobalS_BayesUCB_BA_RecommendArm(Proba, alphas, betas, gamma, t, Horizon)
    
    Theta = [];
    Time = [1:length(Proba)];
    for i = 1:size(alphas,2);
        NewHorizon = 1/gamma*(floor(Time.*gamma)+1);
        
        q = Proba*betainv((1 - 1./(Time.*log(NewHorizon)))',alphas(:,i), betas(:,i));
        Theta = [Theta q];
    end
    [~, ArmToPlay] = max(Theta);
    
end