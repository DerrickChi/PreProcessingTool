function data = ReadData(file) 

file

as = 2048;       % sensitivity of 16g accelerometer
gs = 16.4;       % sensitivity of gyroscope
qs = 1073741824; % sensitivity of quaternion
% fid = fopen(file,'r');
% raw_data = [];
% id = 0;
% a = fgets(fid);
% while(ischar(a))
%     id = id + 1;
%     if id == 1
%         a = fgets(fid);
%         continue
%     else
%         raw_data = [raw_data; str2num(a)];
%     end
%     a = fgets(fid);
% end
% fclose(fid);

raw_data = csvread(file, 1, 0);
if ~isempty(raw_data)
    raw_data(:,2) = -raw_data(:,2);
    raw_data(:,3) = -raw_data(:,3);
    timestamp = raw_data(:,1);
    acc = raw_data(:,2:4)/as;
    gyro = raw_data(:,5:7)/gs;
    q = raw_data(:,8:11)/qs;
    data = [acc gyro q timestamp];
else
    data = [];
end
end