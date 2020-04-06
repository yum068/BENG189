function Q=QAo_now(t)
%filename: QAo_now.m
global T TS TMAX QMAX; %get variables from other scrips
tc=rem(t,T); % tc=time elapsed since 
%the beginning of the current cycle
%rem(t,T) is the remainder when t is divided by T
if(tc<TS) % At the time when time elapsed is smaller than systole
  %SYSTOLE:
  if(tc<TMAX) % At the time when time elapsed is smaller than TMAX
    %BEFORE TIME OF MAXIMUM FLOW:
    Q=QMAX*tc/TMAX; % Flow with respect to tc when tc is less than TMAX
  else
    %AFTER TIME OF PEAK FLOW:
    Q=QMAX*(TS-tc)/(TS-TMAX);% Flow with respect to tc when tc is more than TMAX
  end
else
  %DIASTOLE:
  Q=0; % is time elapses is smaller then systole, flow is 0
end
