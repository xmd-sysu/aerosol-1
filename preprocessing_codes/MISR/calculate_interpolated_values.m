grid_path = '/Users/lakesh/Aerosol/preprocessing_codes/final_grid_v2.mat';
load(grid_path);

source_path='/Users/lakesh/Aerosol/misr_final_2007/';
dest_path='/Users/lakesh/Aerosol/misr_interpolated_2007/';

[row column dimension] = size(grid);

year = 2007;

tic;
for day=1:365
    load([source_path num2str(day) '.mat']);
    p = data(:,1:2);
    t = delaunayn(p);
    f = data(:,7);
    interpolatedData = zeros(row,column, 7);
    %latitude
    interpolatedData(:,:,1) = grid(:,:,1);
    %longitude
    interpolatedData(:,:,2) = grid(:,:,2);
    %year
    interpolatedData(:,:,3) = year;
    %day
    interpolatedData(:,:,4) = day;
    %hour
    interpolatedData(:,:,5) = griddata(data(:,1),data(:,2), data(:,5),grid(:,:,1),grid(:,:,2),'nearest');
    %minute
    interpolatedData(:,:,6) = griddata(data(:,1),data(:,2),data(:,6),grid(:,:,1),grid(:,:,2),'nearest');
    %AOD_558
    try 
        interpolatedData(:,:,7) = tinterp(p, t, f, grid(:,:,1),grid(:,:,2),'linear');
    catch e
        
    end
    save([dest_path num2str(day) '.mat'],'interpolatedData');
end

toc;


