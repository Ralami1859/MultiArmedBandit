function res = SearchingKLUCBIndex(S,N,t,Horizon, variant)
%     x = S/N:0.001:1;
%     y = KLUCBFunction(x, S, N, t, Horizon);
%     [maxi,res] = max(y);
%     i = length(x);
%     res1 = res;
%     while(i>res)
%         if(x(i) == maxi)
%             res1 = i;
%             break;
%         end
%         i = i-1;
%     end
%             
%     res = x(res1);
    p = S./N;
    d = (log(t) + log(log(Horizon)))./N;
    if (variant)
        d = (log(t./N) + log(log(Horizon)))./N;
    end
    res = klIC(p, d);
end