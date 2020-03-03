function feats = findFeatures(subwindow, fs)
% subwindow = highpass(raw_subwindow, 15, fs);

len = length(subwindow);

MDF = medfreq(subwindow, fs, [1 500]);
MEF = meanfreq(subwindow, fs, [1 500]);

ARV = sum(abs(subwindow))/(len);
RMS = sqrt((subwindow'*subwindow)/(len));


% % Use method from Amer's code
% nARV = mean(abs(subwindow));  % change to faster method
% nRMS = rms(subwindow);

% MDF = 1;
% MEF = 2;
% ARV = 3;
% RMS = 4;

feats = [MDF, MEF, ARV, RMS];
% feats = [ARV, nARV, RMS, nRMS];

end