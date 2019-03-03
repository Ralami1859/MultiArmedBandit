%--------------------------------------------------------------------------------------------------------
%%                                            Define the environment
%-------------------------------------------------------------------------------------------------------

BernoulliMeansMatrix = [0.9 0.1 0.1;0.2 0.5 0.9; 0.1 0.9 0.2];
Horizon = 900; %Overall number of interaction with the environment
BernoulliMeansMatrix= constructBernoulliMeansMatrix(BernoulliMeansMatrix, Horizon); 

K = 3; % %Nbr Arms


%---------------------------------------------------------------------------------------------------
%%                                            INITIALIZATION
%--------------------------------------------------------------------------------------------------

%%Defaut parameter
ksi = 0.6;
B = 0.6;

tau = 300; %Windows Length
X = [];

for k = 1:K;
    X = [X rand() < BernoulliMeansMatrix(1,k)]; %Play each arm once
end

[X, ArmPlayed, gainSWUCB]= SWUCB_Initialize(X);

%---------------------------------------------------------------------------------------------------
%%                                            INTERACTION
%--------------------------------------------------------------------------------------------------


 for t = K+1:Horizon 
   [ArmToPlay]= SWUCB_RecommendArm(X, K, ArmPlayed, tau, t, B, ksi); %Recommend Arm
   reward = rand() < BernoulliMeansMatrix(t,ArmToPlay); %Play the chosen Arm
   [X, ArmPlayed, gainSWUCB] = SWUCB_ReceiveReward(X,ArmPlayed, reward, gainSWUCB, ArmToPlay); %Update the chosen arm
 end

 %---------------------------------------------------------------------------------------------------
%%                                            PLOTTING THE RESULTS
%--------------------------------------------------------------------------------------------------
 gainSWUCB = cumsum(gainSWUCB); %Cumulate gain

 figure
 plot(gainSWUCB)
 title('Gain SWUCB')
            