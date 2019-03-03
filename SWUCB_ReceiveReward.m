function [X, ArmPlayed, gainSWUCB] = SWUCB_ReceiveReward(X,ArmPlayed, reward, gainSWUCB, ArmChosen)
    if( reward <0 + reward > 1)
        error('reward must be between 0 and 1')
     end
    gainSWUCB = [gainSWUCB reward]; % Gain Updated
    X = [X reward];
    ArmPlayed = [ArmPlayed ArmChosen];
end