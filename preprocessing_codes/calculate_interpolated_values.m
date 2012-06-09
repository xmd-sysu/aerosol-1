grid_path = '/Users/lakesh/Aerosol/preprocessing_codes/final_grid_v2.mat';
load(grid_path);

source_path='/Users/lakesh/Desktop/modis_final_2007/';
dest_path='/Users/lakesh/Desktop/modis_interpolated_2007/';

[row column dimension] = size(grid);

year = 2007;

tic;
for day=1:365
    load([source_path num2str(day) '.mat']);
    p = data(:,1:2);
    t = delaunayn(p);
    f = data(:,7);
    interpolatedData = zeros(row,column, 8);
    interpolatedData(:,:,1) = grid(:,:,1);
    interpolatedData(:,:,2) = grid(:,:,2);
    interpolatedData(:,:,3) = year;
    interpolatedData(:,:,4) = day;
    interpolatedData(i,j,5) = griddata(data(:,1),data(:,2), data(:,5),grid(:,:,1),grid(:,:,2),'nearest');
    interpolatedData(i,j,6) = griddata(data(:,1),data(:,2),data(:,5),grid(:,:,1),grid(:,:,2),'nearest');
    interpolatedData(i,j,7) = tinterp(p, t, f, grid(:,:,1),grid(:,:,2),'linear');
    interpolatedData(i,j,8) = griddata(data(:,1),region_data(:,2),data(:,8),grid(:,:,1),grid(:,:,2),'nearest');
end

toc;


