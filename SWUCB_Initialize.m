function [X, ArmPlayed, gainSWUCB]= SWUCB_Initialize(X)
    gainSWUCB = X;
    for n = 1:length(X)
        if( (X(n) >1) + (X(n) <0) ~=0)
            error('Rewards must be between 0 and 1');
        end
    end
    ArmPlayed = 1:length(X);
end