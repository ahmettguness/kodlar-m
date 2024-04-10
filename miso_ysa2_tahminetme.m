THM = [];

test_input = [z(997:1001)];
[yhat] = MISOYSAmodel2(test_input,Wg,bh,Wc,bc)
THM = [THM,yhat]

test_input = [z(998:1001),THM];
[yhat] = MISOYSAmodel2(test_input,Wg,bh,Wc,bc)
THM = [THM,yhat]

test_input = [z(999:1001),THM];
[yhat] = MISOYSAmodel2(test_input,Wg,bh,Wc,bc)
THM = [THM,yhat]

test_input = [z(1000:1001),THM];
[yhat] = MISOYSAmodel2(test_input,Wg,bh,Wc,bc)
THM = [THM,yhat]

test_input = [z(1001),THM];
[yhat] = MISOYSAmodel2(test_input,Wg,bh,Wc,bc)
THM = [THM,yhat]

for k=1:50
    test_input = [THM(end-4:end)];
    [yhat] = MISOYSAmodel2(test_input,Wg,bh,Wc,bc)
    THM = [THM,yhat]
end



