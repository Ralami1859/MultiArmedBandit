%--------------------------------------------------------------------------------------------------------
%%                                            Define the environment
%-------------------------------------------------------------------------------------------------------

BernoulliMeans = [0.9 0.1 0.1];
Horizon = 1000;
K = length(BernoulliMeans);

%---------------------------------------------------------------------------------------------------
%%                                            INITIALIZATION
%--------------------------------------------------------------------------------------------------

%Priors
alpha0 = 1;
beta0 = 1;

[alphas, betas, gainBayesUCB]= BayesUCB_Initialize(K, alpha0, beta0);

%---------------------------------------------------------------------------------------------------
%%                                            INTERACTION
%--------------------------------------------------------------------------------------------------
for t = 1:Horizon;
    ArmToPlay = BayesUCB_RecommendArm(alphas, betas, t, Horizon); % Arm recommended by Bayes UCB
    reward = rand() < BernoulliMeans(ArmToPlay); % Reward received by playing the chosen arm
    [alphas, betas, gainBayesUCB]= BayesUCB_ReceiveReward(alphas, betas, reward, ArmToPlay, gainBayesUCB); % Update Bayes UCB parameters using the reward received at time t.
end

%---------------------------------------------------------------------------------------------------
%%                                            PLOTTING THE RESULTS
%--------------------------------------------------------------------------------------------------

gainBayesUCB = cumsum(gainBayesUCB); % Cumulate all gains
figure
plot(gainBayesUCB)
title('Gain Bayes UCB')