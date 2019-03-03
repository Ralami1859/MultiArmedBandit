function [Successes, NbrPlayArm, Proba, gainGlobalS_UCB1] = GlobalS_UCB1_Initialize(K)
    % K : Nbr Arm
    Successes = 0.5*ones(1,K);
    NbrPlayArm = ones(1,K);
    
    Proba = [1]; %Initialize Runlength distribution
    gainGlobalS_UCB1 = [];
end