%L0325025_FIRLISYAWALA

function Kasus2GaussSeidel
    clc;
    clear;

    A = [2.5  1.5  5    0.5;
         4    0.75 1    2;
         2    1.5  0.5  6;
         1    4.25 2    0.9];

    b = [161000; 149000; 251500; 173000];

    tebakan = zeros(4,1);
    toleransi = 1e-6;
    maks_iterasi = 1000;

    [harga, konvergen, iterasi] = ...
        GaussSeidel(A, b, tebakan, toleransi, maks_iterasi);

    fprintf('\nHasil Metode Gauss-Seidel:\n');
    fprintf('Jumlah iterasi = %d\n', iterasi);

    if konvergen
        tampilkanHarga(harga);
    else
        fprintf('Metode Gauss-Seidel tidak konvergen.\n');
    end
end

function [x, konvergen, iterasi] = ...
    GaussSeidel(A, b, x, toleransi, maks_iterasi)

    n = length(b);
    konvergen = false;

    for iterasi = 1:maks_iterasi
        x_lama = x;

        for i = 1:n
            jumlah = A(i,1:i-1) * x(1:i-1) + ...
                     A(i,i+1:n) * x_lama(i+1:n);

            x(i) = (b(i) - jumlah) / A(i,i);
        end

        if any(~isfinite(x)) || norm(x, inf) > 1e15
            return;
        end

        if norm(x - x_lama, inf) < toleransi
            konvergen = true;
            return;
        end
    end
end

function tampilkanHarga(harga)
    fprintf('Harga beras   = Rp %.2f/kg\n', harga(1));
    fprintf('Harga telur   = Rp %.2f/kg\n', harga(2));
    fprintf('Harga tepung  = Rp %.2f/kg\n', harga(3));
    fprintf('Harga ayam    = Rp %.2f/kg\n', harga(4));
end
