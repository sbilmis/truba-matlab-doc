function t = parfor_demo()
% Simple parfor timing demo (runs on workers)
N = 55;

tic
parfor i = 1:N
    pause(1);
end
t = toc;

fprintf("parfor_demo: N=%d, elapsed=%.2f s\n", N, t);
end
