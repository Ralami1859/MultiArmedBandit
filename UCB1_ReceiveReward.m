function [ExpectedMeans, NbrPlayArm, gainUCB]= UCB1_ReceiveReward(ExpectedMeans, NbrPlayArm, reward, ArmChosen, gainUCB)
    if(length(ExpectedMeans) ~= length(NbrPlayArm))
        error('Vecteur moyennes estimées et vecteur nombre de fois doivent avoir la même taille');
    end
    if(length(ExpectedMeans)< ArmChosen)
        error('Bras choisi n''existe pas');
    end
     if( reward <0 + reward > 1)
        error('reward must be between 0 and 1')
     end
    gainUCB = [gainUCB reward]; % Gain Updated
    ExpectedMeans(ArmChosen) = (ExpectedMeans(ArmChosen)*NbrPlayArm(ArmChosen) + reward)./(NbrPlayArm(ArmChosen)+1);
    NbrPlayArm(ArmChosen) = NbrPlayArm(ArmChosen) + 1;
end