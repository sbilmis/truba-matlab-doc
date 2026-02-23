function [sim_t, A] = parallel_example(iter)
    if nargin==0
        iter = 8; % Default to 8 loops if no input is given
    end
    
    disp('Starting Parallel Simulation...')
    A = nan(iter,1);
    t0 = tic;
    
    % The "parfor" loop runs these iterations in parallel
    parfor idx = 1:iter
        A(idx) = idx;
        pause(2) % Simulates a 2-second calculation
    end
    
    sim_t = toc(t0);
    disp('Simulation Completed.')
    save RESULTS A
end