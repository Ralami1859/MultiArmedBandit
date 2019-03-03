function res = fctScale(x)
    res = (x < 0.5) + (x>1).*(x<2) + (x > 3).*(x < 4);
    res = res.*1;
end