clc;
clear;

in_file = fopen ('D:/TracePARSEC/raw/dedup.txt', 'r');
out_file = fopen ('D:/TracePARSEC/topaz/dedup.trace', 'w');
NUM_PKT = 40000000; % 0 - run to completion
numPkt = 0;

start = 1;
startTime = 0;
tline = fgets (in_file);
while (tline ~= -1)
    A = sscanf (tline, '%lu %d %d %d');
    time_temp = A (1);
    src_temp = A(2);
    dst_temp = A(3);
    size = A(4);
    if (start == 1)
        startTime = time_temp;
        start = 0;
    end
    
    if (src_temp ~= dst_temp)
        numPkt = numPkt + 1;
        time = time_temp - startTime + 1;
        src_coordinate = addrMapping (src_temp);
        dst_coordinate = addrMapping (dst_temp);   
        fprintf(out_file, '%lu %d %d %d %d %d %d %d \n', time, src_coordinate, dst_coordinate, size);         
        if (mod(numPkt, 10000) == 0)
            disp (numPkt);
        end
    end
    
    if (numPkt == NUM_PKT)
       break 
    end

    tline = fgets (in_file);
end

fclose (in_file);
fclose (out_file);
