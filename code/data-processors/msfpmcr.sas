/* Created by Fatemeh K (01-02-2021)																*/
/* Create an aggregate data by the Site															*/
/* Dataset aggregated number of enrolleess and deaths by site, year, month, age, sex and race    */
/* Focus on 2000 (Jan) to 2008 data                                              					*/

libname prcs '/scratch/fatemehkp/projects/PM Components/data/processed';
libname cms '/scratch/fatemehkp/projects/CMS/data/processed';

proc sql;
	create table enrollee_pmc as
	select *
	from cms.enrollee65_ndi_0008_clean a 
	inner join prcs.pmc_site_zip_bz12 b
	on a.zip_code=b.zip_code and a.year=b.year and a.month=b.month
	where sex ne 'U';
quit;

data enrollee_pmc; 
	set enrollee_pmc; 
	if enrollee_age ge 90 then enrollee_age = 90;
run;

/****************************************************************************/
/* Compute MASTER file                                                      */
/****************************************************************************/
proc sql;
*Count the number of enrollees of age a, sex s and race r by site s at the beginning of the month t ;
	create table master_enrollee_bysite as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_enrollee
	from enrollee_pmc
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of all-cause death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite1 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_allcuz
	from enrollee_pmc
	where allcuz=1
	group by site_id, year, month, enrollee_age, sex, race;
	
*Count the number of non-accidental death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite2 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_nacc
	from enrollee_pmc
	where nacc=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of accidental death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite3 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_acc
	from enrollee_pmc
	where acc=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of CVD death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite4 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_cvd
	from enrollee_pmc
	where cvd=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of IHD death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite5 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_ihd
	from enrollee_pmc
	where ihd=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of CHF death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite6 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_chf
	from enrollee_pmc
	where chf=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of CBV death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite7 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_cbv
	from enrollee_pmc
	where cbv=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of Respiratory death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite8 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_resp
	from enrollee_pmc
	where resp=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of COPD death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite9 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_copd
	from enrollee_pmc
	where copd=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of Pneumonia death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite10 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_pneu
	from enrollee_pmc
	where pneu=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of URI death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite11 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_uri
	from enrollee_pmc
	where uri=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of ARDS death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite12 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_ards
	from enrollee_pmc
	where ards=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of Cancer death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite13 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_canc
	from enrollee_pmc
	where canc=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of Lung Cancer death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite14 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_lungc
	from enrollee_pmc
	where lungc=1
	group by site_id, year, month, enrollee_age, sex, race;
	
*Count the number of Sepsis death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite15 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_seps
	from enrollee_pmc
	where seps=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of Vascular Dementia death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite16 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_VaD
	from enrollee_pmc
	where VaD=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of Alzheimer death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite17 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_AD
	from enrollee_pmc
	where AD=1
	group by site_id, year, month, enrollee_age, sex, race;
	
*Count the number of Neurodegenerative Disease death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite18 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_NeD
	from enrollee_pmc
	where NeD=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of Unspecified Dementia death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite19 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_UsD
	from enrollee_pmc
	where UsD=1
	group by site_id, year, month, enrollee_age, sex, race;
	
*Count the number of Diabete typeI death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite20 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_diabt1
	from enrollee_pmc
	where diabt1=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of Diabete typeII death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite21 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_diabt2
	from enrollee_pmc
	where diabt2=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of Diabete death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite22 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_diab
	from enrollee_pmc
	where diabt1=1 or diabt2=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of Renal disease death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite23 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_kidn
	from enrollee_pmc
	where kidn=1
	group by site_id, year, month, enrollee_age, sex, race;

quit;

data master_cuz;
	merge master_enrollee_bysite master_death_bysite1 master_death_bysite2 master_death_bysite3
								 master_death_bysite4 master_death_bysite5 master_death_bysite6
								 master_death_bysite7 master_death_bysite8 master_death_bysite9
								 master_death_bysite10 master_death_bysite11 master_death_bysite12
								 master_death_bysite13 master_death_bysite14 master_death_bysite15
								 master_death_bysite16 master_death_bysite17 master_death_bysite18
								 master_death_bysite19 master_death_bysite20 master_death_bysite21
								 master_death_bysite22 master_death_bysite23;
	by site_id year month enrollee_age sex race;
run;

proc datasets nolist;
	delete master_enrollee_bysite master_death_bysite1 master_death_bysite2 master_death_bysite3
								  master_death_bysite4 master_death_bysite5 master_death_bysite6
								  master_death_bysite7 master_death_bysite8 master_death_bysite9
								  master_death_bysite10 master_death_bysite11 master_death_bysite12
								  master_death_bysite13 master_death_bysite14 master_death_bysite15
								  master_death_bysite16 master_death_bysite17 master_death_bysite18
								  master_death_bysite19 master_death_bysite20 master_death_bysite21
								  master_death_bysite22 master_death_bysite23;
run;

/*change . to 0*/
data prcs.master_ndi_pmc_race; set master_cuz;
	array change _numeric_;
		do over change;
			if change <0 then change=0;
		end;
run;

proc export	data=prcs.master_ndi_pmc_race
	outfile='/scratch/fatemehkp/projects/PM Components/data/processed/master_ndi_pmc_race.csv'
	dbms=csv
	replace;
run;






