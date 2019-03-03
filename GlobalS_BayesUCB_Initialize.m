function [alphas, betas, Proba, gainGlobalS_BayesUCB] = GlobalS_BayesUCB_Initialize(K, alpha0, beta0)
    % K : Nbr Arm
    if( alpha0 <=0 )
        error('alpha0 must be > 0');
    end
    if(beta0 <= 0)
        error('beta0 must be > 0');
    end
    alphas = ones(1,K)*alpha0;
    betas = ones(1,K)*beta0;
    
    Proba = [1]; %Initialize Runlength distribution
    gainGlobalS_BayesUCB = [];
end