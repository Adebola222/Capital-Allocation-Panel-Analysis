* Import Excel data
import delimited "data_f.csv"

****************************************************************************************************************
								* DATA CLEANING
****************************************************************************************************************


* Remove symbols like the dollar sign, parentheses, and percentage sign
foreach var of varlist stockprice marketcap equity debt revenue netincome capex fcf interestexpense incometax cash totalassets totalliabilities shorttermdebt longtermdebt netdebt {
    replace `var' = subinstr(`var', "$", "", .)
    replace `var' = subinstr(`var', ",", "", .)
    replace `var' = subinstr(`var', "(", "", .)
    replace `var' = subinstr(`var', ")", "", .)
}

* Remove percentage sign from InterestRate
replace interestrate = subinstr(interestrate, "%", "", .)

* Remove percentage sign from capitalstructure
replace capitalstructure = subinstr(capitalstructure, "%", "", .)


* Convert all variables to numeric
destring, replace


****************************************************************************************************************
								* DESCRIPTIVE STATISTICS
****************************************************************************************************************


* Compute summary statistics for Deere - Iowa
summarize if company == "Deere - Iowa"

* Compute summary statistics for Allstate - Illinois
summarize if company == "Allstate - Illinois"

* Compute summary statistics for GM - Michigan
summarize if company == "GM - Michigan"


* Define the half percentage intervals and generate frequency table for each company
egen Interest_Rate_Category = cut(interestrate), at(0(0.5)10) label
tabulate Interest_Rate_Category


****************************************************************************************************************
										* CREATING DUMMY VARIABLES
****************************************************************************************************************


* Create Cash Dummy
gen cash_dummy = (cash / debt >= 0.1)

* Create Capex Dummy
gen capex_dummy = (capex / revenue >= 0.05)

* Create FCF Dummy
gen fcf_dummy = (fcf > 0 & !missing(fcf))


* Create interaction terms for each variable
gen capex_stockprice = capex_dummy * stockprice
gen fcf_stockprice = fcf_dummy * stockprice
gen cash_stockprice = cash_dummy * stockprice

gen capex_marketcap = capex_dummy * marketcap
gen fcf_marketcap = fcf_dummy * marketcap
gen cash_marketcap = cash_dummy * marketcap

gen capex_revenue = capex_dummy * revenue
gen fcf_revenue = fcf_dummy * revenue
gen cash_revenue = cash_dummy * revenue

gen capex_netincome = capex_dummy * netincome
gen fcf_netincome = fcf_dummy * netincome
gen cash_netincome = cash_dummy * netincome

gen capex_interestexpense = capex_dummy * interestexpense
gen fcf_interestexpense = fcf_dummy * interestexpense
gen cash_interestexpense = cash_dummy * interestexpense

gen capex_interestrate = capex_dummy * interestrate
gen fcf_interestrate = fcf_dummy * interestrate
gen cash_interestrate = cash_dummy * interestrate


****************************************************************************************************************
									* SETTING THE DATA AS PANEL DATA
****************************************************************************************************************

* Declare data as panel Data

* Generate a numeric identifier for the company variable
egen company_id = group(company)

* Check for duplicate observations
duplicates report company_id year

* If there are duplicates, you can drop them
duplicates drop company_id year, force

* Set the panel variable
xtset company_id year


****************************************************************************************************************
									* REGRESSION MODELLING
****************************************************************************************************************

* Pooled ordinary least squares (OLS) Model 
xtreg capitalstructure interestrate stockprice marketcap revenue netincome interestexpense

* Fixed effect model
xtreg capitalstructure interestrate stockprice marketcap revenue netincome interestexpense, fe
estimate store fe


* Random effect model
xtreg capitalstructure interestrate stockprice marketcap revenue netincome interestexpense, re
estimate store re


 * Hausman Test
 * Ho: Random Effect model is appropriate
 * H1: Fixed Effect model is appropriate

 hausman fe re
 



* Fixed effect model
xtreg capitalstructure interestrate stockprice marketcap revenue netincome interestexpense, fe

****************************************************************************************************************
									* Pre Estimation Test
****************************************************************************************************************

****************************************************************************************************************
							* ENSURE THIS PACKAGE ARE INSTALLED USING THE CODES BELOW
****************************************************************************************************************

* install these
* ssc install xttest1
* ssc install xttest2
* ssc install xttest3
* ssc install xtserial



* Testing for RE: The Breusch-Pagan LM Test
xttest0

* Test of Cross sectional dependence - Breusch-Pagan LM Test for Independence
xttest2

* Test for Heteroscedasticity
xtreg capitalstructure interestrate stockprice marketcap revenue netincome interestexpense, fe
xttest3

* Test for serial Correlation
xtserial capitalstructure interestrate stockprice marketcap revenue netincome interestexpense



****************************************************************************************************************
												* Output for Fixed effect model with interaction
****************************************************************************************************************

* capex interaction
xtreg capitalstructure interestrate stockprice marketcap revenue netincome interestexpense capex_interestrate capex_netincome capex_stockprice capex_marketcap capex_revenue capex_interestrate, fe
outreg2 using myreg.doc, replace ctitle(Capex dummy) addtext(Company FE, YES)

* fcf_interaction
xtreg capitalstructure interestrate stockprice marketcap revenue netincome interestexpense fcf_interestexpense fcf_netincome fcf_stockprice fcf_marketcap fcf_revenue fcf_interestrate, fe
outreg2 using myreg.doc, append ctitle(FCF dummy) addtext(Company FE, YES)


* Cash interaction
xtreg capitalstructure interestrate stockprice marketcap revenue netincome interestexpense cash_interestexpense cash_netincome cash_stockprice cash_marketcap fcf_revenue cash_interestrate, fe
outreg2 using myreg.doc, append ctitle(Cash dummy) addtext(Company FE, YES)






****************************************************************************************************************
												* Company Level Analysis 
****************************************************************************************************************

* Fit a fixed-effect model for Deere - Iowa
xtreg capitalstructure interestrate stockprice marketcap revenue netincome interestexpense capex_interestrate capex_netincome capex_stockprice capex_marketcap capex_revenue capex_interestrate if company == "Deere - Iowa", fe
outreg2 using myreg.doc, replace ctitle(Capex dummy) addtext(Company FE, YES)

xtreg capitalstructure interestrate stockprice marketcap revenue netincome interestexpense fcf_interestexpense fcf_netincome fcf_stockprice fcf_marketcap fcf_revenue fcf_interestrate if company == "Deere - Iowa", fe
outreg2 using myreg.doc, append ctitle(FCF dummy) addtext(Company FE, YES)

xtreg capitalstructure interestrate stockprice marketcap revenue netincome interestexpense cash_interestexpense cash_netincome cash_stockprice cash_marketcap cash_revenue cash_interestrate if company == "Deere - Iowa", fe
outreg2 using myreg.doc, append ctitle(Cash dummy) addtext(Company FE, YES)



* Fit a fixed-effect model for Allstate - Illinois
xtreg capitalstructure interestrate stockprice marketcap revenue netincome interestexpense capex_interestrate capex_netincome capex_stockprice capex_marketcap capex_revenue capex_interestrate if company == "Allstate - Illinois", fe
outreg2 using myreg.doc, replace ctitle(Capex dummy) addtext(Company FE, YES)

xtreg capitalstructure interestrate stockprice marketcap revenue netincome interestexpense fcf_interestexpense fcf_netincome fcf_stockprice fcf_marketcap fcf_revenue fcf_interestrate if company == "Allstate - Illinois", fe
outreg2 using myreg.doc, append ctitle(FCF dummy) addtext(Company FE, YES)

xtreg capitalstructure interestrate stockprice marketcap revenue netincome interestexpense cash_interestexpense cash_netincome cash_stockprice cash_marketcap cash_revenue cash_interestrate if company == "Allstate - Illinois", fe
outreg2 using myreg.doc, append ctitle(Cash dummy) addtext(Company FE, YES)



* Fit a fixed-effect model for GM - Michigan
xtreg capitalstructure interestrate stockprice marketcap revenue netincome interestexpense capex_interestrate capex_netincome capex_stockprice capex_marketcap capex_revenue capex_interestrate if company == "GM - Michigan", fe
outreg2 using myreg.doc, replace ctitle(Capex dummy) addtext(Company FE, YES)

xtreg capitalstructure interestrate stockprice marketcap revenue netincome interestexpense fcf_interestexpense fcf_netincome fcf_stockprice fcf_marketcap fcf_revenue fcf_interestrate if company == "GM - Michigan", fe
outreg2 using myreg.doc, append ctitle(FCF dummy) addtext(Company FE, YES)

xtreg capitalstructure interestrate stockprice marketcap revenue netincome interestexpense cash_interestexpense cash_netincome cash_stockprice cash_marketcap cash_revenue cash_interestrate if company == "GM - Michigan", fe
outreg2 using myreg.doc, append ctitle(Cash dummy) addtext(Company FE, YES)


* Label Definitions
label define cash_label 0 "Low Cash" 1 "High Cash"
label define capex_label 0 "Low Investment" 1 "High Investment"
label define fcf_label 0 "CF Negative" 1 "CF Positive"

* Apply Labels to Dummy Variables
label values cash_dummy cash_label
label values capex_dummy capex_label
label values fcf_dummy fcf_label


* Summary Table
asdoc tabulate cash_dummy company, column
asdoc tabulate capex_dummy company, column
asdoc tabulate fcf_dummy company, column
