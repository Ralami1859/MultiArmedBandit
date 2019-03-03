NbrEpoch = 10;
Horizon = 2000;
VectHorizon = ones(1,NbrEpoch)*floor(Horizon/NbrEpoch); 
NbrBras = 4;
BernoulliMeansMatrix = rand(NbrEpoch, NbrBras);

display('Running a simple Thompson Sampling ...')
GlobalRegretTS = ThompsonSampling(BernoulliMeansMatrix, VectHorizon);
display('END of Thompson Sampling')

display('Running a Thompson Sampling Oracle ...')
GlobalRegretTSOracle = ThompsonSamplingOracle(BernoulliMeansMatrix, VectHorizon);
display('END of Thompson Sampling Oracle')

display('Running STS BA')
[GlobalRegretSTS_BA]= GlobalSTS_BA(BernoulliMeansMatrix, VectHorizon);
display('END of STS BA')

display('Running STS')
[GlobalRegretSTS]= GlobalSTS(BernoulliMeansMatrix, VectHorizon);
display('END of STS')

display('Running EXP3')
GlobalRegretEXP3 = Exp3(BernoulliMeansMatrix, VectHorizon);
display('END of EXP3')

display('Running EXP3P')
GlobalRegretEXP3P = Exp3P(BernoulliMeansMatrix, VectHorizon);
display('END of EXP3P')

display('Running EXP3S')
GlobalRegretEXP3S = Exp3S(BernoulliMeansMatrix, VectHorizon);
display('END of EXP3S')

H = Horizon/NbrEpoch;
display('Running EXP3R')
GlobalRegretEXP3R = Exp3R(BernoulliMeansMatrix, VectHorizon, H);
display('END of EXP3R')

batchSize = Horizon/NbrEpoch;
display('Running REXP3')
GlobalRegretREXP3 = RExp3(BernoulliMeansMatrix, VectHorizon, batchSize);
display('END of REXP3')

tau = Horizon/NbrEpoch;
display('Running SW UCB')
GlobalRegretSW_UCB = SW_UCB(BernoulliMeansMatrix, VectHorizon, tau);
display('END of SWUCB')


