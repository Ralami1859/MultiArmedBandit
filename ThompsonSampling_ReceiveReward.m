function [alphas, betas, gainThompsonSampling]= ThompsonSampling_ReceiveReward(alphas, betas, reward, ArmChosen, gainThompsonSampling)
    if( (reward <0) + (reward > 1) ~= 0)
        error('reward must be between 0 and 1')
    end
    gainThompsonSampling = [gainThompsonSampling reward];
    if((reward == 0) + (reward == 1) == 0)
        reward = rand() < reward; % for non Bernoulli Distribution
    end
    alphas(ArmChosen) = alphas(ArmChosen) + (reward == 1);
    betas(ArmChosen) = betas(ArmChosen) + (reward == 0);
end