function out = Figure_Settings( a, f )
    % f needs to be gcf
    % a needs to be gca
  set(a,'TickDir','out')
  set(f, 'Color', [1 1 1])
  set(a,'fontsize',12)
  set( get(a,'XLabel'), 'FontSize', 16 )
  set( get(a,'YLabel'), 'FontSize', 16 )
  set( get(a,'Title'), 'FontSize', 21 )
end