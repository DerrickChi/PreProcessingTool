function i = DetermineInitialWinodw(data)
wlen = 20;
int_threshold = 0.002; % if the acceleration energy variance within a window falling below the threshold, the window is for initialization  
wlen = 2*wlen;
for i = 1:wlen+1:length(data(:,1))
    if (i+wlen >= length(data(:,1)))  %fixed the case when there's no motion at all
        break;
    end
    acc = data(i:i+wlen,:);
    acc_var = var(acc(:,1).^2 + acc(:,2).^2 + acc(:,3).^2);
    if (acc_var >= int_threshold)
        break;
    end
end
i = i - 1;
if i == 0
    i = 1;
elseif i - wlen/2 > 200
    i = 200;
else
    i = i - wlen/2;
end
end