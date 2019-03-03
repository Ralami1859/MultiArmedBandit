function [GlobalRegret_GS_UCB1 Proba] = GlobalSwitchingUCB1(NbrIteration)
BernoulliMeansMatrix = [0.9 0.1 0.1;0.2 0.1 0.9; 0.1 0.9 0.2];
Horizon = 3000;
BernoulliMeansMatrix= constructBernoulliMeansMatrix(BernoulliMeansMatrix, Horizon);
gamma = 3/Horizon; % Change rate

NbrMaxRunlengths = min(1000, Horizon); % Nbr max of runlengths
GlobalRegret_GS_UCB1 = [];
K = 3; % NbrBras

%% Select Aggregation or not
withAggregation = 1;
%withAggregation = 0;

%%
for iter = 1:NbrIteration
    tic
    display(iter);
    
    regret = [];
    %%Initialization
     [Successes, NbrPlayArm, Proba, gainGlobalS_UCB1] = GlobalS_UCB1_Initialize(K);

    %%Interaction
    for t = 1:Horizon
        %display(t)
        % Choose Arm to play
        if(withAggregation == 1)
            [ArmToPlay, Theta] = GlobalS_UCB1_BA_RecommendArm(Proba, Successes, NbrPlayArm);
            
        else
            [ArmToPlay] = GlobalS_UCB1_RecommendArm(Proba, Successes, NbrPlayArm);
        end
        reward = rand() < BernoulliMeansMatrix(t,ArmToPlay); %Play the chosen Arm
        regret = [regret max(BernoulliMeansMatrix(t,:)) - BernoulliMeansMatrix(t,ArmToPlay)];
        [Proba] = GlobalS_UCB1_updateChangeModel(Proba,Successes,NbrPlayArm,ArmToPlay,reward,gamma);
        [Successes, NbrPlayArm, gainGlobalS_UCB1] = GlobalS_UCB1_updateArmModel(Successes, NbrPlayArm, ArmToPlay, reward, gainGlobalS_UCB1);
        if(length(Proba) > NbrMaxRunlengths)
            [Proba, Successes, NbrPlayArm] = GlobalS_BayesUCB_Resampling(Proba, Successes, NbrPlayArm);
        end
    end

    gainGlobalS_UCB1 = cumsum(gainGlobalS_UCB1);
    GlobalRegret_GS_UCB1 = [GlobalRegret_GS_UCB1; cumsum(regret)];
    toc
end
figure
plot(mean(GlobalRegret_GS_UCB1,1))
if(withAggregation == 1)
    title('Regret Global Switching UCB1 BA')
else
    title('Regret Global Switching UCB1')
end
