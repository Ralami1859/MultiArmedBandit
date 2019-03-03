function [alphas, betas] = GlobalSTS_updateArmModel(alphas, betas, action, reward, alpha0, beta0)
    if(reward == 1)
        alphas(:,action) = alphas(:,action) + 1;
    else
        betas(:,action) = betas(:,action) + 1;
    end
    alphas = [alpha0*ones(1,size(alphas,2)); alphas];
    betas = [beta0*ones(1,size(betas,2)); betas];
end
    