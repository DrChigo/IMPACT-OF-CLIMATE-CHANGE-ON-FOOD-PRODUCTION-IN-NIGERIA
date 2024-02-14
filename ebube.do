clear all
set more off
cd "C:\Users\RENET\Downloads\data and data"
capture log close
log using "C:\Users\RENET\Downloads\data and data\Ebube.log", replace 
import excel using "C:\Users\RENET\Downloads\data and data\ebube data.xlsx", sheet("Sheet1") firstrow case(preserve) clear
tsset Category
dfuller food, regress lags(1)
dfuller CO2emissionskt, regress lags(1)
dfuller Averageprecipitationindepth, regress lags(1)
dfuller MeanTemperature, regress lags(1)
*since the variables Averageprecipitationindepth  does not integrate, I have to generate the log of the variables. 
gen logAverageprecipitationindepth = log(Averageprecipitationindepth) 
dfuller logAverageprecipitationindepth, regress lags(2)
dfuller MeanTemperature, regress lags(2)
*at the log of the variables Averageprecipitationindepth and MeanTemperature, there were not stationary. The idea of using ARDL is changed to  Robost OLS which accomodates the nature of our variables, then create a veriable list called $list
ssc install xtcointreg
summarize $list
reg $list
twoway (tsline food)
twoway (tsline CO2emissionskt)
twoway (tsline Averageprecipitationindepth)
twoway (tsline MeanTemperature)