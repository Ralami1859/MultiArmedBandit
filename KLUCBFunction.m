function res = KLUCBFunction(x, S, N, t, T)
    res = (DivKL(S./N,x) <= (log(t) + log(log(T)))./N)*(-1);
end