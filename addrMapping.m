function coordinate = addrMapping (addr)
    switch addr
        case 0
            coordinate = [0, 0, 0];
        case 1
            coordinate = [0, 1, 0];
        case 2
            coordinate = [0, 2, 0];
        case 3
            coordinate = [0, 3, 0];
        case 4
            coordinate = [1, 0, 0];
        case 5
            coordinate = [1, 1, 0];
        case 6
            coordinate = [1, 2, 0];
        case 7
            coordinate = [1, 3, 0];
        case 8    
            coordinate = [2, 0, 0];
        case 9
            coordinate = [2, 1, 0];
        case 10
            coordinate = [2, 2, 0];
        case 11
            coordinate = [2, 3, 0];
        case 12
            coordinate = [3, 0, 0];
        case 13
            coordinate = [3, 1, 0];
        case 14
            coordinate = [3, 2, 0];
        case 15
            coordinate = [3, 3, 0];
        otherwise
            disp ('Only support 16 cores');
    end
end