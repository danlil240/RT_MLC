 command = 'ssh admin@172.22.11.2';
[status, cmdout] = system(command);
% That will not work if server and client are not set up for password-less login
% Execute commands here
command = 'ls';
[status, cmdout] = system(command);
% 'status' is  0 if the command was successfully executed
%             ~0 otherwise
% 'cmdout' is the output of executing the command
% Close connection once tests are over
[status, cmdout] = system('exit');

sshfrommatlab('admin','172.22.11.2','\n')