libname raw '/scratch/fatemehkp/projects/PM Components/data/raw';
libname prcs '/scratch/fatemehkp/projects/PM Components.data/processed';
libname pm '/scratch/fatemehkp/projects/Zipcode PM NO2/data/processed';


/****************************************************************************************/
/* Adding daily PM to daily components */
proc import datafile="/scratch/fatemehkp/projects/PM Components/data/processed/pmc-site-all-zip-bz12.csv"
        out=site_zip_close
        dbms=csv
        replace;
     getnames=yes;
run;

data site_zip_close; set site_zip_close;
	Site_ID = Site.ID;
	Zip_Code = Zip.Code;
keep Site_ID Year Zip_Code;
run;

data pm_zipcd1; 
	retain zip_code year month day chardate;
	set pm.pm_j_daily_zip2;
	year=yr;
	month=mo;
	PM = pm_jeff;
	keep zip_code year month day chardate PM;
run;

proc sql;
	create table pm_daily as
	select site_id, a.year, chardate,
			avg(PM) as PM
	from pm_zipcd1 a
	inner join site_zip_close b
		on a.zip_code = b.zip_code and a.year = b.year
	group by site_id, a.year, month, day, chardate
	order by site_id, a.year, month, day, chardate;
quit;

proc sort data=pm_daily nodupkey out=pm_daily (keep = Site_ID year chardate PM); 
	by Site_ID chardate;
run;

proc sort data=pm_daily nodupkey out=test1; 
	by site_id year; #3178
run; 

proc sort data=pm_daily nodupkey out=test2; 
	by site_id; *558;
run; 

data prcs.pm_pmc_daily; 
	retain Site_ID chardate PM;
	set pm_daily2;
	drop year;
run;

proc export data=prcs.pm_pmc_daily
	outfile='/scratch/fatemehkp/projects/PM Components/data/processed/pm_pmc_daily.csv'
	dbms=csv
	replace;
run;


/****************************************************************************************/
/* Site-Zipcode cross-walk for pmc to cms */
/* BZ = 12 */
proc import datafile="/scratch/fatemehkp/projects/PM Components/data/processed/pmc-site-zip-bz12.csv"
        out=pmc_bz12
        dbms=csv
        replace;
     getnames=yes;
run;

* change names to be consistent with CMS data;
data prcs.pmc_site_zip_bz12; retain Site_ID;
	set pmc_bz12;
	Site_ID = Site.ID;
	ZIP_CODE = Zip.Code;
	keep Site_ID ZIP_CODE Year Month psuedo;
run;

/* BZ = 6 */
proc import datafile="/scratch/fatemehkp/projects/PM Components/data/processed/pmc-site-zip-bz6.csv"
        out=pmc_bz6
        dbms=csv
        replace;
     getnames=yes;
run;

* change names to be consistent with CMS data;
data prcs.pmc_site_zip_bz6; retain Site_ID;
	set pmc_bz6;
	Site_ID = Site.ID;
	ZIP_CODE = Zip.Code;
	keep Site_ID ZIP_CODE Year Month psuedo;
run;

/* BZ = 24 */
proc import datafile="/scratch/fatemehkp/projects/PM Components/data/processed/pmc-site-zip-bz24.csv"
        out=pmc_bz24
        dbms=csv
        replace;
     getnames=yes;
run;

* change names to be consistent with CMS data;
data prcs.pmc_site_zip_bz24; retain Site_ID;
	set pmc_bz24;
	Site_ID = Site.ID;
	ZIP_CODE = Zip.Code;
	keep Site_ID ZIP_CODE Year Month psuedo;
run;

