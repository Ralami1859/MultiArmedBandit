function [ArmToPlay, Theta] = GlobalS_UCB1_BA_RecommendArm(Proba, Succeses, NbrPlayArm)
    
    Time = [1:length(Proba)];
    Theta = [];
    for k = 1:size(Succeses,2)
        Theta = [Theta Proba*(Succeses(:,k)./NbrPlayArm(:,k) + sqrt(2*log(Time)'./NbrPlayArm(:,k)))];
    end
    [~, ArmToPlay] = max(Theta);
    
end