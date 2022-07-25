/* Created by Fatemeh K (11-07-2021) */
/* calulating mean moratlity rate by cause and sub-set */

libname out '/scratch/fatemehkp/projects/PM Components/output/summary';

/* main */
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc.csv'
	out= ndi_pmc
	dbms= csv;
run;

options nosource nosource2 nonotes errors=1; *suppress log window;
%macro mortality (cuz);

data dtrate;
	set ndi_pmc;
	rate&cuz. = no_death_&cuz. / no_enrollee * 100000;
run;

data ndi_pmc;
	merge ndi_pmc dtrate;
run;

%mend;
%mortality(allcuz); %mortality(cvd); %mortality(ihd); %mortality(cbv);
%mortality(chf); %mortality(resp); %mortality(copd); %mortality(pneu);
%mortality(canc); %mortality(lungc);  

proc means data=ndi_pmc noprint nway;
  var rateallcuz ratecvd rateihd ratecbv ratechf rateresp ratecopd ratepneu ratecanc ratelungc;
  output 
    out= mean_ndi_pmc (drop=_TYPE_ _FREQ_) 
    mean=;
run;

data mean_ndi_pmc; length group $10 subgroup $10;
	set mean_ndi_pmc;
	group = "Main";
	subgroup = "Main";
run;

proc append data=mean_ndi_pmc base = out.pmc_mortality_rate force; run;



/* pmc Age LE 75*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-ageLE75.csv'
	out= ndi_pmc_l75
	dbms= csv;
run;

options nosource nosource2 nonotes errors=1; *suppress log window;
%macro mortality (cuz);

data dtrate;
	set ndi_pmc_l75;
	rate&cuz. = no_death_&cuz. / no_enrollee * 100000;
run;

data ndi_pmc_l75;
	merge ndi_pmc_l75 dtrate;
run;

%mend;
%mortality(allcuz); %mortality(cvd); %mortality(ihd); %mortality(cbv);
%mortality(chf); %mortality(resp); %mortality(copd); %mortality(pneu);
%mortality(canc); %mortality(lungc); 

proc means data=ndi_pmc_L75 noprint nway;
class aLE75;
  var rateallcuz ratecvd rateihd ratecbv ratechf rateresp ratecopd ratepneu ratecanc ratelungc;
  output 
    out= mean_ndi_pmc_age(drop=_TYPE_ _FREQ_) 
    mean=;
run;

data mean_ndi_pmc_age; length group $10 subgroup $10;
	set mean_ndi_pmc_age;
	group = "Age";
	if aLE75 = 0 then subgroup = "65-75"; else subgroup = "> 75";
	drop aLE75;
run;

proc append data=mean_ndi_pmc_age base = out.pmc_mortality_rate force; run;



/* pmc Sex Female*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-sexF.csv'
	out= ndi_pmc_f
	dbms= csv;
run;

options nosource nosource2 nonotes errors=1; *suppress log window;
%macro mortality (cuz);

data dtrate;
	set ndi_pmc_f;
	rate&cuz. = no_death_&cuz. / no_enrollee * 100000;
run;

data ndi_pmc_f;
	merge ndi_pmc_f dtrate;
run;

%mend;
%mortality(allcuz); %mortality(cvd); %mortality(ihd); %mortality(cbv);
%mortality(chf); %mortality(resp); %mortality(copd); %mortality(pneu);
%mortality(canc); %mortality(lungc); 

proc means data=ndi_pmc_f noprint nway;
class sexF;
  var rateallcuz ratecvd rateihd ratecbv ratechf rateresp ratecopd ratepneu ratecanc ratelungc;
  output 
    out= mean_ndi_pmc_sex(drop=_TYPE_ _FREQ_) 
    mean=;
run;

data mean_ndi_pmc_sex; length group $10 subgroup $10;
	set mean_ndi_pmc_sex;
	group = "sex";
	if sexF = 0 then subgroup = "Female"; else subgroup = "Male";
	drop sexF;
run;

proc append data=mean_ndi_pmc_sex base = out.pmc_mortality_rate force; run;



/* pmc race A*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-raceA.csv'
	out= ndi_pmc_A
	dbms= csv;
run;

options nosource nosource2 nonotes errors=1; *suppress log window;
%macro mortality (cuz);

data dtrate;
	set ndi_pmc_A;
	rate&cuz. = no_death_&cuz. / no_enrollee * 100000;
run;

data ndi_pmc_A;
	merge ndi_pmc_A dtrate;
run;

%mend;
%mortality(allcuz); %mortality(cvd); %mortality(ihd); %mortality(cbv);
%mortality(chf); %mortality(resp); %mortality(copd); %mortality(pneu);
%mortality(canc); %mortality(lungc); 

proc means data=ndi_pmc_A noprint nway;
class rA;
  var rateallcuz ratecvd rateihd ratecbv ratechf rateresp ratecopd ratepneu ratecanc ratelungc;
  output 
    out= mean_ndi_pmc_A(drop=_TYPE_ _FREQ_) 
    mean=;
run;

data mean_ndi_pmc_A; length group $10 subgroup $10;
	set mean_ndi_pmc_A;
	if rA = 1 then delete;
	group = "Race";
	subgroup = "Asian";
	drop rA;
run;

proc append data=mean_ndi_pmc_A base = out.pmc_mortality_rate force; run;



/* pmc race B*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-raceB.csv'
	out= ndi_pmc_B
	dbms= csv;
run;

options nosource nosource2 nonotes errors=1; *suppress log window;
%macro mortality (cuz);

data dtrate;
	set ndi_pmc_B;
	rate&cuz. = no_death_&cuz. / no_enrollee * 100000;
run;

data ndi_pmc_B;
	merge ndi_pmc_B dtrate;
run;

%mend;
%mortality(allcuz); %mortality(cvd); %mortality(ihd); %mortality(cbv);
%mortality(chf); %mortality(resp); %mortality(copd); %mortality(pneu);
%mortality(canc); %mortality(lungc); 

proc means data=ndi_pmc_B noprint nway;
class rB;
  var rateallcuz ratecvd rateihd ratecbv ratechf rateresp ratecopd ratepneu ratecanc ratelungc;
  output 
    out= mean_ndi_pmc_B(drop=_TYPE_ _FREQ_) 
    mean=;
run;


data mean_ndi_pmc_B; length group $10 subgroup $10;
	set mean_ndi_pmc_B;
	if rB = 1 then delete;
	group = "Race";
	subgroup = "Black";
	drop rB;
run;

proc append data=mean_ndi_pmc_B base = out.pmc_mortality_rate force; run;



/* pmc race H*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-raceH.csv'
	out= ndi_pmc_H
	dbms= csv;
run;

options nosource nosource2 nonotes errors=1; *suppress log window;
%macro mortality (cuz);

data dtrate;
	set ndi_pmc_H;
	rate&cuz. = no_death_&cuz. / no_enrollee * 100000;
run;

data ndi_pmc_H;
	merge ndi_pmc_H dtrate;
run;

%mend;
%mortality(allcuz); %mortality(cvd); %mortality(ihd); %mortality(cbv);
%mortality(chf); %mortality(resp); %mortality(copd); %mortality(pneu);
%mortality(canc); %mortality(lungc); 

proc means data=ndi_pmc_H noprint nway;
class rH;
  var rateallcuz ratecvd rateihd ratecbv ratechf rateresp ratecopd ratepneu ratecanc ratelungc;
  output 
    out= mean_ndi_pmc_H(drop=_TYPE_ _FREQ_) 
    mean=;
run;

data mean_ndi_pmc_H; length group $10 subgroup $10;
	set mean_ndi_pmc_H;
	if rH = 1 then delete;
	group = "Race";
	subgroup = "Hispanic";
	drop rH;
run;

proc append data=mean_ndi_pmc_H base = out.pmc_mortality_rate force; run;



/* pmc race W*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-raceW.csv'
	out= ndi_pmc_W
	dbms= csv;
run;

options nosource nosource2 nonotes errors=1; *suppress log window;
%macro mortality (cuz);

data dtrate;
	set ndi_pmc_W;
	rate&cuz. = no_death_&cuz. / no_enrollee * 100000;
run;

data ndi_pmc_W;
	merge ndi_pmc_W dtrate;
run;

%mend;
%mortality(allcuz); %mortality(cvd); %mortality(ihd); %mortality(cbv);
%mortality(chf); %mortality(resp); %mortality(copd); %mortality(pneu);
%mortality(canc); %mortality(lungc); 

proc means data=ndi_pmc_W noprint nway;
class rW;
  var rateallcuz ratecvd rateihd ratecbv ratechf rateresp ratecopd ratepneu ratecanc ratelungc;
  output 
    out= mean_ndi_pmc_W(drop=_TYPE_ _FREQ_) 
    mean=;
run;


data mean_ndi_pmc_W; length group $10 subgroup $10;
	set mean_ndi_pmc_W;
	if rW = 1 then delete;
	group = "Race";
	subgroup = "White";
	drop rW;
run;

proc append data=mean_ndi_pmc_W base = out.pmc_mortality_rate force; run;



/* pmc urban*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-urban.csv'
	out= ndi_pmc_u
	dbms= csv;
run;

options nosource nosource2 nonotes errors=1; *suppress log window;
%macro mortality (cuz);

data dtrate;
	set ndi_pmc_u;
	rate&cuz. = no_death_&cuz. / no_enrollee * 100000;
run;

data ndi_pmc_u;
	merge ndi_pmc_u dtrate;
run;

%mend;
%mortality(allcuz); %mortality(cvd); %mortality(ihd); %mortality(cbv);
%mortality(chf); %mortality(resp); %mortality(copd); %mortality(pneu);
%mortality(canc); %mortality(lungc); 

proc means data=ndi_pmc_u noprint nway;
class urb;
  var rateallcuz ratecvd rateihd ratecbv ratechf rateresp ratecopd ratepneu ratecanc ratelungc;
  output 
    out= mean_ndi_pmc_urb(drop=_TYPE_ _FREQ_) 
    mean=;
run;

data mean_ndi_pmc_urb; length group $10 subgroup $10;
	set mean_ndi_pmc_urb;
	group = "Urbanicity";
	if urb = 0 then subgroup = "Urban"; else subgroup = "Rural";
	drop urb;
run;

proc append data=mean_ndi_pmc_urb base = out.pmc_mortality_rate force; run;



/* pmc urban ses L*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-urban-sesL.csv'
	out= ndi_pmc_Lo
	dbms= csv;
run;

options nosource nosource2 nonotes errors=1; *suppress log window;
%macro mortality (cuz);

data dtrate;
	set ndi_pmc_Lo;
	rate&cuz. = no_death_&cuz. / no_enrollee * 100000;
run;

data ndi_pmc_Lo;
	merge ndi_pmc_Lo dtrate;
run;

%mend;
%mortality(allcuz); %mortality(cvd); %mortality(ihd); %mortality(cbv);
%mortality(chf); %mortality(resp); %mortality(copd); %mortality(pneu);
%mortality(canc); %mortality(lungc); 

proc means data=ndi_pmc_Lo noprint nway;
class sesL;
  var rateallcuz ratecvd rateihd ratecbv ratechf rateresp ratecopd ratepneu ratecanc ratelungc;
  output 
    out= mean_ndi_pmc_Lo(drop=_TYPE_ _FREQ_) 
    mean=;
run;

data mean_ndi_pmc_Lo; length group $10 subgroup $10;
	set mean_ndi_pmc_Lo;
	if sesL = 1 then delete;
	group = "SESCat";
	subgroup = "Low";
	drop sesL;
run;

proc append data=mean_ndi_pmc_Lo base = out.pmc_mortality_rate force; run;



/* pmc urban ses M*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-urban-sesM.csv'
	out= ndi_pmc_Me
	dbms= csv;
run;

options nosource nosource2 nonotes errors=1; *suppress log window;
%macro mortality (cuz);

data dtrate;
	set ndi_pmc_Me;
	rate&cuz. = no_death_&cuz. / no_enrollee * 100000;
run;

data ndi_pmc_Me;
	merge ndi_pmc_Me dtrate;
run;

%mend;
%mortality(allcuz); %mortality(cvd); %mortality(ihd); %mortality(cbv);
%mortality(chf); %mortality(resp); %mortality(copd); %mortality(pneu);
%mortality(canc); %mortality(lungc); 

proc means data=ndi_pmc_Me noprint nway;
class sesM;
  var rateallcuz ratecvd rateihd ratecbv ratechf rateresp ratecopd ratepneu ratecanc ratelungc;
  output 
    out= mean_ndi_pmc_Me(drop=_TYPE_ _FREQ_) 
    mean=;
run;

data mean_ndi_pmc_Me; length group $10 subgroup $10;
	set mean_ndi_pmc_Me;
	if sesM = 1 then delete;
	group = "SESCat";
	subgroup = "Middle";
	drop sesM;
run;

proc append data=mean_ndi_pmc_Me base = out.pmc_mortality_rate force; run;



/* pmc urban ses H*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-urban-sesH.csv'
	out= ndi_pmc_Hi
	dbms= csv;
run;

options nosource nosource2 nonotes errors=1; *suppress log window;
%macro mortality (cuz);

data dtrate;
	set ndi_pmc_Hi;
	rate&cuz. = no_death_&cuz. / no_enrollee * 100000;
run;

data ndi_pmc_Hi;
	merge ndi_pmc_Hi dtrate;
run;

%mend;
%mortality(allcuz); %mortality(cvd); %mortality(ihd); %mortality(cbv);
%mortality(chf); %mortality(resp); %mortality(copd); %mortality(pneu);
%mortality(canc); %mortality(lungc); 

proc means data=ndi_pmc_Hi noprint nway;
class sesH;
  var rateallcuz ratecvd rateihd ratecbv ratechf rateresp ratecopd ratepneu ratecanc ratelungc;
  output 
    out= mean_ndi_pmc_Hi(drop=_TYPE_ _FREQ_) 
    mean=;
run;

data mean_ndi_pmc_Hi; length group $10 subgroup $10;
	set mean_ndi_pmc_Hi;
	if sesH = 1 then delete;
	group = "SESCat";
	subgroup = "High";
	drop sesH;
run;

proc append data=mean_ndi_pmc_Hi base = out.pmc_mortality_rate force; run;



/* pmc West*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-west.csv'
	out= ndi_pmc_west
	dbms= csv;
run;


options nosource nosource2 nonotes errors=1; *suppress log window;
%macro mortality (cuz);

data dtrate;
	set ndi_pmc_west;
	rate&cuz. = no_death_&cuz. / no_enrollee * 100000;
run;

data ndi_pmc_west;
	merge ndi_pmc_west dtrate;
run;

%mend;

%mortality(allcuz); %mortality(cvd); %mortality(ihd); %mortality(cbv);
%mortality(chf); %mortality(resp); %mortality(copd); %mortality(pneu);
%mortality(canc); %mortality(lungc); 


proc means data=ndi_pmc_west noprint nway;
class rW;
  var rateallcuz ratecvd rateihd ratecbv ratechf rateresp ratecopd ratepneu ratecanc ratelungc;
  output 
    out= mean_ndi_pmc_west(drop=_TYPE_ _FREQ_) 
    mean=;
run;

data mean_ndi_pmc_west; length group $10 subgroup $10;
	set mean_ndi_pmc_west;
	if rW = 1 then delete;
	group = "Region";
	subgroup = "West";
	drop rW;
run;

proc append data=mean_ndi_pmc_west base = out.pmc_mortality_rate force; run;



/* pmc Midwest*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-midwest.csv'
	out= ndi_pmc_mw
	dbms= csv;
run;

options nosource nosource2 nonotes errors=1; *suppress log window;
%macro mortality (cuz);

data dtrate;
	set ndi_pmc_mw;
	rate&cuz. = no_death_&cuz. / no_enrollee * 100000;
run;

data ndi_pmc_mw;
	merge ndi_pmc_mw dtrate;
run;

%mend;

%mortality(allcuz); %mortality(cvd); %mortality(ihd); %mortality(cbv);
%mortality(chf); %mortality(resp); %mortality(copd); %mortality(pneu);
%mortality(canc); %mortality(lungc); 

proc means data=ndi_pmc_mw noprint nway;
class rMW;
  var rateallcuz ratecvd rateihd ratecbv ratechf rateresp ratecopd ratepneu ratecanc ratelungc;
  output 
    out= mean_ndi_pmc_mw(drop=_TYPE_ _FREQ_) 
    mean=;
run;

data mean_ndi_pmc_mw; length group $10 subgroup $10;
	set mean_ndi_pmc_mw;
	if rMW = 1 then delete;
	group = "Region";
	subgroup = "Midwest";
	drop rMW;
run;

proc append data=mean_ndi_pmc_mw base = out.pmc_mortality_rate force; run;



/* pmc South*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-south.csv'
	out= ndi_pmc_sou
	dbms= csv;
run;

options nosource nosource2 nonotes errors=1; *suppress log window;
%macro mortality (cuz);

data dtrate;
	set ndi_pmc_sou;
	rate&cuz. = no_death_&cuz. / no_enrollee * 100000;
run;

data ndi_pmc_sou;
	merge ndi_pmc_sou dtrate;
run;

%mend;
%mortality(allcuz); %mortality(cvd); %mortality(ihd); %mortality(cbv);
%mortality(chf); %mortality(resp); %mortality(copd); %mortality(pneu);
%mortality(canc); %mortality(lungc); 

proc means data=ndi_pmc_sou noprint nway;
class rS;
  var rateallcuz ratecvd rateihd ratecbv ratechf rateresp ratecopd ratepneu ratecanc ratelungc;
  output 
    out= mean_ndi_pmc_sou(drop=_TYPE_ _FREQ_) 
    mean=;
run;

data mean_ndi_pmc_sou; length group $10 subgroup $10;
	set mean_ndi_pmc_sou;
	if rS = 1 then delete;
	group = "Region";
	subgroup = "South";
	drop rS;
run;

proc append data=mean_ndi_pmc_sou base = out.pmc_mortality_rate force; run;



/* pmc Northeast*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-northeast.csv'
	out= ndi_pmc_ne
	dbms= csv;
run;

options nosource nosource2 nonotes errors=1; *suppress log window;
%macro mortality (cuz);

data dtrate;
	set ndi_pmc_ne;
	rate&cuz. = no_death_&cuz. / no_enrollee * 100000;
run;

data ndi_pmc_ne;
	merge ndi_pmc_ne dtrate;
run;

%mend;
%mortality(allcuz); %mortality(cvd); %mortality(ihd); %mortality(cbv);
%mortality(chf); %mortality(resp); %mortality(copd); %mortality(pneu);
%mortality(canc); %mortality(lungc); 

proc means data=ndi_pmc_ne noprint nway;
class rNE;
  var rateallcuz ratecvd rateihd ratecbv ratechf rateresp ratecopd ratepneu ratecanc ratelungc;
  output 
    out= mean_ndi_pmc_ne(drop=_TYPE_ _FREQ_) 
    mean=;
run;

data mean_ndi_pmc_ne; length group $10 subgroup $10;
	set mean_ndi_pmc_ne;
	if rNE = 1 then delete;
	group = "Region";
	subgroup = "Northeast";
	drop rNE;
run;

proc append data=mean_ndi_pmc_ne base = out.pmc_mortality_rate force; run;



/* pmc BRFSS*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-brfss.csv'
	out= ndi_pmc_brfs
	dbms= csv;	
run;

options nosource nosource2 nonotes errors=1; *suppress log window;
%macro mortality (cuz);

data dtrate;
	set ndi_pmc_brfs;
	rate&cuz. = no_death_&cuz. / no_enrollee * 100000;
run;

data ndi_pmc_brfs;
	merge ndi_pmc_brfs dtrate;
run;

%mend;
%mortality(allcuz); %mortality(cvd); %mortality(ihd); %mortality(cbv);
%mortality(chf); %mortality(resp); %mortality(copd); %mortality(pneu);
%mortality(canc); %mortality(lungc);  

proc means data=ndi_pmc_brfs noprint nway;
  var rateallcuz ratecvd rateihd ratecbv ratechf rateresp ratecopd ratepneu ratecanc ratelungc;
  output 
    out= mean_ndi_pmc_brfs(drop=_TYPE_ _FREQ_) 
    mean=;
run;

data mean_ndi_pmc_brfs; length group $10 subgroup $10;
	set mean_ndi_pmc_brfs;
	group = "BRFSS";
	subgroup = "BRFSS";
run;

proc append data=mean_ndi_pmc_brfs base = out.pmc_mortality_rate force; run;

proc export data=out.pmc_mortality_rate
	outfile='/scratch/fatemehkp/projects/PM Components/output/summary/pmc-mortality-rate.csv'
	dbms=csv
	replace;
run;