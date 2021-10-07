/* Created by Fatemeh K (01-17-2021)																*/
/* Counting numbers per group */

libname raw '/scratch/fatemehkp/projects/PM Components/data/raw';
libname out '/scratch/fatemehkp/projects/PM Components/output';

proc sort data=raw.enrollee_pmc_bz6 nodupkey out=raw.sites_bz6;
	by site_id; 
run;

/*****************************/
/* Total enrollee */
proc sql;
	title 'Total enrollee in the US';
	select count(distinct bene_id) as num_enrollee
	from raw.enrollee_pmc;
quit; 
* Main: 15,385,050;
* BZ6:   7,372,363 ;
* BZ12: 15,251,588;
* BZ24: 25,283,403;


/*****************************/
/* Total zipcode */
proc sql;
	title 'Total zipcode in the study';
	select count(distinct zip_code) as num_zipcode
	from raw.enrollee_pmc;
quit; 
*Main : 7,286;
*bz6: 3507;
*bz12: 7163;
*bz24: 13809;

/*****************************/
/* Cause-Specific Mortality */
proc sql;
	title 'Total casue-specific death in the study';
	create table pmc_death as
	select sum(allcuz) as allcause,
			sum(cvd) as allcvd,
			sum(ihd) as allihd,
			sum(chf) as allchf,
			sum(cbv) as allcbv,
			sum(resp) as allresp,
			sum(copd) as allcopd,
			sum(pneu) as allpneu,
			sum(uri) as alluri,
			sum(ards) as allards,
			sum(canc) as allcanc,
			sum(lungc) as alllungc,
			sum(seps) as allsepsis,
			sum(VaD) as allVaD,
			sum(AD) as allAD,
			sum(NeD) as allNeD,
			sum(UsD) as allUsD,
			sum(diabt1) as alldiabt1,
			sum(diabt2) as alldiabt2,
			sum(kidn) as allkidn
	from raw.enrollee_pmc;
quit;

proc export	data=pmc_death
	outfile='/scratch/fatemehkp/projects/PM Components/output/pmc_death.csv'
	dbms=csv
	replace;
run;


*Some people might changed their sex/race identity in between;

proc sort data=raw.enrollee_pmc out=master0;
	by bene_id year month; 
run;
	
proc sort data=master0 nodupkey out=raw.enrollee_pmc_start;
	by bene_id; run;

/*****************************/
/* Total enrollee at each age group at time of enrollment */
proc sql;
title 'Frequency of Race at time of enrollement';
Create table enrollee_age as
select enrollee_age, count(bene_id) as race_freq
from raw.enrollee_pmc_start
group by enrollee_age
order by enrollee_age;
quit;

proc export	data=enrollee_age
	outfile='/scratch/fatemehkp/projects/PM Components/output/pmc_enrollee_age.csv'
	dbms=csv
	replace;
run;


/*****************************/
/* Total enrollee at each sex group at time of enrollment */
proc sql;
title 'Frequency of Race at time of enrollement';
Create table enrollee_sex as
select sex, count(bene_id) as race_freq
from raw.enrollee_pmc_start
group by sex
order by sex;
quit;

proc export	data=enrollee_sex
	outfile='/scratch/fatemehkp/projects/PM Components/output/pmc_enrollee_sex.csv'
	dbms=csv
	replace;
run;

/*****************************/
/* Total enrollee at each race group at time of enrollment */
proc sql;
title 'Frequency of Race at time of enrollement';
Create table enrollee_race as
select race, count(bene_id) as race_freq
from raw.enrollee_pmc_start
group by race
order by race;
quit;

proc export	data=enrollee_race
	outfile='/scratch/fatemehkp/projects/PM Components/output/pmc_enrollee_race.csv'
	dbms=csv
	replace;
run;


/*****************************/
/* Total enrolees with brfs data */
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/processed/pmc-brfss-count.csv'
	out=raw.brfss
	dbms=csv
	replace;
run;

proc sql;
	select count(distinct bene_id) as num_enrollee
	from raw.enrollee_pmc a
	inner join raw.brfss b
	on a.year = b.year and a.month = b.month and a.site_id = b.site_id;
quit; 
	
	
/*****************************/
/* PMC sites with ndi data */
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/processed/pmc-site-ndi.csv'
	out=raw.pmc_site
	dbms=csv
	replace;
run;

data raw.pmc_site;
	set raw.pmc_site;
	Site_ID = Site.ID;
	Location = Location.Setting;
	Region = Region.IV;
run;

/*****************************/
/* Total enrollee by urbanicity */
proc sql;
	title 'Total enrollee by Location Setting';
	select Location, count(distinct bene_id) as num_enrollee
	from raw.enrollee_pmc_start a
	inner join raw.pmc_site b
	on a.site_id = b.site_id
	group by Location
	order by Location;
quit; 


/*****************************/
/* Total enrollee by region */
proc sql;
	title 'Total enrollee by Region';
	select Region, count(distinct bene_id) as num_enrollee
	from raw.enrollee_pmc_start a
	inner join raw.pmc_site b
	on a.site_id = b.site_id
	group by Region
	order by Region;
quit; 


/*****************************/
/* Total enrollee by TOR/TOT method */
proc sql;
	title 'Total enrollee by Carbon Method';	
	select Method, count(distinct bene_id) as num_enrollee
	from raw.enrollee_pmc_start a
	inner join raw.pmc_site b
	on a.site_id = b.site_id
	group by Method
	order by Method;
quit; 