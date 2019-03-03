%% Arm recommended by Global STS with Beyasian Aggregation


function [ArmToPlay, BestProba] = GlobalSTS_RecommendArm(Expert_Distribution, alphas, betas)
    
%% Sampling the expert distributions
    Expert_Distribution = cumsum(Expert_Distribution);
    u = rand();
    a = Expert_Distribution > u;
    a = find(a == 1);
    
    if(isempty(a))
        BestProba = 1;  %expert sampled
    else
        BestProba = a(1); % expert sampled
    end

    Theta = [];
    
 %%  Using the expert sampled form the expert distribution
    for i = 1:size(alphas,2);
        Theta = [Theta betarnd(alphas(BestProba,i),betas(BestProba,i))]; 
    end
    [~, ArmToPlay] = max(Theta);
    
end