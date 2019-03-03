function [successes, successes2, NbrPlayArm, gainGlobalS_UCB_Tuned] = GlobalS_UCB_Tuned_updateArmModel(successes, successes2,NbrPlayArm, action, reward, gainGlobalS_UCB_Tuned)
    
    if( (reward <0) + (reward > 1) ~= 0)
        error('reward must be between 0 and 1')
    end
    gainGlobalS_UCB_Tuned = [gainGlobalS_UCB_Tuned reward];
    if((reward == 0) + (reward == 1) == 0)
        reward = rand() < reward; % for non Bernoulli Distribution
    end
    
    successes(:,action) = successes(:,action) + reward;
    successes2(:,action) = successes2(:,action) + reward;
    NbrPlayArm(:,action) = NbrPlayArm(:,action) + 1;
   
    successes = [0.5*ones(1,size(successes,2)); successes];
    successes2 = [0.25*ones(1,size(successes2,2)); successes2];
    NbrPlayArm = [ones(1,size(NbrPlayArm,2)); NbrPlayArm];
end