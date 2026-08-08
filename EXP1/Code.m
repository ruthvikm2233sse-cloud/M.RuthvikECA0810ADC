clc;
clear;
close all;

% Message Signal Parameters
Am = 1;
fm = 500;

% Carrier Signal Parameters
Ac = 5;
fc = 5000;

% Sampling Frequency
fs = 20*fc;

% Time Vector
t = 0:1/fs:10/fm;

% Message Signal
m = Am*sin(2*pi*fm*t);

% Carrier Signal
c = Ac*cos(2*pi*fc*t);

% Modulation Index
mu = Am/Ac;

% AM Signal
am = Ac*(1 + mu*sin(2*pi*fm*t)).*cos(2*pi*fc*t);

% Demodulation (Envelope Detector without hilbert)
dem = abs(am);
dem = filter(ones(1,50)/50,1,dem);
dem = dem - mean(dem);

% FFT Analysis
N = length(am);
f = (-N/2:N/2-1)*(fs/N);
AM_FFT = abs(fftshift(fft(am)))/N;

% Sideband Frequencies
USB = fc + fm;
LSB = fc - fm;

% Power Calculations
Pc = Ac^2/2;
Psb = (mu^2*Pc)/4;

% Plotting
figure('Name','AM Modulation','NumberTitle','off');

subplot(3,2,1);
plot(t,m,'b','LineWidth',1.5);
title('Message Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,2,2);
plot(t,c,'r','LineWidth',1.5);
title('Carrier Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,2,3);
plot(t,am,'m','LineWidth',1.5);
title('AM Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,2,4);
plot(t,dem,'g','LineWidth',1.5);
title('Demodulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,2,5);
plot(f,AM_FFT,'k','LineWidth',1.5);
xlim([fc-3*fm fc+3*fm]);
title('AM Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

subplot(3,2,6);
bar([Pc Psb Psb]);
set(gca,'XTick',1:3);
set(gca,'XTickLabel',{'Carrier','USB','LSB'});
title('Power Distribution');
ylabel('Power (W)');
grid on;

% Display Results
fprintf('\n******** AM MODULATION RESULTS ********\n');
fprintf('Modulation Index (mu) = %.2f\n',mu);
fprintf('Carrier Frequency      = %d Hz\n',fc);
fprintf('Message Frequency      = %d Hz\n',fm);
fprintf('Upper Sideband         = %d Hz\n',USB);
fprintf('Lower Sideband         = %d Hz\n',LSB);
fprintf('Carrier Power          = %.2f W\n',Pc);
fprintf('Each Sideband Power    = %.3f W\n',Psb);
fprintf('***************************************\n');
