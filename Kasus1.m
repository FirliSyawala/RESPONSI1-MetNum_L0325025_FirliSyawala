%L0325025_FIRLISYAWALA

function Kasus1
    clc;
    clear;
    close all;

    % Parameter sesuai soal
    lambda = 12;
    v = 36;
    x = 10;
    h0 = 5;
    t = linspace(0,5,500);
    n = [23 24 25];

    % Nilai eksak
    h_eksak = hitungNilaiEksak(t, lambda, v, x, h0);

    % Menghitung galat
    galat_rerata = zeros(size(n));
    galat_persen = zeros(size(n));

    fprintf('HASIL PERBANDINGAN NILAI EKSAK DAN PENDEKATAN\n');
    fprintf('Toleransi galat relatif rata-rata = 1%%\n\n');

    for k = 1:length(n)
        h_approx = hitungPendekatan(t, lambda, v, x, h0, n(k));

        galat = abs(h_eksak - h_approx);
        galat_rerata(k) = mean(galat);

        galat_relatif = galat ./ abs(h_eksak) * 100;
        galat_persen(k) = mean(galat_relatif);

        fprintf('n = %d\n', n(k));
        fprintf('Rerata galat mutlak = %.10f\n', ...
            galat_rerata(k));
        fprintf('Rerata galat relatif = %.6f%%\n', ...
            galat_persen(k));

        if galat_persen(k) <= 1
            fprintf('Kesimpulan: memenuhi toleransi 1%%.\n\n');
        else
            fprintf('Kesimpulan: tidak memenuhi toleransi 1%%.\n\n');
        end
    end

    tampilkanHasil(t, h_eksak, lambda, v, x, h0, n);
end

function h = hitungNilaiEksak(t, lambda, v, x, h0)
    h = h0 * (cos(t*v/lambda) + exp(x));
end

function h = hitungPendekatan(t, lambda, v, x, h0, n)
    z = t*v/lambda;
    deret_cos = zeros(size(t));
    deret_exp = 0;

    % Deret Taylor untuk cos(z) dan exp(x)
    for i = 0:n-1
        deret_cos = deret_cos + ...
            ((-1)^i .* z.^(2*i)) ./ factorial(2*i);

        deret_exp = deret_exp + x^i/factorial(i);
    end

    h = h0 * (deret_cos + deret_exp);
end

function tampilkanHasil(t, h_eksak, lambda, v, x, h0, n)
    figure;
    plot(t, h_eksak, 'k', 'LineWidth', 2);
    hold on;

    warna = {'r--', 'b--', 'g--'};

    for k = 1:length(n)
        h = hitungPendekatan(t, lambda, v, x, h0, n(k));
        plot(t, h, warna{k}, 'LineWidth', 1.5);
    end

    grid on;
    xlabel('Waktu (t)');
    ylabel('Ketinggian gelombang (h)');
    title('Perbandingan Nilai Eksak dan Pendekatan');
    legend('Eksak', 'n = 23', 'n = 24', ...
        'n = 25', 'Location', 'best');

    hold off;
end
