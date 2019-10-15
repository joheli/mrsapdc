# mrsapdc
This is a R package which exposes a model for the estimation of the probability of nasal Methicillin-resistant *Staphylococcus auraus* (MRSA) carriage in hospital admissions and the positive predictive value of a diagnostic test for the same admissions, given the following parameters:
* risk factors for nasal carriage, including
  * age
  * nursing home residence
  * emergency admission
  * ICD-10 admission diagnosis header
* prevalence of MRSA nasal carriage among admissions
* sensitivity and specificity of a diagnostic test used for screening 

## Demonstration
Have a look at [mrsapdc.info](https://mrsapdc.info) to see the presented model in action.

## Installation
Make sure you have [R](https://www.r-project.org/) and package [devtools](https://cran.r-project.org/web/packages/devtools/index.html) installed. Then, type `devtools::install_github("joheli/mrsapdc")` to install package 'mrsapdc'.

## Usage
After loading the library with the command `library(mrsapdc)`, get help on the main function by typing `?mrsa.pdc`.

## Note
The model described was used in a publication by [Elias et al. (2013)](https://bmcinfectdis.biomedcentral.com/articles/10.1186/1471-2334-13-111).

### Reference

Elias J, Heuschmann PU, Schmitt C, Eckhardt F, Boehm H, Maier S, Kolb-Mäurer A, Riedmiller H, Müllges W, Weisser C, Wunder C, Frosch M, Vogel U. Prevalence dependent calibration of a predictive model for nasal carriage of methicillin-resistant Staphylococcus aureus. BMC Infect Dis. 2013 Feb 28;13:111.
