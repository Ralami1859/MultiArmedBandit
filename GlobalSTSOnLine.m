%--------------------------------------------------------------------------------------------------------
%%                                            Define the environment
%-------------------------------------------------------------------------------------------------------
BernoulliMeansMatrix = [0.9 0.1 0.1;0.2 0.1 0.9; 0.1 0.9 0.2];
Horizon = 900; %Overall number of interaction with the environment
BernoulliMeansMatrix= constructBernoulliMeansMatrix(BernoulliMeansMatrix, Horizon);

K = 3; % %Nbr Arms
gamma = 3/Horizon; % Switch rate
NbrMaxExpert = min(1000, Horizon); % Nbr max of experts


%% Select Aggregation or not
withAggregation = 1;   % version 2017
% withAggregation = 0;  % version 2013

%%
alpha0 = 1; beta0 = 1; %Prior

%---------------------------------------------------------------------------------------------------
%%                                           INITIALIZATION
%---------------------------------------------------------------------------------------------------
[alphas, betas, Expert_Distribution, gainGlobalSTS] = GlobalSTS_Initialize(K, alpha0, beta0);

%---------------------------------------------------------------------------------------------------
%%                                            INTERACTION
%--------------------------------------------------------------------------------------------------
for t = 1:Horizon
    % Choose Arm to play
    if(withAggregation == 1)
        [ArmToPlay] = GlobalSTS_BA_RecommendArm(Expert_Distribution, alphas, betas);
    else
        [ArmToPlay] = GlobalSTS_RecommendArm(Expert_Distribution, alphas, betas);
    end
    reward = rand() < BernoulliMeansMatrix(t,ArmToPlay); %Play the chosen Arm
    
    reward = rewardCorrection(reward); % For non bernoulli rewards
    
    [Expert_Distribution ] = GlobalSTS_updateChangeModel(Expert_Distribution,alphas,betas,ArmToPlay,reward,gamma); %Update expert distribution
    [alphas, betas, gainGlobalSTS] = GlobalSTS_updateArmModel(alphas, betas, ArmToPlay, reward, alpha0, beta0, gainGlobalSTS);%Update Arm Model
    if(length(Expert_Distribution) > NbrMaxExpert)
        [Expert_Distribution, alphas, betas] = GlobalSTS_Resampling(Expert_Distribution, alphas, betas); % To avoid memory limitations
    end
end


%-------------------------------------------------------------------------------------------------------------
%%                                                  Plotting the results
%-------------------------------------------------------------------------------------------------------------

gainGlobalSTS = cumsum(gainGlobalSTS);
figure
plot(gainGlobalSTS)
if(withAggregation == 1)
    title('Gain Global STS BA')
else
    title('Gain Global STS')
end

xlabel('Time step')
ylabel('Cumulative gain')
