% started on 250916 by R. Monchaux
% GOAL: 
% Use PIVLAB to process PIV images and Matlab to perform basic plots and
% visualisations
%
%
%% Import a vector field and do some plots
% load('PIVlab_exp01.mat')
v_type = 'original';
[U , V] = pick_velocity(v_type,v_filtered,u_filtered,v_original,u_original,v_smoothed,u_smoothed);

%% A movie of vector plots or of a given component or of something else
scale = 2;
figure(100)
colorbar
%
for ii = 1:length(U)-2
    figure(100)
%     pcolor(x{ii},y{ii},U{ii})
%     pcolor(x{ii},y{ii},V{ii})
    quiver(x{ii},y{ii},U{ii},V{ii},scale)
    axis image
    drawnow
    caxis([-8,1])
    box on
    set(gca,'FontSize',16)
    pause(1)
%     clf
end
%
%
%% Working on filtered data and outliers
% Counting the number of outliers and plotting their evolution
NbOutliers = NaN * ones(1,length(u_smoothed));
for ii = 1:length(u_smoothed)-2
    NbOutliers(ii) = numel(find(typevector_filtered{ii}==2));
end
figure
hold on 
box on
set(gca,'FontSize',16)
plot(NbOutliers/numel(typevector_original{1}))
ylim([0,0.05])
%
%
%
%
%% Local functions
function [U, V] = pick_velocity(v_type,v_filtered,u_filtered,v_original,u_original,v_smoothed,u_smoothed)
switch v_type
    case 'original'
        V = v_original;
        U = u_original;
    case 'filtered'
        V = v_filtered;
        U = u_filtered;
    case 'smmoothed'
        V = v_smoothed;
        U = u_smoothed;
end
end