%% Basic performance measures.
% TIC/TOC
tic
A = rand(1e3);
toc

%% Processing time
t1 = cputime;
A = rand(1e3);
t2 = cputime;
delta_t = t2 - t1

%% From 13b onward, you also have TIMEIT.
myFunc = @() rand(1e3);
t_avg = timeit(myFunc)

%%
inmem % Which functions/scripts are currently in memory?
% clear functions will clear this (clear all also clears all functions)

%% MATLAB Profiler
profile on
predictorRankings = findBestPredictors_debug();
profile off
profile viewer

% Advanced excercise: use parallel computing on the cluster to 
% speed up this algorithm.  Or, use the local resources.

