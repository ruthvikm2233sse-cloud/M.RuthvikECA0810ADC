% Calculation and Verification of Frequency Deviation
% and Modulation Index of FM Signals
clc;
clear;
close all;
%% Input Parameters
Am = 2; % Message signal amplitude
fm = 500; % Message frequency (Hz)
Ac = 1; % Carrier amplitude

fc = 10000; % Carrier frequency (Hz)
kf = 1000; % Frequency sensitivity (Hz/V)
fs = 100000; % Sampling frequency (Hz)
T = 0.02; % Simulation duration (s)
t = 0:1/fs:T;
%% Message Signal
m = Am*cos(2*pi*fm*t);
%% Frequency Deviation Calculation
delta_f = kf * Am;
%% Modulation Index Calculation
beta = delta_f/fm;
%% FM Signal Generation
fm_signal = Ac*cos(2*pi*fc*t + beta*sin(2*pi*fm*t));
%% Plot Message Signal
figure;
subplot(2,1,1);
plot(t,m,'LineWidth',1.5);
title('Message Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
%% Plot FM Signal
subplot(2,1,2);
plot(t,fm_signal,'LineWidth',1.5);
title('Frequency Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
%% Spectrum Analysis
N = length(fm_signal);
FM_fft = fftshift(abs(fft(fm_signal))/N);
f = (-N/2:N/2-1)*(fs/N);
figure;
plot(f,FM_fft,'LineWidth',1.5);
title('FM Signal Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;
xlim([fc-10000 fc+10000]);
%% Display Results

fprintf('\nFM SIGNAL PARAMETERS\n');
fprintf('---------------------------\n');
fprintf('Carrier Frequency = %.0f Hz\n',fc);
fprintf('Message Frequency = %.0f Hz\n',fm);
fprintf('Message Amplitude = %.2f V\n',Am);
fprintf('Frequency Sensitivity = %.0f Hz/V\n',kf);
fprintf('\nCALCULATED VALUES\n');
fprintf('---------------------------\n');
fprintf('Frequency Deviation (Δf) = %.0f Hz\n',delta_f);
fprintf('Modulation Index (β) = %.2f\n',beta);
%% Carson's Rule Bandwidth
BW = 2*(delta_f + fm);
fprintf('Bandwidth (Carson Rule) = %.0f Hz\n',BW);
