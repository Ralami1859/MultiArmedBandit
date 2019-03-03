function [GlobalRegret_GS_UCB_Tuned Proba] = GlobalSwitchingUCB_Tuned(NbrIteration)
BernoulliMeansMatrix = [0.9 0.1 0.1;0.2 0.1 0.9; 0.1 0.9 0.2];
Horizon = 3000;
BernoulliMeansMatrix= constructBernoulliMeansMatrix(BernoulliMeansMatrix, Horizon);
gamma = 3/Horizon; % Change rate

NbrMaxRunlengths = min(1000, Horizon); % Nbr max of runlengths
GlobalRegret_GS_UCB_Tuned = [];
K = 3; % NbrBras

%% Select Aggregation or not
%withAggregation = 1;
withAggregation = 0;

%%
for iter = 1:NbrIteration
    tic
    display(iter);
    
    regret = [];
    %%Initialization
     [Successes, Successes2,NbrPlayArm, Proba, gainGlobalS_UCB_Tuned] = GlobalS_UCB_Tuned_Initialize(K);

    %%Interaction
    for t = 1:Horizon
        %display(t)
        % Choose Arm to play
        if(withAggregation == 1)
            [ArmToPlay, Theta] = GlobalS_UCB_Tuned_BA_RecommendArm(Proba, Successes, Successes2, NbrPlayArm);
            
        else
            [ArmToPlay] = GlobalS_UCB_Tuned_RecommendArm(Proba, Successes, Successes2, NbrPlayArm);
        end
        reward = rand() < BernoulliMeansMatrix(t,ArmToPlay); %Play the chosen Arm
        regret = [regret max(BernoulliMeansMatrix(t,:)) - BernoulliMeansMatrix(t,ArmToPlay)];
        [Proba] = GlobalS_UCB1_updateChangeModel(Proba,Successes,NbrPlayArm,ArmToPlay,reward,gamma);
        [Successes, Successes2, NbrPlayArm, gainGlobalS_UCB_Tuned] = GlobalS_UCB_Tuned_updateArmModel(Successes, Successes2, NbrPlayArm, ArmToPlay, reward, gainGlobalS_UCB_Tuned);
        if(length(Proba) > NbrMaxRunlengths)
            [Proba, Successes, Successes2, NbrPlayArm] = GlobalS_UCB_Tuned_Resampling(Proba, Successes, Successes2, NbrPlayArm);
        end
    end

    gainGlobalS_UCB_Tuned = cumsum(gainGlobalS_UCB_Tuned);
    GlobalRegret_GS_UCB_Tuned = [GlobalRegret_GS_UCB_Tuned; cumsum(regret)];
    toc
end
figure
plot(mean(GlobalRegret_GS_UCB_Tuned,1))
if(withAggregation == 1)
    title('Regret Global Switching UCB Tuned BA')
else
    title('Regret Global Switching UCB Tuned')
end
