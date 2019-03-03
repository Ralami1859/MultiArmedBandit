%% Arm recommended by Global STS with Beyasian Aggregation

function [ArmToPlay] = GlobalSTS_BA_RecommendArm(Expert_distribution, alphas, betas)
    
    Theta = [];
    
    for i = 1:size(alphas,2);
        Theta = [Theta Expert_distribution*betarnd(alphas(:,i),betas(:,i))]; % Sampling the Beta distributions
    end
    [~, ArmToPlay] = max(Theta);
    
end