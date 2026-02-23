function avail = testPortRange(~)
% TESTPORTRANGE - Check if any port in configured range is open
%
% Input arguments:
% None - reads range from pctconfig()
%
% Output arguments:
% avail - true if any port in the range is open, false otherwise

pc  = pctconfig;
rng = pc.portrange;

% Iterate through configured port range and probe each port
fprintf("Testing port: ");
for ridx = rng(1):rng(2)
    fprintf("%d ",ridx);
    % Check if the port is open
    avail = portIsOpen(ridx);
    if avail
        fprintf("\nFound open port: " + ridx + newline)
        return
    end
end

% If we reach here, the range of ports are not open
avail = false;

end
