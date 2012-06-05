%This function is just for adding day of year to aeronet data for the sites
%inside USA

function process_aeronet_data()
   
    aeronet_path='/Users/lakesh/Aerosol/aeronet_processed/';
    aeronet_list_file='/Users/lakesh/Aerosol/preprocessing_codes/AERONET/sorted.txt';
    dest_path = '/Users/lakesh/Aerosol/aeronet_processed_dayofyear/';
    dateConverterPath = '/Users/lakesh/Aerosol/preprocessing_codes/MISR/';
    
    sites = textread(aeronet_list_file,'%s');
    
    sites_number = size(sites,1);
    
    for i=1:sites_number
        site = sites{i};
        curDir = pwd;
        load([aeronet_path site '.mat']);
        [row column]  = size(aeronet_data);
        aeronetdata = zeros(row,column+1);
        aeronetdata(:,1:column)=aeronet_data;
        cd(dateConverterPath);
        
        %Get the day of year
        for j=1:row
            aeronetdata(j,column+1) = floor(dayofyear(aeronet_data(j,1),aeronet_data(j,2),aeronet_data(j,3),aeronet_data(j,4),aeronet_data(j,5),aeronet_data(j,6))) ;
        end
        save([dest_path site '.mat'],'aeronetdata', 'latitude','longitude','location');
        cd(curDir);
        
    end
    
    