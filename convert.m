clc;
clear;

in_file = fopen ('D:/TracePARSEC/raw/vips.txt', 'r');
intensity_out_file = fopen ('D:/TracePARSEC/topaz/vips.txt', 'w');
out_file = fopen ('D:/TracePARSEC/topaz/vips.trace', 'w');
NUM_PKT = 10000000; 
numPkt = 0;


time_out = zeros(1,NUM_PKT);
src_out = zeros(1,NUM_PKT);
dst_out = zeros(1,NUM_PKT);
size_out = zeros(1,NUM_PKT);
intensity_out = 0;

time_new = zeros(1,NUM_PKT);
src_new = zeros(1,NUM_PKT);
dst_new = zeros(1,NUM_PKT);
size_new = zeros(1,NUM_PKT);

i = 0;

tline = fgets (in_file);
while (tline ~= -1)
    i = i + 1;
    numPkt = numPkt + 1;
    A = sscanf (tline, '%lu %d %d %d'); 
    
    time_new(1,i) = A(1);
    src_new(1,i) = A(2);
    dst_new(1,i) = A(3);
    size_new(1,i) = A(4);  
    
    
    if (src_new(1,i) == dst_new(1,i))
        i = i - 1; % skip the current line; write at the same entry at the next iteration.
    else
        if (mod(i,NUM_PKT) == 1)      
            beginTime = A (1);
        elseif (mod(i,NUM_PKT) == 0)
            %A = sscanf (tline, '%lu %d %d %d');
            endTime = A (1);
            intensity_new = NUM_PKT / (endTime - beginTime);
            fprintf(intensity_out_file, '%.8f \n', intensity_new);

            if (intensity_new >= intensity_out)
               intensity_out = intensity_new;
               time_out = time_new;
               src_out = src_new;
               dst_out = dst_new;
               size_out = size_new;
            end


            disp (numPkt);
            disp (intensity_new); 

            intensity_new = 0;
            i = 0;
        end
    end
    
    
    
    tline = fgets (in_file);
end

start = 1;
startTime = 0;
for i = 1 : NUM_PKT
    if (start == 1)
       startTime = time_out(1,i); 
       start = 0; 
    end
    time = time_out(1,i) - startTime + 1;
    src_coordinate = addrMapping (src_out(1,i));
    dst_coordinate = addrMapping (dst_out(1,i));
    size = size_out(1,i);
    fprintf(out_file, '%lu %d %d %d %d %d %d %d \n', time, src_coordinate, dst_coordinate, size);
end

fclose (in_file);
fclose (out_file);
fclose (intensity_out_file);
