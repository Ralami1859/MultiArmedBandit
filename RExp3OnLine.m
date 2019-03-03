%--------------------------------------------------------------------------------------------------------
%%                                            Define the environment
%-------------------------------------------------------------------------------------------------------

BernoulliMeansMatrix = [0.9 0.1 0.1;0.2 0.5 0.9; 0.1 0.9 0.2];
Horizon = 900; %Overall number of interaction with the environment
BernoulliMeansMatrix= constructBernoulliMeansMatrix(BernoulliMeansMatrix, Horizon); 

K = 3; %Nbr Arms

gamma = 0.05; % Exploration Rate
batchSize = 300; % Example !

%---------------------------------------------------------------------------------------------------
%%                                            INITIALIZATION
%--------------------------------------------------------------------------------------------------
[w, gainREXP3] = EXP3_Initialize(K);

%---------------------------------------------------------------------------------------------------
%%                                            INTERACTION
%--------------------------------------------------------------------------------------------------

for t = 1:Horizon;
    [ArmToPlay, p, w] = REXP3_RecommendArm(w, gamma, t, batchSize); % Arm Recommanded by REXP3
    reward = rand() < BernoulliMeansMatrix(t,ArmToPlay); % Play the recommanded arm
    [w, gainREXP3] = EXP3_ReceiveReward(w, p, reward, K, gamma, ArmToPlay, gainREXP3); % Update the chosen arm
end
        
%---------------------------------------------------------------------------------------------------
%%                                            PLOTTING THE RESULTS
%--------------------------------------------------------------------------------------------------


gainREXP3 = cumsum(gainREXP3); %Cumulate gain

figure
plot(gainREXP3)
title('Gain REXP3')
                 
                 
                 
                 
                 
                 
                 
                 