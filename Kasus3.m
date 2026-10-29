%L0325025_FIRLISYAWALA

function Kasus3
    clc;
    clear;
    close all;

    % Volume bola diketahui 300 cm^3
    f = @(r) (4/3)*pi*r.^3 - 300;

    % Grafik untuk menentukan interval awal
    r = linspace(0,6,500);
    y = f(r);

    figure;
    plot(r, y, 'b', 'LineWidth', 1.5);
    hold on;
    plot(r, zeros(size(r)), 'k--');

    grid on;
    xlabel('Jari-jari (cm)');
    ylabel('f(r)');
    title('Grafik Persamaan Nonlinear Volume Bola');
    legend('f(r)', 'y = 0', 'Location', 'best');

    hold off;

    % Interval awal berdasarkan grafik
    a = 4;
    b = 5;
    maks_iterasi = 100;
    toleransi = 1e-6;

    fprintf('Volume bola diketahui = 300 cm^3\n');
    fprintf('Persamaan: (4/3)*pi*r^3 - 300 = 0\n');
    fprintf('Interval awal: [%.1f, %.1f]\n', a, b);

    % Metode Biseksi
    fprintf('\n=== METODE BISEKSI ===\n');

    tic;
    akar_biseksi = Biseksi(f, a, b, ...
        maks_iterasi, toleransi);
    waktu_biseksi = toc;

    fprintf('Jari-jari = %.6f cm\n', akar_biseksi);
    fprintf('Waktu eksekusi = %.6f detik\n', waktu_biseksi);

    % Volume tabung di luar bola
    volume_luar_biseksi = (2/3)*pi*akar_biseksi^3;

    fprintf('Volume tabung di luar bola = %.6f cm^3\n', ...
        volume_luar_biseksi);

    % Metode Regula Falsi
    fprintf('\n=== METODE REGULA FALSI ===\n');

    tic;
    akar_regula = RegulaFalsi(f, a, b, ...
        maks_iterasi, toleransi);
    waktu_regula = toc;

    fprintf('Jari-jari = %.6f cm\n', akar_regula);
    fprintf('Waktu eksekusi = %.6f detik\n', waktu_regula);

    % Volume tabung di luar bola
    volume_luar_regula = (2/3)*pi*akar_regula^3;

    fprintf('Volume tabung di luar bola = %.6f cm^3\n', ...
        volume_luar_regula);
end

function akar = Biseksi(f, a, b, maks_iterasi, toleransi)

    if f(a)*f(b) >= 0
        error('Interval tidak memenuhi syarat metode Biseksi.');
    end

    for i = 1:maks_iterasi
        c = (a+b)/2;
        fc = f(c);

        fprintf(['Iterasi %d: a=%.6f, b=%.6f, ' ...
            'c=%.6f, f(c)=%.6f\n'], ...
            i, a, b, c, fc);

        if abs(fc) < toleransi || (b-a)/2 < toleransi
            akar = c;
            return;
        end

        if f(a)*fc < 0
            b = c;
        else
            a = c;
        end
    end

    akar = (a+b)/2;
end

function akar = RegulaFalsi(f, a, b, maks_iterasi, toleransi)

    if f(a)*f(b) >= 0
        error(['Interval tidak memenuhi syarat ' ...
            'metode Regula Falsi.']);
    end

    c_lama = a;

    for i = 1:maks_iterasi
        c = (a*f(b)-b*f(a))/(f(b)-f(a));
        fc = f(c);

        fprintf(['Iterasi %d: a=%.6f, b=%.6f, ' ...
            'c=%.6f, f(c)=%.6f\n'], ...
            i, a, b, c, fc);

        if abs(fc) < toleransi || abs(c-c_lama) < toleransi
            akar = c;
            return;
        end

        if f(a)*fc < 0
            b = c;
        else
            a = c;
        end

        c_lama = c;
    end

    akar = c;
end
