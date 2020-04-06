function Psa=Psa_new(Psa_old,QAo)
%filename:   Psa_new.m
global Rs Csa dt; %Get parsmeters from other file
Psa=(Psa_old+dt*QAo/Csa)/(1+dt/(Rs*Csa)); %function of the pressure of systemic arterial
