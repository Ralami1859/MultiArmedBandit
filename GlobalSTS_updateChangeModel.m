%% Update the expert distribution using the message passing algorithm of Fearnhead 2010.
function [Expert_Distribution] = GlobalSTS_updateChangeModel(Expert_Distribution,alphas,betas,action,reward,gamma)
    

    likelihood = [];
    if(reward == 1)
        for i=1:length(Expert_Distribution);
            likelihood = [likelihood alphas(i,action)/(alphas(i,action)+betas(i,action))];
        end
    else
        for i=1:length(Expert_Distribution);
            likelihood = [likelihood betas(i,action)/(alphas(i,action)+betas(i,action))];
        end
    end
    Proba0 = gamma*sum(likelihood.*Expert_Distribution);
    Expert_Distribution = (1-gamma).*likelihood.*Expert_Distribution;
    Expert_Distribution = [Proba0  Expert_Distribution];
    Expert_Distribution = Expert_Distribution/sum(Expert_Distribution);
end
