function [successes, NbrPlayArm, gainGlobalS_UCB1] = GlobalS_UCB1_updateArmModel(successes, NbrPlayArm, action, reward, gainGlobalS_UCB1)
    
    if( (reward <0) + (reward > 1) ~= 0)
        error('reward must be between 0 and 1')
    end
    gainGlobalS_UCB1 = [gainGlobalS_UCB1 reward];
    if((reward == 0) + (reward == 1) == 0)
        reward = rand() < reward; % for non Bernoulli Distribution
    end
    
    successes(:,action) = successes(:,action) + reward;

    NbrPlayArm(:,action) = NbrPlayArm(:,action) + 1;
   
    successes = [0.5*ones(1,size(successes,2)); successes];
    NbrPlayArm = [ones(1,size(NbrPlayArm,2)); NbrPlayArm];
end
    