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

[w, gainEXP3S] = EXP3_Initialize(K);

%---------------------------------------------------------------------------------------------------
%%                                            INTERACTION
%--------------------------------------------------------------------------------------------------

for t = 1:Horizon;
    [ArmToPlay, p] = EXP3_RecommendArm(w, gamma);
    reward = rand() < BernoulliMeansMatrix(t,ArmToPlay);
    [w, gainEXP3S] = EXP3S_ReceiveReward(w, p, reward, K, Horizon, gamma, ArmToPlay, gainEXP3S);
end

%---------------------------------------------------------------------------------------------------
%%                                            PLOTTING THE RESULTS
%--------------------------------------------------------------------------------------------------


gainEXP3S = cumsum(gainEXP3S); %Cumulate gain

figure
plot(gainEXP3S)
title('Gain EXP3S')
                 
                 
                 
                 
                 
                 
                 
                 