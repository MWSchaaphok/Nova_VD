%% Parameter Function
%  Author: Marianne Schaaphok
%  Date:   2-11-2018
%  Last edited: 
%  Based on model by W. Ooms 

%  This function gives the parameters of the bike and lets the user choose
%  between different configurations by input of the function. 
%  Possible options are '' 'novabike09' 
function p = parameters()
% rear wheel parameters__________________________________________
            % parameters relating to the shape
                p(1) = .09 ;            % crown radius
                p(2) = .3149-.09 ;      % centerline radius
            % dynamic parameters
                p(3) = 16.85 ;          % mass
                p(4) = .8380 ;          % inertia around rotation axis
                p(5) = .4796 ;          % inertia around the other two axes
            % parameters relating to the interaction forces
                p(6) = 20 ;             % friction coefficient
                p(7) = 1 ;              % rolling resistance coefficient
                p(8) = 1e6 ;            % normal force stiffness
                p(9) = 1500 ;           % normal force damping
                p(10) = 1 ;              % tangential stiffness (for numerical stability)

        % rear suspension % parameters_________________________________________
            % shape parameters
                p(11) = 0.5675 ;         % swingarm length
            % dynamic parameters
                p(12) = 19.31 ;          % mass
                p(13) = .2 ;             % mass local x position
                p(14) = .8 ;             % inertia (average inertia to reduce parameter set)
            % parameters relating to the interaction forces
                p(15) = 1 ;              % top end
                p(16) = 1000 ;           % bottom end
                p(17) = 1 ;              % preload damping
                p(18) = 1 ;              % compression damping
                p(19) = 1 ;              % rebound damping
                p(20) = 20000 ;          % spring stiffness
                p(21) = 1 ;              % spring progressiveness
                p(22) = 1 ;              % friction coefficient

        % main frame parameters (sprung)________________________________
            % shape parameters
                p(23) = 0.81663099159224 ; % frame length (perpendicular distance from steering head to swingarm rotation point)
            % dynamic parameters
                p(24) = 224.2+78.13 ;    % mass
                p(25) = .31 ;            % mass local x position
                p(26) = 0.3 ;            % mass local z position
                p(27) = 30 ;             % inertia (average inertia to reduce parameter set)
                p(28) = 1e9 ;            % frame torsion stiffness (together with fork and swingarm)
                p(29) = 1 ;              % frame torsion damping (together with fork and swingarm)

        % steering head parameters (sprung)_____________________________
            % shape parameters
                p(30) = 0.0198 ;         % fork offset
            % dynamic parameters
                p(31) = 9.09 ;           % mass
                p(32) = 0.036 ;          % mass local x position
                p(33) = 0.2235 + 0.09985863931372 ; % mass local z position
                p(34) = .5 ;             % inertia (average inertia to reduce parameter set)

        % front fork/suspension parameters (unsprung)____________________
            % dynamic parameters
                p(35) = 9.02 ;           % mass
                p(36) = -0.0114 ;        % mass local x position
                p(37) = 0.15 ;           % mass local z position
                p(38) = .3 ;             % inertia (average inertia to reduce parameter set)
            % parameters relating to the interaction forces
                p(39) = .5 ;             % top end
                p(40) = .3 ;             % bottom end
                p(41) = 0.45 ;           % preload damping
                p(42) = 6500 ;           % compression damping
                p(43) = 12000 ;          % rebound damping
                p(44) = 15000 ;          % spring stiffness
                p(45) = 1 ;              % spring progressiveness
                p(46) = 1 ;              % friction coefficient

        % front wheel parameters_________________________________________
            % parameters relating to the shape
                p(47) = .06 ;            % crown radius
                p(48) = .2999-.06 ;      % centerline radius
     
            % dynamic parameters
                p(49) = 13.57 ;          % mass
                p(50) = .5020 ;          % inertia around rotation axis
                p(51) = .333 ;           % inertia around the other two axes
            % parameters relating to the interaction forces
                p(52) = 20 ;             % friction coefficient
                p(53) = 1 ;              % rolling resistance coefficient
                p(54) = 1 ;              % normal force stiffness
                p(55) = 1 ;              % normal force damping
                p(56) = 2000 ;           % tangential stiffness (for numerical stability)
                            

p(57) = rand ;
p(58) = rand ;
p(59) = rand ;
p(60) = rand ; % x-position IMU sensor
p(61) = rand ; % y-position IMU sensor
p(62) = rand ; % z-position IMU sensor 
% % rear wheel parameters__________________________________________
%             % parameters relating to the shape
%                 p.a1 = .09 ;            % crown radius
%                 p.b1 = .3149-.09 ;      % centerline radius
%             % dynamic parameters
%                 p.m1 = 16.85 ;          % mass
%                 p.i1 = .8380 ;          % inertia around rotation axis
%                 p.j1 = .4796 ;          % inertia around the other two axes
%             % parameters relating to the interaction forces
%                 p.f1 = 20 ;             % friction coefficient
%                 p.e1 = 1 ;              % rolling resistance coefficient
%                 p.k1 = 1e6 ;            % normal force stiffness
%                 p.d1 = 1500 ;           % normal force damping
%                 p.t1 = 1 ;              % tangential stiffness (for numerical stability)
% 
%         % rear suspension % parameters_________________________________________
%             % shape parameters
%                 p.l2 = 0.5675 ;         % swingarm length
%             % dynamic parameters
%                 p.m2 = 19.31 ;          % mass
%                 p.x2 = .2 ;             % mass local x position
%                 p.i2 = .8 ;             % inertia (average inertia to reduce parameter set)
%             % parameters relating to the interaction forces
%                 p.t2 = 1 ;              % top end
%                 p.b2 = 1000 ;           % bottom end
%                 p.p2 = 1 ;              % preload damping
%                 p.d2 = 1 ;              % compression damping
%                 p.e2 = 1 ;              % rebound damping
%                 p.k2 = 20000 ;          % spring stiffness
%                 p.n2 = 1 ;              % spring progressiveness
%                 p.f2 = 1 ;              % friction coefficient
% 
%         % main frame parameters (sprung)________________________________
%             % shape parameters
%                 p.l3 = 0.81663099159224 ; % frame length (perpendicular distance from steering head to swingarm rotation point)
%             % dynamic parameters
%                 p.m3 = 224.2+78.13 ;    % mass
%                 p.x3 = .31 ;            % mass local x position
%                 p.z3 = 0.3 ;            % mass local z position
%                 p.i3 = 30 ;             % inertia (average inertia to reduce parameter set)
%                 p.k3 = 1e9 ;            % frame torsion stiffness (together with fork and swingarm)
%                 p.d3 = 1 ;              % frame torsion damping (together with fork and swingarm)
% 
%         % steering head parameters (sprung)_____________________________
%             % shape parameters
%                 p.l4 = 0.0198 ;         % fork offset
%             % dynamic parameters
%                 p.m4 = 9.09 ;           % mass
%                 p.x4 = 0.036 ;          % mass local x position
%                 p.z4 = 0.2235 + 0.09985863931372 ; % mass local z position
%                 p.i4 = .5 ;             % inertia (average inertia to reduce parameter set)
% 
%         % front fork/suspension parameters (unsprung)____________________
%             % dynamic parameters
%                 p.m5 = 9.02 ;           % mass
%                 p.x5 = -0.0114 ;        % mass local x position
%                 p.z5 = 0.15 ;           % mass local z position
%                 p.i5 = .3 ;             % inertia (average inertia to reduce parameter set)
%             % parameters relating to the interaction forces
%                 p.t5 = .5 ;             % top end
%                 p.b5 = .3 ;             % bottom end
%                 p.p5 = 0.45 ;           % preload damping
%                 p.d5 = 6500 ;           % compression damping
%                 p.e5 = 12000 ;          % rebound damping
%                 p.k5 = 15000 ;          % spring stiffness
%                 p.n5 = 1 ;              % spring progressiveness
%                 p.f5 = 1 ;              % friction coefficient
% 
%         % front wheel parameters_________________________________________
%             % parameters relating to the shape
%                 p.a6 = .06 ;            % crown radius
%                 p.b6 = .2999-.06 ;      % centerline radius
%      
%             % dynamic parameters
%                 p.m6 = 13.57 ;          % mass
%                 p.i6 = .5020 ;          % inertia around rotation axis
%                 p.j6 = .333 ;           % inertia around the other two axes
%             % parameters relating to the interaction forces
%                 p.f6 = 20 ;             % friction coefficient
%                 p.e6 = 1 ;              % rolling resistance coefficient
%                 p.k6 = 1 ;              % normal force stiffness
%                 p.d6 = 1 ;              % normal force damping
%                 p.t6 = 2000 ;           % tangential stiffness (for numerical stability)
%                             
% 
% p.u7 = rand ;
% p.v7 = rand ;
% p.w7 = rand ;
% p.x7 = rand ; % x-position IMU sensor
% p.y7 = rand ; % y-position IMU sensor
% p.z7 = rand ; % z-position IMU sensor 



end 