%L0325025_FIRLISYAWALA

function Kasus1
    clc;
    clear;
    close all;

    % Parameter
    lambda = 12;
    v = 36;
    x = 10;
    h0 = 5;
    t = linspace(0,5,500);
    n = [23 24 25];

    % Menghitung nilai eksak
    h_eksak = hitungNilaiEksak(t, lambda, v, x, h0);

    % Menghitung nilai pendekatan dan galat
    for k = 1:length(n)
        h_approx = hitungPendekatan(t, lambda, v, x, h0, n(k));

        galat = abs(h_eksak - h_approx);
        galat_rerata(k) = mean(galat);

        fprintf('n = %d\n', n(k));
        fprintf('Rerata galat = %.6f\n\n', galat_rerata(k));
    end

    % Menampilkan grafik
    tampilkanHasil(t, h_eksak, lambda, v, x, h0, n);
end

function h = hitungNilaiEksak(t, lambda, v, x, h0)
    h = h0 * (cos(t*v/lambda) + exp(x));
end

function h = hitungPendekatan(t, lambda, v, x, h0, n)
    deret_cos = zeros(size(t));
    deret_exp = 0;

    for i = 0:n-1
        deret_cos = deret_cos + ...
            ((-1)^i .* (t*v/lambda).^(2*i)) ./ factorial(2*i);

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
    legend('Eksak', 'n = 23', 'n = 24', 'n = 25', ...
        'Location', 'best');
    hold off;
end
