% Tugas Proyek #1 EL3010 Pengolahan Sinyal Digital : Pole-Zero Placement untuk Bass-Boost Audio Filter
% Nama			: Vanny Alviolani Indriyani
% NIM			: 13221020
% Kelas			: K02
% Nama file		: P1_FIR_EL3010_13221020.m
% Deskripsi		: Filter FIR sebagai bass-boost audio filter dengan koefisien filter dari MATLAB

% Frekuensi sampling
fs = 44100;

% Orde filter
order = 16;

% Rentang frekuensi pass-band (Hz)
passband_freqs = [50, 125];

% Normalisasi frekuensi pass-band
normalized_passband_freqs = passband_freqs / (fs/2);

% Koefisien filter FIR
FIR_B = fir1(order, normalized_passband_freqs, 'bandpass');
FIR_B_2 = conv(FIR_B, FIR_B);
FIR_B_3 = 5.956621435*(conv(FIR_B_2, FIR_B_2)); % dilakukan penguatan sebesar 15.5 dB agar terjadi efek bass-boost

csvwrite('fir_b.txt', FIR_B_3);

% Plot respons frekuensi filter FIR
freqz(FIR_B_3,1,1024,44100);

% Membaca file audio yang akan difilter
[y,fs] = audioread("D:\SEMESTER 5\PSD\P1_EL3010_13221020\Hasil Pengujian\P1_Ori_EL3010_13221020.wav");
y = 0.2*y; % dilakukan pengurangan volume audio asli agar terdapat ruang untuk bass-bost sehingga hasil bass-boost tidak pecah

% Mengaplikasikan filter pada audio
audioFiltered = filter(FIR_B_3, 1, y);

% Menulis kembali audio yang telah difilter
audiowrite('P1_FIR_EL3010_13221020.wav', audioFiltered, fs);