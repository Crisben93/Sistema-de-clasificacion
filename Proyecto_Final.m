clc
%clear
%close all

%% Importamos los datos del archivo .mat del ECG y PCG Healthy
ECG_file = fopen('HE1.mat');
ECG_data = fread(ECG_file, inf, '*int16');
PCG_file = fopen('HP1.mat');
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

[pk4,lk4] = findpeaks(ECG_N,ECG_N_t,'MinPeakProminence',1','MinPeakDistance',0.10);

figure('Name','Identificacion Complejo QRS del ECG','NumberTitle','off');
subplot(2,1,2)
plot(ECG_N_t, ECG_N, '-k', lk4, pk4,'o','MarkerEdgeColor','r');
xlabel('Time: $ t $ [s]','Fontweight','bold','Interpreter','LaTex')
ylabel('ECG [mV]','Fontweight','bold','Interpreter','LaTex')
ylim([4 7])
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

p1 = lk4(10);
p2 = lk4(11);

%% Grafica de las muestras del PCG
figure('Name','ECG/PCG Signals','NumberTitle','off');
subplot(2,1,2)
plot(ECG_N_t, ECG_N, '-k', lk4, pk4,'o','MarkerEdgeColor','r');
xlabel('Time: $ t $ [s]','Fontweight','bold','Interpreter','LaTex')
ylabel('ECG [mV]','Fontweight','bold','Interpreter','LaTex')
title('Healthy','Fontweight','bold','Interpreter','LaTex')
ylim([4 7])
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
pi3 = find(PCG_N_t==lk4(4));
pf4 = find(PCG_N_t==lk4(5));
pi5 = find(PCG_N_t==lk4(6));
pf6 = find(PCG_N_t==lk4(7));
pi7 = find(PCG_N_t==lk4(8));
pf8 = find(PCG_N_t==lk4(9));
pi9 = find(PCG_N_t==lk4(10));
pf10 = find(PCG_N_t==lk4(11));
pi11 = find(PCG_N_t==lk4(12));
pf12 = find(PCG_N_t==lk4(13));
pi13 = find(PCG_N_t==lk4(14));
pf14 = find(PCG_N_t==lk4(15));
pi15 = find(PCG_N_t==lk4(16));
pf16 = find(PCG_N_t==lk4(17));
pi17 = find(PCG_N_t==lk4(11));
pf18 = find(PCG_N_t==lk4(12));
pi19 = find(PCG_N_t==lk4(13));
pf20 = find(PCG_N_t==lk4(14));

e1=up(pi1:pf2,1)/max(up(pi1:pf2,1)); while (length(e1)>=1001) e1(1000,:) = []; end; e1=decimate (e1,5);
e2=up(pi3:pf4,1)/max(up(pi3:pf4,1)); while (length(e2)>=1001) e2(1000,:) = []; end; e2=decimate (e2,5);
e3=up(pi5:pf6,1)/max(up(pi:pf6,1)); while (length(e3)>=1001) e3(1000,:) = []; end; e3=decimate (e3,5);
e4=up(pi7:pf8,1)/max(up(pi7:pf8,1)); while (length(e4)>=1001) e4(1000,:) = []; end; e4=decimate (e4,5);
e5=up(pi9:pf10,1)/max(up(pi9:pf10,1)); while (length(e5)>=1001) e5(1000,:) = []; end; e5=decimate (e5,5);
e6=up(pi11:pf12,1)/max(up(pi11:pf12,1)); while (length(e6)>=1001) e6(1000,:) = []; end; e6=decimate (e6,5);
e7=up(pi13:pf14,1)/max(up(pi13:pf14,1)); while (length(e7)>=1001) e7(1000,:) = []; end; e7=decimate (e7,5);
e8=up(pi15:pf16,1)/max(up(pi15:pf16,1)); while (length(e8)>=1001) e8(1000,:) = []; end; e8=decimate (e8,5);
e9=up(pi17:pf18,1)/max(up(pi17:pf18,1)); while (length(e9)>=1001) e9(1000,:) = []; end; e9=decimate (e9,5);
e10=up(pi19:pf20,1)/max(up(pi19:pf20,1)); while (length(e10)>=1001) e10(1000,:) = []; end; e10=decimate (e10,5);
g=length(e2);
t= p1+(0:g-1)*Ts;

%% Grafica de las envolventes
figure('Name','PCG1 Envolventes','NumberTitle','off');

subplot(10,1,1)
%plot(PCG_N_t, PCG_N, '-k');
%hold on
plot(t, e1,'linewidth',1.5);
legend('PCG','up','low')
%xlabel('Time: $ t $ [s]','Fontweight','bold','Interpreter','LaTex')
%ylabel('PCG [mV]','Fontweight','bold','Interpreter','LaTex')
title('Healthy','Fontweight','bold','Interpreter','LaTex')
%ylim([-10e3 10e3])
xlim([min(t) max(t)])
subplot(10,1,2)
plot(t, e2,'linewidth',1.5);
xlim([min(t) max(t)])
subplot(10,1,3)
plot(t, e3,'linewidth',1.5);
xlim([min(t) max(t)])
subplot(10,1,4)
plot(t, e4,'linewidth',1.5);
xlim([min(t) max(t)])
subplot(10,1,5)
plot(t, e5,'linewidth',1.5);
xlim([min(t) max(t)])
subplot(10,1,6)
plot(t, e6,'linewidth',1.5);
xlim([min(t) max(t)])
subplot(10,1,7)
plot(t, e7,'linewidth',1.5);
xlim([min(t) max(t)])
subplot(10,1,8)
plot(t, e8,'linewidth',1.5);
xlim([min(t) max(t)])
subplot(10,1,9)
plot(t, e9,'linewidth',1.5);
xlim([min(t) max(t)])
subplot(10,1,10)
plot(t, e10,'linewidth',1.5);
xlim([min(t) max(t)])
grid on;

%% Guardando las envolventes en una matriz
%dataset = [e1,e2,e3,e4,e5,e6,e7,e8,e9,e10]
%% Guardar datos en el Dataset
%csvwrite('Dataset_1.csv', dataset);
