% Splits each file in the input directory into 1-sec windows and
% then calculates time and frequency features (MDF, MEF, ARV, RMS)
% for 50 subwindows in each.
%
% Creates multidimensional feature matrices ready to use for
% training of fatigue-detecting neural network.


sub = 50;
samplerate = 1000;
windows = 10;
subwindows = sub;
sub_size = samplerate / subwindows;
num_features = 4;
inputdir = 'sample_data';
% mkdir 'output\MDF';
% mkdir 'output\MEF';
% mkdir 'output\ARV';
% mkdir 'output\RMS';
mkdir 'output\feature1';
mkdir 'output\feature2';
mkdir 'output\feature3';
mkdir 'output\feature4';
clear final_data;
% num_datasets = 4;
% figure('Name','EMG Dataset Comparison','NumberTitle','off');
% clf;
% yl = false; % toggles horizontal line

% none = d1(1:10000);
% low = d2(1:10000);
% medium = d3(1:10000);
% high = d4(1:10000);



% data = [none, low, medium, high];

data = chunkify(importDatasets(inputdir), 10, 1000);
num_datasets = size(data, 2);


% dataset_names = ["No", "Low", "Medium", "High"];
final_data = zeros(num_features, subwindows, windows, num_datasets);
disp('Dataset dimensions calculated...');
disp(size(final_data));
tic

fileidx = 0;
for d = 1:num_datasets
    index = d;
    
    for  m = 1:num_features  % iterate for each feature
        switch m
            case 1
                yx = "MDF (Hz)                         ";
            case 2
                yx = "MEF (Hz)                         ";
            case 3
                yx = "ARV (Volts)                     ";
            case 4
                yx = "RMS (Volts)                     ";
        end
        k = 0;
        volt = reshape(data(:,d), samplerate, windows);

        sub_volt = reshape(volt, sub_size, subwindows, windows);

        features = zeros(num_features, subwindows, windows);
        
        for win = 1:windows % iterate over each window of 1 sec
            for sub = 1:subwindows % iterate each subwindow
                subwindow = sub_volt(:, sub, win);
                features(:, sub, win) = findFeatures(subwindow, samplerate);
                 
            end
        end
        
        
        
        f = features(m,:);
        
        
        
% % %         subplot(num_features, num_datasets, index);
% % %         name = strcat('var = ', num2str(var(f)), " | std = ",num2str(std(f)));
        
% % %         plot((1:1:windows*subwindows), features(m,:), 'DisplayName', name)
% % %         ax = gca;
% % %         alpha 0.1;
% % %         if m < 2
% % %             title(strcat(dataset_names(d), " fatigue"));
% % %         end
% % %         if d < 2
% % %             ylabel(yx, 'FontWeight', 'bold');
% % %             set(get(gca,'YLabel'),'Rotation',0)
% % %         end
% % %         xlabel("window");
% % %         axis tight;
% % %         
% % %         ylim([min(features(m,:)), max(features(m,:))]);
% % %         
% % %         legend
% % %         
% % %         if yl
% % %             yline(mean(f),'--', "Average", 'LineWidth', 1.5, 'HandleVisibility','off');
% % %         end
% % %         
% % %         index = index + 4;
        
    end
    
    final_data(:,:,:,d) = features;
    for i = 1:num_features
        tmp = reshape(squeeze(features(i,:,:))', 50, 10);
        save(['output\feature', int2str(i), '\', int2str(fileidx), '.mat'], 'tmp');
        
%         fig = imagesc(tmp);
%         saveas(fig, ['output\feature', int2str(i), '\', int2str(fileidx), '.png']);
        
    end
    save(['output\', 'raw', int2str(fileidx), '.mat'], 'sub_volt');
    fileidx = fileidx + 1;
    
    disp(['Finished dataset ', num2str(d)]);
    
end
% saveas(gcf, 'total_20windows.png')
toc
disp('attempting to save as "final_data.mat"');
tic
save('final_data.mat', 'final_data');
toc
