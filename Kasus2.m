%L0325025_FIRLISYAWALA

function Kasus2
    clc;
    clear;

    A = [2.5  1.5  5    0.5;
         4    0.75 1    2;
         2    1.5  0.5  6;
         1    4.25 2    0.9];

    b = [161000; 149000; 251500; 173000];

    harga = GaussJordan(A, b);

    fprintf('\nHasil Metode Gauss-Jordan:\n');
    tampilkanHarga(harga);
end

function x = GaussJordan(A, b)
    n = length(b);
    Ab = [A b];

    for i = 1:n
        Ab(i,:) = Ab(i,:) / Ab(i,i);

        for j = 1:n
            if j ~= i
                Ab(j,:) = Ab(j,:) - Ab(j,i) * Ab(i,:);
            end
        end
    end

    x = Ab(:,end);
end

function tampilkanHarga(harga)
    fprintf('Harga beras   = Rp %.2f/kg\n', harga(1));
    fprintf('Harga telur   = Rp %.2f/kg\n', harga(2));
    fprintf('Harga tepung  = Rp %.2f/kg\n', harga(3));
    fprintf('Harga ayam    = Rp %.2f/kg\n', harga(4));
end
