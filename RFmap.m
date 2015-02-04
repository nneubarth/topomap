function hmvalues = RFmap()
global gtest
global gridinfo

fnums = gridinfo.acqNum;
numspikes = zeros(1,length(fnums));
formatOut = 'yymmdd';
date = datestr(now,formatOut);
for fnum = 1:length(fnums)
    numspikes(fnum) = spikedetection(date,fnums(fnum));
end
hmvalues = reshape(numspikes,size(gtest.xGrid,1),size(gtest.xGrid,2));

end

function numspikes = spikedetection(date,acqnum)
%quick and dirty spike detection
acqstring = '0000';
acqnum = num2str(acqnum);
acqstring(4-(length(acqnum)-1):4) = acqnum;

data = load(['\\research.files.med.harvard.edu\neurobio\GintyLab\Neubarth\ephus_data\' num2str(date) '\AA0001\AA0001AAAA'  acqstring '.xsg'], '-mat');
trace = data.data.ephys.trace_1';
trace = trace - min(trace);
%Fs = data.header.ephys.ephys.sampleRate;
%t = [1/Fs:1/Fs:length(trace)/Fs];
[b,a] = butter(2,1/10,'high');
trace = filtfilt(b,a,trace);

%figure
%plot(t,trace)
if max(trace)-min(trace) > 300
    spikethresh = .7*max(trace);
    [pks]=findpeaks(trace,'MINPEAKHEIGHT',spikethresh);%[pks,locs]
numspikes = length(pks);
%hold on
%for s = 1:length(pks)
%    plot([t(locs(s)) t(locs(s))],[max(trace)*1.2, max(trace)*1.5],'r')
%end
end
end