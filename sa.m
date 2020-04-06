%filename: sa.m
clear all % clear all variables
clf       % and figures
global T TS TMAX QMAX; %get variables from other scrips
global Rs Csa changeindt dt; %get variables from other scrips
in_sa; %initialization
Csa=Csa/2;
changeindt=0.0000:0.0001:0.001;
errorarray=[];
t_arrest=0.01
t_restart=0.05
for i=1:11
    dt=changeindt(i)*T
    for klok=1:klokmax
        t=klok*dt; %at each unit of time
        if t>t_arrest && t<t_restart
            QAo=0
        else
            QAo=QAo_now(t);%flow of arterial (opening)
        end
        Psa=Psa_new(Psa,QAo); %new Psa overwrites old
        %Store values in arrays for future plotting:
        t_plot(klok)=t; %building array for time
        QAo_plot(klok)=QAo;%building array for flow of arterial (opening)
        Psa_plot(klok)=Psa;%building array for pressure of systemic arterial
    end
    %Now plot results in one figure
    %with QAo(t) in upper frame
    % and Psa(t) in lower frame
    larger=max(Psa_plot); %find the global maximum
    pks=findpeaks(Psa_plot) % find the local maxima
    error=100*(abs(80-Psa))/80; %find error in %
    
    subplot(2,1,1), plot(t_plot,QAo_plot) %plot the graph of t vs QAo
    subplot(2,1,2), plot(t_plot,Psa_plot) %plot the graph of t vs Psa
    
    errorarray=[errorarray error];% sort into an array
end
errorarray %display error array in %
last=pks(end); %find the last local maxima of the Psa
for j=1:length(pks) %loop the number of peaks
    if abs(pks(j)-last)/last <=  0.01 % if next peak value is smaller than 1% variation of previous value
        stable_state=pks(j); %choose that value as stable state
        break
    else
        continue
    end
end
display(stable_state);
number_of_itrations = find(pks==stable_state); %locate the number of beats
time_to_stable=(T+TS)*number_of_itrations; %find the time (minutes)
display(time_to_stable)