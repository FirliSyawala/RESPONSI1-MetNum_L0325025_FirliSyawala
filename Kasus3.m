%L0325025_FIRLISYAWALA

function Kasus3
    clc;
    clear;
    close all;

    % Persamaan nonlinear
    f = @(r) (2/3)*pi*r.^3 - 300;

    % Membuat grafik untuk menentukan interval awal
    r = linspace(0,10,500);
    y = f(r);

    figure;
    plot(r,y,'b','LineWidth',1.5);
    hold on;
    plot(r,zeros(size(r)),'k--');
    grid on;
    xlabel('Jari-jari (cm)');
    ylabel('f(r)');
    title('Grafik Persamaan Nonlinear');
    legend('f(r)','y = 0','Location','best');
    hold off;

    % Parameter metode
    a = 0;
    b = 10;
    maks_iterasi = 100;
    toleransi = 1e-6;

    % Metode Biseksi
    fprintf('\n=== METODE BISEKSI ===\n');
    tic;
    akar_biseksi = Biseksi(f,a,b,maks_iterasi,toleransi);
    waktu_biseksi = toc;
    fprintf('Akar Biseksi = %.6f cm\n',akar_biseksi);
    fprintf('Waktu eksekusi = %.6f detik\n',waktu_biseksi);

    % Metode Regula Falsi
    fprintf('\n=== METODE REGULA FALSI ===\n');
    tic;
    akar_regula = RegulaFalsi(f,a,b,maks_iterasi,toleransi);
    waktu_regula = toc;
    fprintf('Akar Regula Falsi = %.6f cm\n',akar_regula);
    fprintf('Waktu eksekusi = %.6f detik\n',waktu_regula);
end

function akar = Biseksi(f,a,b,maks_iterasi,toleransi)
    if f(a)*f(b) >= 0
        error('Interval tidak memenuhi syarat metode Biseksi.');
    end

    for i = 1:maks_iterasi
        c = (a+b)/2;
        fc = f(c);

        fprintf('Iterasi %d: a=%.6f, b=%.6f, c=%.6f, f(c)=%.6f\n', ...
            i,a,b,c,fc);

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

function akar = RegulaFalsi(f,a,b,maks_iterasi,toleransi)
    if f(a)*f(b) >= 0
        error('Interval tidak memenuhi syarat metode Regula Falsi.');
    end

    c_lama = a;

    for i = 1:maks_iterasi
        c = (a*f(b)-b*f(a))/(f(b)-f(a));
        fc = f(c);

        fprintf('Iterasi %d: a=%.6f, b=%.6f, c=%.6f, f(c)=%.6f\n', ...
            i,a,b,c,fc);

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
