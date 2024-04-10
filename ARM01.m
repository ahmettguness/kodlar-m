clear all
close all
clc


% TransactionDatabase = [ "abcfge"
%                         "adcbef"
%                         "abfe"
%                         "bfg"];
TransactionDatabase = [ 'abge  ',
    'cbef  ',
    'afe   ',
    'bfg   '
    'abde  ',
    'afg   ',
    'abdefg',
    'abef  ',
    'bcdf  ',
    'aefg  ',
    'bdef  '];

% TransactionDatabase = [];
% for i=1:20
%     L = 2 + ceil(rand*4);
%     t = gen_ran_vec(L,9);
%     t = string(char(string(t'))');
%     TransactionDatabase = [TransactionDatabase; t];
% end


MinSupp = 0.25;
MinConf = 0.25;
MinInterest = 0.08;

NumOfTransactions = size(TransactionDatabase,1);
I = unique((char(TransactionDatabase)));
I = I(find(I~=' '));

OneItemSet  = I;
for i=1:size(OneItemSet,1)
    
    ItemSet = OneItemSet(i,:);
    NumOfOccurence = 0;
    for j=1:NumOfTransactions
        [E] = DoesExist(ItemSet,TransactionDatabase(j,:));
        if E==1
            NumOfOccurence = NumOfOccurence + 1;
        end
    end
    SupportOneItemSet(i,1) = NumOfOccurence/NumOfTransactions;
end
temp = find(SupportOneItemSet>=MinSupp);
OneItemSet = OneItemSet(temp);
SupportOneItemSet = SupportOneItemSet(temp);


TwoItemSet = [];
SupportTwoItemSet = [];
for k=1:size(OneItemSet,1)-1
    for m=k+1:size(OneItemSet,1)
        premise = OneItemSet(k,:);
        consequence = OneItemSet(m,:);
        ItemSet = [premise,consequence];
        NumOfOccurence = 0;
        for j=1:NumOfTransactions
            [E] = DoesExist(ItemSet,TransactionDatabase(j,:));
            if E==1
                NumOfOccurence = NumOfOccurence + 1;
            end
        end
        SupportItemSet = NumOfOccurence/NumOfTransactions;
        
        if SupportItemSet>=MinSupp
            TwoItemSet = [TwoItemSet; ItemSet];
            SupportTwoItemSet = [SupportTwoItemSet; SupportItemSet];
        end
        
        temp = find(OneItemSet==premise);
        SupportPremise = SupportOneItemSet(temp);
        temp = find(OneItemSet==consequence);
        SupportConsequence = SupportOneItemSet(temp);
        Interest = abs(SupportItemSet-SupportPremise*SupportConsequence);
        
        if MinInterest<Interest
        
            Confidence = SupportItemSet/SupportPremise;
            if SupportItemSet>=MinSupp & Confidence>=MinConf
                disp([premise,' --> ', consequence, ' Supp.: ', num2str(SupportItemSet),' Conf.: ', num2str(Confidence),' Inte.: ', num2str(Interest)])
            end
            
            Confidence = SupportItemSet/SupportConsequence;
            if SupportItemSet>=MinSupp & Confidence>=MinConf
                disp([consequence,' --> ', premise, ' Supp.: ', num2str(SupportItemSet),' Conf.: ', num2str(Confidence),' Inte.: ', num2str(Interest)])
            end
        
        end
        
        
    end
end






