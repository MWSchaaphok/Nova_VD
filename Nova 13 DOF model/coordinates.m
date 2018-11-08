%% Coordinates Function
%  Author: Marianne Schaaphok
%  Date:   2-11-2018
%  Last edited: 
%  Based on model by W. Ooms 

%  This function gives the generalized coordinates of the bike and lets the user choose
%  between different configurations by input of the function. 
%  Possible options are '' 'novabike09' 
function q = coordinates()
%--------------------------------qi----------------------------------------
    q(1) = 0;%0.558123872263452+0.081672082894096 ;    % x-position 
    q(2) = 0 ;                                      % y-position
    q(3) = 0.670744189904527 ;                      % z-position
    q(4) = 0 ;                                      % rear yaw
    q(5) = 0;                                       % rear roll/camber
    q(6) = -0.35 ;                                  % rear pitch
    %q(7) = 0 ;                                      % steering
    q(7) = 0 ;                                      % front yaw
    q(8) = 0 ;                                      % front roll/camber
    q(9) = q(6) ;                                   % front pitch

    q(10) =  0.0175 ;                                % swingarm
    q(11) =  0.38 ;                                  % front fork
    
    q(12) = 0 ;                                      % rear wheel (rotation)
    q(13) = 0 ;                                      % front wheel rotation
   %-------------------------------dqi/dt----------------------------------
    q(14) = 16.07;                                  % x-velocity
    q(15) = 0;                                      % y-velocity
    q(16) = 0;                                      % z-velocity  of CM ?

    q(17) = 0;                                      % rear yaw rate
    q(18) = 0;                                      % rear roll rate
    q(19) = 0;                                      % rear pitch rate

    %q(21) = 0;                                      % steering rate

    q(20) = 0;                                      % front yaw rate
    q(21) = 0;                                      % front roll rate
    q(22) = 0;                                      % front pitch rate

    q(23) = 0;                                      % swing arm rate
    q(24) = 0;                                      % front fork rate

    q(25) = 16.07/.303;                             % rear wheel angular velocity
    q(26) = 16.07/.288;                             % front wheel angular velocity
% %--------------------------------qi----------------------------------------
%     q.qx = 0.558123872263452+0.081672082894096 ;    % x-position 
%     q.qy = 0 ;                                      % y-position
%     q.qz = 0.670744189904527 ;                      % z-position
%     q.q0 = 0 ;                                      % rear yaw
%     q.q1 = 0;                                       % rear roll/camber
%     q.q2 = -0.35 ;                                  % rear pitch
%     q.q3 = 0 ;                                      % steering
%     q.q4 = 0 ;                                      % front yaw
%     q.q5 = 0 ;                                      % front roll/camber
%     q.q6 = q.q2 ;                                   % front pitch
% 
%     q.q7 =  0.0175 ;                                % swingarm
%     q.qf =  0.38 ;                                  % front fork
% 
%     q.q8 = 0 ;                                      % rear wheel (rotation)
%     q.q9 = 0 ;                                      % front wheel rotation
%    %-------------------------------dqi/dt----------------------------------
%     q.qxd = 16.07;                                  % x-velocity
%     q.qyd = 0;                                      % y-velocity
%     q.qzd = 0;                                      % z-velocity  of CM ?
% 
%     q.q0d = 0;                                      % rear yaw rate
%     q.q1d = 0;                                      % rear roll rate
%     q.q2d = 0;                                      % rear pitch rate
% 
%     q.q3d = 0;                                      % steering rate
% 
%     q.q4d = 0;                                      % front yaw rate
%     q.q5d = 0;                                      % front roll rate
%     q.q6d = 0;                                      % front pitch rate
% 
%     q.q7d = 0;                                      % swing arm rate
%     q.qfd = 0;                                      % front fork rate
% 
%     q.q8d = 16.07/.303;                             % rear wheel angular velocity
%     q.q9d = 16.07/.288;                             % front wheel angular velocity


end 