BernoulliMeans = [0.5 0.6 0.1];
Horizon = 1000;
K = length(BernoulliMeans);
FirstRewards = [];

for t=1:K;
    FirstRewards = [FirstRewards rand() < BernoulliMeans(t)];
end

gainUCB = FirstRewards;
%% Initialization
[ExpectedMeans, NbrPlayArm]= UCB1_Initialize(FirstRewards);
%% Interaction
for t = K+1:Horizon;
    ArmToPlay = UCB1_RecommendArm(ExpectedMeans, NbrPlayArm, t); % Arm recommended by UCB1
    reward = rand() < BernoulliMeans(ArmToPlay); % Reward received by playing the chosen arm
    gainUCB = [gainUCB reward]; % Gain Updated
    [ExpectedMeans, NbrPlayArm]= UCB1_ReceiveReward(ExpectedMeans, NbrPlayArm, reward, ArmToPlay); % Update UCB parameters using the reward received at time t.
end

gainUCB = cumsum(gainUCB); % Cumulate all gains
figure
plot(gainUCB)
title('Gain UCB')