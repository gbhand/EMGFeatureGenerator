cd 'output';
for j = 1:4
    disp(['making figure ', int2str(j)]); 
    figure(j);
    cd(['feature', int2str(j)]);
    files = dir('*.mat');
    num = length(files);
    for i = 1:num
        im = load([int2str(i-1), '.mat']).tmp;
        subplot(num, 1, i);
        imagesc(im)

    end
    cd ..;
end
cd ..;