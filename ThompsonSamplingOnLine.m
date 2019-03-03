%--------------------------------------------------------------------------------------------------------
%%                                            Define the environment
%-------------------------------------------------------------------------------------------------------

BernoulliMeans = [0.9 0.1 0.1];
Horizon = 1000; %Overall number of interaction with the environment
K = length(BernoulliMeans); %Nbr Arms

%---------------------------------------------------------------------------------------------------
%%                                            INITIALIZATION
%--------------------------------------------------------------------------------------------------

%Priors
alpha0 = 1;
beta0 = 1;

[alphas, betas, gainThompsonSampling]= ThompsonSampling_Initialize(K, alpha0, beta0);

%---------------------------------------------------------------------------------------------------
%%                                            INTERACTION
%--------------------------------------------------------------------------------------------------

for t = 1:Horizon;
    ArmToPlay = ThompsonSampling_RecommendArm(alphas, betas); % Arm recommended by ThompsonSampling
    reward = rand() < BernoulliMeans(ArmToPlay); % Reward received by playing the chosen arm
    [alphas, betas, gainThompsonSampling]= ThompsonSampling_ReceiveReward(alphas, betas, reward, ArmToPlay, gainThompsonSampling); % Update Thompson Sampling parameters using the reward received at time t.
end

%---------------------------------------------------------------------------------------------------
%%                                            PLOTTING THE RESULTS
%--------------------------------------------------------------------------------------------------


gainThompsonSampling = cumsum(gainThompsonSampling); % Cumulate all gains
figure
plot(gainThompsonSampling)
title('Gain Thompson Sampling')