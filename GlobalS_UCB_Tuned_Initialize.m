function [Successes,Successes2, NbrPlayArm, Proba, gainGlobalS_UCB_Tuned] = GlobalS_UCB_Tuned_Initialize(K)
    % K : Nbr Arm
    Successes = 0.5*ones(1,K);
    NbrPlayArm = ones(1,K);
    Successes2 = 0.25*ones(1,K);
    Proba = [1]; %Initialize Runlength distribution
    gainGlobalS_UCB_Tuned = [];
end