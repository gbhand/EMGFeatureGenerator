sub = dh_high(1:81000);
sub = reshape(sub, 1000, 81);

figure
for i = 1:80
    scatter(i, meanfreq(sub(:,i), 1000, [1 500]), 'filled')
    hold on
end
title('MDF from Dinghong-High calculated in MATLAB');

saveas(gcf, 'matlabMDF.png');

figure
for i = 1:80
    scatter(i, medfreq(sub(:,i), 1000, [1 500]), 'filled')
    hold on
end
title('MEF from Dinghong-High calculated in MATLAB');

saveas(gcf, 'matlabMDF.png');
