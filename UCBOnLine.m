%--------------------------------------------------------------------------------------------------------
%%                                            Define the environment
%-------------------------------------------------------------------------------------------------------

BernoulliMeans = [0.5 0.6 0.1];
Horizon = 1000; %Overall number of interaction with the environment

K = 3; %Nbr Arms

%-------------------------------------------------------------------------------------------------------------
%%                                                 INITIALIZATION
%-------------------------------------------------------------------------------------------------------------
FirstRewards = [];

for t=1:K;
    FirstRewards = [FirstRewards rand() < BernoulliMeans(t)]; % Play each Arm Once
end
[ExpectedMeans, NbrPlayArm, gainUCB]= UCB1_Initialize(FirstRewards);


%---------------------------------------------------------------------------------------------------
%%                                            INTERACTION
%--------------------------------------------------------------------------------------------------

for t = K+1:Horizon;
    ArmToPlay = UCB1_RecommendArm(ExpectedMeans, NbrPlayArm, t); % Arm recommended by UCB1
    reward = rand() < BernoulliMeans(ArmToPlay); % Reward received by playing the chosen arm
    [ExpectedMeans, NbrPlayArm, gainUCB]= UCB1_ReceiveReward(ExpectedMeans, NbrPlayArm, reward, ArmToPlay, gainUCB); % Update UCB parameters using the reward received at time t.
end

%-------------------------------------------------------------------------------------------------------------
%%                                                  Plotting the results
%-------------------------------------------------------------------------------------------------------------
gainUCB = cumsum(gainUCB); % Cumulate all gains
figure
plot(gainUCB)
title('Gain UCB')