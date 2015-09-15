#!/bin/bash
cd /opt/stoqs-odssadm-git/venv-stoqs/bin
source activate
cd /opt/stoqs-odssadm-git/loaders/CANON/realtime
##!/bin/bash
#cd ~/dev/stoqs/venv-stoqs/bin
#source activate
#cd ~/dev/stoqs/loaders/CANON/realtime
#python monitorLrauv.py --start '20150518T000000' -d  'LRAUV Monterey data - May 2015' --productDir '/mbari/ODSS/data/canon/2015_May/Products/LRAUV/' \
#--contourDir '/mbari/LRAUV/stoqs' --contourUrl 'http://dods.mbari.org/opendap/data/lrauv/stoqs/' -o /tmp/TestMonitorLrauv \
#-u 'http://elvis.shore.mbari.org/thredds/catalog/LRAUV/makai/realtime/cell-logs/20150521T235502/.*Normal.nc4$' -b 'stoqs_lrauv' -c 'May 2015 CANON Experiment' --append \
#--iparm bin_mean_mass_concentration_of_chlorophyll_in_sea_water --parms bin_mean_mass_concentration_of_chlorophyll_in_sea_water bin_mean_sea_water_temperature bin_sea_water_salinity sea_water_salinity \
#--plotgroup bin_mean_mass_concentration_of_chlorophyll_in_sea_water bin_mean_sea_water_temperature sea_water_salinity bin_sea_water_salinity
#--contourDir '/mbari/LRAUV/stoqs' --contourUrl 'http://dods.mbari.org/opendap/data/lrauv/stoqs/' -o '/tmp/TestMonitorLrauv' --append \
database='stoqs_lrauv'
post=''
#post='--post --slacktoken 'xoxp-4525206644-4646992431-4964497628-2b33c8'
database='stoqs_canon_may2015_lrauv'
urlbase='http://elvis.shore.mbari.org/thredds/catalog/LRAUV'
declare -a searchstr=("/realtime/sbdlogs/2015/201505/.*shore.nc4$" "/realtime/cell-logs/.*Priority.nc4$" "/realtime/cell-logs/.*Normal.nc4$")
declare -a platforms=("tethys" "makai" "daphne")

for platform in "${platforms[@]}"
do
    for search in "${searchstr[@]}"
    do
        # get everything before the last /
        directory=`echo ${s} | sed 's:/[^/]*$::'`
        python monitorLrauv.py --start '20150519T220000' -d  'LRAUV Monterey data - May 2015' --productDir '/mbari/ODSS/data/canon/2015_May/Products/LRAUV/' \
 	--contourDir '/mbari/LRAUV/stoqs' --contourUrl 'http://dods.mbari.org/opendap/data/lrauv/stoqs/' -o '/mbari/LRAUV/'${platform}/${directory} --append \
        -u ${urlbase}/${platform}/${search} -b ${database} -c 'May 2015 CANON Experiment'  \
        --iparm bin_mean_mass_concentration_of_chlorophyll_in_sea_water \
        --parms bin_median_mass_concentration_of_chlorophyll_in_sea_water \
        bin_mean_mass_concentration_of_chlorophyll_in_sea_water \
        bin_median_mass_concentration_of_chlorophyll_in_sea_water \
        bin_mean_sea_water_temperature \
        bin_median_sea_water_temperature \
        bin_mean_sea_water_temperature  \
        bin_median_sea_water_temperature  \
        sea_water_temperature  \
        mass_concentration_of_oxygen_in_sea_water  \
        downwelling_photosynthetic_photon_flux_in_sea_water \
        --plotgroup \
        bin_mean_mass_concentration_of_chlorophyll_in_sea_water \
        bin_mean_sea_water_temperature \
        bin_mean_sea_water_salinity \
        sea_water_salinity \
        $post 
#> /tmp/${platform}.out
    done
done

