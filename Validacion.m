clc
clear
close all

%% Importamos los datos del archivo .mat del ECG y PCG Healthy
ECG_file = fopen('EE10.mat');
ECG_data = fread(ECG_file, inf, '*int16');
PCG_file = fopen('EP10.mat');
PCG_data = fread(PCG_file, inf, '*int16');
fclose(ECG_file);
fclose(PCG_file);

%% Señal en el dominio del tiempo
Fs = 2000; % Frecuencia de muestreo ECG y PCG
Ts = 1/Fs; % Periodo de muestreo ECG y PCG
G = 1000; % Ganancia ECG
G2 = 1; % Ganancia PCG

%% Healthy
ECG_N = double(ECG_data(1:1:end))/G; % Señal en mV
L = length(ECG_N); % Tamaño del vector
ECG_N_t = Ts*(0:L-1); % Vector de tuempos de la señal

PCG_N = double(PCG_data(1:1:end))/G2; % Señal en mV
L2 = length(PCG_N); % Tamaño del vector
PCG_N_t = Ts*(0:L2-1); % Vector de tuempos de la señal

%% Se�ales ECG con identificacion del complejo QRS

[pk4,lk4] = findpeaks(ECG_N,ECG_N_t,'MinPeakProminence',0.7','MinPeakDistance',0.1);

figure('Name','Identificacion Complejo QRS del ECG','NumberTitle','off');
subplot(2,1,2)
plot(ECG_N_t, ECG_N, '-k', lk4, pk4,'o','MarkerEdgeColor','r');
xlabel('Time: $ t $ [s]','Fontweight','bold','Interpreter','LaTex')
ylabel('ECG [mV]','Fontweight','bold','Interpreter','LaTex')
ylim([2 7])
xlim([0 10])
grid on;

subplot(2,1,1)
plot(PCG_N_t, PCG_N, '-k');
xlabel('Time: $ t $ [s]','Fontweight','bold','Interpreter','LaTex')
ylabel('PCG [mV]','Fontweight','bold','Interpreter','LaTex')
title('Healthy','Fontweight','bold','Interpreter','LaTex')
ylim([-10e3 10e3])
xlim([0 10])
grid on;


%% Un ciclo PCG

p1 = lk4(7);
p2 = lk4(8);

%% Grafica de las muestras del PCG
figure('Name','ECG/PCG Signals','NumberTitle','off');
subplot(2,1,2)
plot(ECG_N_t, ECG_N, '-k', lk4, pk4,'o','MarkerEdgeColor','r');
xlabel('Time: $ t $ [s]','Fontweight','bold','Interpreter','LaTex')
ylabel('ECG [mV]','Fontweight','bold','Interpreter','LaTex')
title('Healthy','Fontweight','bold','Interpreter','LaTex')
ylim([-4 7])
xlim([p1 p2])
grid on;

subplot(2,1,1)
plot(PCG_N_t, PCG_N, '-k');
xlabel('Time: $ t $ [s]','Fontweight','bold','Interpreter','LaTex')
ylabel('PCG [mV]','Fontweight','bold','Interpreter','LaTex')
title('Healthy','Fontweight','bold','Interpreter','LaTex')
ylim([-10e3 10e3])
xlim([p1 p2])
grid on;

%% Envolventes

[up,low] = envelope(PCG_N); % Calculo de la envolvente - Healthy

%% Recortando las envolventes

pi1 = find(PCG_N_t==lk4(2));
pf2 = find(PCG_N_t==lk4(3));

e1=up(pi1:pf2,1)/max(up(pi1:pf2,1)); while (length(e1)>=1001) e1(1000,:) = []; end; e1=decimate (e1,5);
g=length(e1);
t= p1+(0:g-1)*Ts;

%% Grafica de las envolventes
figure('Name','PCG1 Envolventes','NumberTitle','off');

subplot(1,1,1)
%plot(PCG_N_t, PCG_N, '-k');
%hold on
plot(t, e1,'linewidth',1.5);
legend('PCG','up','low')
%xlabel('Time: $ t $ [s]','Fontweight','bold','Interpreter','LaTex')
%ylabel('PCG [mV]','Fontweight','bold','Interpreter','LaTex')
title('Healthy','Fontweight','bold','Interpreter','LaTex')
%ylim([-10e3 10e3])
xlim([min(t) max(t)])
grid on;

%%
red = load('NN_t.mat');
red_N = red.NN_t;

%%
test = sim(red_N,e1)
if test>0.5
    Res = ('Sano')
else
    Res = ('Enfermo')
end