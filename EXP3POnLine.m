%--------------------------------------------------------------------------------------------------------
%%                                            Define the environment
%-------------------------------------------------------------------------------------------------------

BernoulliMeansMatrix = [0.9 0.1 0.1;0.2 0.5 0.9; 0.1 0.9 0.2];
Horizon = 900; %Overall number of interaction with the environment
BernoulliMeansMatrix= constructBernoulliMeansMatrix(BernoulliMeansMatrix, Horizon); 

K = 3; %Nbr Arms
gamma = 0.05; % Exploration Rate

%---------------------------------------------------------------------------------------------------
%%                                            INITIALIZATION
%--------------------------------------------------------------------------------------------------

[w, gainEXP3P] = EXP3P_Initialize(K, gamma, Horizon);

%---------------------------------------------------------------------------------------------------
%%                                            INTERACTION
%--------------------------------------------------------------------------------------------------

for t = 1:Horizon;
    [ArmToPlay, p] = EXP3_RecommendArm(w, gamma);
    reward = rand() < BernoulliMeansMatrix(t,ArmToPlay);
    [w, gainEXP3P] = EXP3P_ReceiveReward(w, p, reward, K, Horizon, gamma, ArmToPlay, gainEXP3P);
end
        

%---------------------------------------------------------------------------------------------------
%%                                            PLOTTING THE RESULTS
%--------------------------------------------------------------------------------------------------

gainEXP3P = cumsum(gainEXP3P); %Cumulate gain

figure
plot(gainEXP3P)
title('Gain EXP3P')
                 
                 
                 
                 
                 
                 
                 
                 