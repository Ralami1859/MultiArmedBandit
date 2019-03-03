function [Proba] = GlobalS_UCB1_updateChangeModel(Proba,successes,NbrPlayArm,action,reward,gamma)
    if( (reward <0) + (reward > 1) ~= 0)
        error('reward must be between 0 and 1')
    end
    if((reward == 0) + (reward == 1) == 0)
        reward = rand() < reward; % for non Bernoulli Distribution
    end

    likelihood = [];
    if(reward == 1)
        for i=1:length(Proba);
            likelihood = [likelihood successes(i,action)/NbrPlayArm(i,action)];
        end
    else
        for i=1:length(Proba);
            likelihood = [likelihood 1-successes(i,action)/NbrPlayArm(i,action)];
        end
    end
    Proba0 = gamma*sum(likelihood.*Proba);
    Proba = (1-gamma).*likelihood.*Proba;
    Proba = [Proba0  Proba];
    Proba = Proba/sum(Proba);
end
