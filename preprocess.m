function [a_ref acc acc_energy] = preprocess(data, wlen)
acc = data(1:wlen,1:3);
q = data(1:wlen,7:10);
a_ref = mean(acc,1);
q_ref = mean(q,1);

acc = data(:,1:3);
q = data(:,7:10);
q = quatdivide(q, q_ref);                             % map quaternion to the frame of reference
acc = gravity_subtraction(acc, a_ref, q);             % subtract gravity from accelerometer measurement
acc_energy = acc(:,1).^2 + acc(:,2).^2 + acc(:,3).^2; % calcualte motion acceleration energy
end

% map accelerometer measurment to the frame of reference 
% and perform gavity subtraction
function global_acc = gravity_subtraction(acc, acc_mean, q)
global_acc = zeros(size(acc));
for i = 1:length(acc)
    a_temp = [0 acc(i,:)];
    a_temp = quatmultiply(quatmultiply(q(i,:),a_temp),quatconj(q(i,:)));
    global_acc(i,:) = a_temp(2:4) - acc_mean;
end
end