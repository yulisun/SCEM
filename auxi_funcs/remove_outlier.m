function x = remove_outlier(y)
x = y;
outliers = y - mean(y(:)) > 5*std(y(:));
x(outliers) = max(max(x(~outliers)));