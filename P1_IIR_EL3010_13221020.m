% Tugas Proyek #1 EL3010 Pengolahan Sinyal Digital : Pole-Zero Placement untuk Bass-Boost Audio Filter
% Nama			: Vanny Alviolani Indriyani
% NIM			: 13221020
% Kelas			: K02
% Nama file		: P1_IIR_EL3010_13221020.m
% Deskripsi		: Filter IIR sebagai bass-boost audio filter dengan koefisien filter dari MATLAB

FS = 44100; % frekuensi sampling 16 kHz
FSPD = FS/2; % setengah frekuensi sampling
FPASS_EDGE = 250; % batas frekuensi cut-off
FSTOP_EDGE = 750; % batas frekuensi stop-band
MIN_ATTEN = 12; % stop band attenuation minimal
FPE_NORM = FPASS_EDGE/FSPD; % frekuensi cut-off (normalized)
FSE_NORM = FSTOP_EDGE/FSPD; % frekuensi cut-off (normalized)

% Desain filter IIR low-pass dengan spesifikasi yang ditentukan
[n,Wn] = buttord(FPE_NORM,FSE_NORM,1,MIN_ATTEN);
% mendapatkan koefisien filter dan memasukkan ke variabel A dan B
[b,a] = butter(n,Wn);
b = 1.258925412*b;

csvwrite('iir_a.txt', a);
csvwrite('iir_b.txt', b);

% Plot respons frekuensi filter IIR
freqz(b,a,1024,44100);

% Membaca file audio yang akan difilter
[y,fs] = audioread("D:\SEMESTER 5\PSD\P1_EL3010_13221020\Hasil Pengujian\P1_Ori_EL3010_13221020.wav");

% Mengaplikasikan filter pada audio
audioFiltered = filter(b, a, y);

% Menulis kembali audio yang telah difilter
audiowrite('P1_IIR2_EL3010_13221020.wav', audioFiltered, fs);

