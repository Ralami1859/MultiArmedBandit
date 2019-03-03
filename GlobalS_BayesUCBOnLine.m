BernoulliMeansMatrix = [0.9 0.1 0.1;0.2 0.1 0.9; 0.1 0.9 0.2];
Horizon = 900;
BernoulliMeansMatrix= constructBernoulliMeansMatrix(BernoulliMeansMatrix, Horizon);
gamma = 3/900; % Change rate

NbrMaxRunlengths = min(1000, Horizon); % Nbr max of runlengths
 
K = 3; % NbrBras

%% Select Aggregation or not
%withAggregation = 1;
withAggregation = 0;

%%
alpha0 = 1; beta0 = 1; %Prior

%%Initialization
[alphas, betas, Proba, gainGlobalS_BayesUCB] = GlobalS_BayesUCB_Initialize(K, alpha0, beta0);

%%Interaction
for t = 1:Horizon
    %display(t)
    % Choose Arm to play
    if(withAggregation == 1)
        [ArmToPlay, Theta] = GlobalS_BayesUCB_BA_RecommendArm(Proba, alphas, betas,gamma, t, Horizon);
    else
        [ArmToPlay] = GlobalS_BayesUCB_RecommendArm(Proba, alphas, betas, gamma, t, Horizon);
    end
    reward = rand() < BernoulliMeansMatrix(t,ArmToPlay); %Play the chosen Arm

    [Proba ] = GlobalS_BayesUCB_updateChangeModel(Proba,alphas,betas,ArmToPlay,reward,gamma); %Update runlength distribution
    Runlength{t} = Proba;
    [alphas, betas, gainGlobalS_BayesUCB] = GlobalS_BayesUCB_updateArmModel(alphas, betas, ArmToPlay, reward, alpha0, beta0, gainGlobalS_BayesUCB);%Update Arm Model
    if(length(Proba) > NbrMaxRunlengths)
        [Proba, alphas, betas] = GlobalSTS_Resampling(Proba, alphas, betas);
    end
end

gainGlobalS_BayesUCB = cumsum(gainGlobalS_BayesUCB);
figure
plot(gainGlobalS_BayesUCB)
if(withAggregation == 1)
    title('Gain Global Switching Bayes UCB BA')
else
    title('Gain Global Switching Bayes UCB')
end
