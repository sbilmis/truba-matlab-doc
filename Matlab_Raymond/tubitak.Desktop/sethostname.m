function sethostname(~)

% Trying to resolve
%
%     Was unable to find the host for <CLUSTER-HOSTNAME>:<PORT NO> due to a JVM UnknownHostException: null
%
% OR
%
%     Timed out connecting to ports <SHORT-NAME>:<PORT NO>
%     Check whether a firewall is blocking communication between the worker machines and the MATLAB client machine.
%
% OR
%
%    Failed to connect to port <SHORT-NAME>:<PORT-NO>. Verify that the hostname can be resolved and the port is available. Cause:
%    Failed to connect to <SHORT-NAME>:<PORT-NO> with error: resolve: Host not found (authoritative) [asio.netdb:1 at
%    /mathworks/hub/3rdparty/R2025a/11894125/glnxa64/boost/include/boost/asio/detail/resolver_service.hpp:84 in function 'resolve'].
%
% This still might not work if the user's firewall is blocking things
%
%    The parallel pool job errored with the following message: Timed out connecting to ports <PRIVATE-IP-ADDRESS>:<PORT-NO>
%     Check whether a firewall is blocking communication between the worker machines and the MATLAB client machine.
    

% Choose the appropriate command depending on the platform
if ispc
    % On Windows use ipconfig (string scalar)
    cmd = "ipconfig";
else
    % On Unix-like systems use ifconfig -a to list all interfaces
    cmd = "ifconfig -a";
end

% Execute the shell command and capture the exit status and output
% status : numeric exit code from the command (0 typically means success)
% cmdout : character vector containing the text printed by the command
[FAILED, cmdout] = system(cmd);

% If the command returned a nonzero status, throw an error and include
% both the numeric status and the command output to help diagnose the failure
if FAILED ~= false
    error("Command failed with status: %d\n%s", status, cmdout)
end

% IPv4 octet pattern (0-255)
oct = '(?:25[0-5]|2[0-4]\d|1?\d{1,2})';

% Full pattern: 10.<oct>.<oct>.<oct>
pat = ['10\.' oct '\.' oct '\.' oct];

% Find all matches
matches = regexp(cmdout, pat, 'match');

% Remove duplicates
ip = unique(matches);

% If we didn't find any private IP addresses, return early
if isempty(ip)
    return
end

% In case there's more than one, select the first private IP address
ip = ip{1};
disp("Found private IP address.  Setting hostname: " + ip)
pctconfig('hostname',ip);

end
