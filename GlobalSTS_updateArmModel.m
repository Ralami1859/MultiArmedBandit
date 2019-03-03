%% Update the hyperparameters of each arm.

function [alphas, betas, gainGlobalSTS] = GlobalSTS_updateArmModel(alphas, betas, action, reward, alpha0, beta0, gainGlobalSTS)
    if( alpha0 <=0 )
        error('alpha0 must be > 0');
    end
    if(beta0 <= 0)
        error('beta0 must be > 0');
    end
    
    if( (reward <0) + (reward > 1) ~= 0)
        error('reward must be between 0 and 1')
    end
    gainGlobalSTS = [gainGlobalSTS reward];
    if((reward == 0) + (reward == 1) == 0)
        reward = rand() < reward; % for non Bernoulli Distribution
    end
    if(reward == 1)
        alphas(:,action) = alphas(:,action) + 1;
    else
        betas(:,action) = betas(:,action) + 1;
    end
    alphas = [alpha0*ones(1,size(alphas,2)); alphas];
    betas = [beta0*ones(1,size(betas,2)); betas];
end
    