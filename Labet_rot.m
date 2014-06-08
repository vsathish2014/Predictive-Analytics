% plot(1:100);
% 
% % make the axis smaller
% pos = get(gca, 'Position');
% set(gca,'Position',[pos(1), .2, pos(3) 0.7]);
% 
% % place custom text instead of xlabel
% % note that the position is relative to your X/Y axis values
% t = text(50, -5, {'X-axis' 'label'}, 'FontSize', 14);
% set(t,'HorizontalAlignment','right','VerticalAlignment','top', ...
% 'Rotation',45);

 %Use text labels rotated 45° without tex interpreter 
   %boxplot(randn(5,5),1) 
   plot(1:5)
   xticklabel_rotate([1:5],45,{'label_1','label_2','label_3','label_4','label_5'},'interpreter','none')