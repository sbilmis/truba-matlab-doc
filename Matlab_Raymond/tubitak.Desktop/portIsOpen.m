function TF = portIsOpen(port, host, timeoutSecs)
% portIsOpen  Check whether a TCP port is open (listening) on a host.
%   open = portIsOpen(host, port) uses a 1 second timeout.
%   open = portIsOpen(host, port, timeoutSecs) specifies timeout in seconds.
%
%   Examples:
%     portIsOpen(22)                      % check SSH on local machine
%     portIsOpen(80, '192.168.1.10', 20)  % check HTTP on remote host with a 20 second timeout

import java.net.Socket
import java.net.InetSocketAddress

% Default timeout when not provided
if nargin < 3
    timeoutSecs = 1;
end
% Default host when not provided
if nargin < 2
    host = "localhost";
end

TF = true;

% Try MATLAB tcpclient first for modern releases (R2019b+)
try
    tcpclient(host, port, 'Timeout', timeoutSecs);
    return
catch
    % tcpclient failed; fallback to Java socket (works on many MATLAB versions)
end

try %#ok<TRYNC>
    % Use a Java Socket with a millisecond timeout
    s = Socket();
    addr = InetSocketAddress(host, port);
    s.connect(addr, round(timeoutSecs*1000));  % timeout in ms
    s.close();
    return
end

% If we reach here, the port is not open
TF = false;

end
