function [ExpectedMeans, NbrPlayArm, gainUCB]= UCB1_Initialize(FirstRewards)
    gainUCB = FirstRewards;
    ExpectedMeans = FirstRewards;
    for n = 1:length(FirstRewards)
        if( (FirstRewards(n) >1) + (FirstRewards(n)<0) ~=0)
            error('Rewards must be between 0 and 1');
        end
    end
    NbrPlayArm = ones(1,length(FirstRewards));
end