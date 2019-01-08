;; 1. Based on: 
;; 2. Description: 1 cmt, 1st order oral
;; x1. Author: Helena Edlund

$PROBLEM Demo PK workflow

;; 4. Date: 2019.01.08
;; 5. Version: 1
;; 6. Label:
;; Basic model
;; 7. Structural model:
;; One compartment model
;; 8. Covariate model:
;; No covariates
;; 9. Inter-individual variability:
;; CL and V
;; 10. Inter-occasion variability:
;; No IOV
;; 11. Residual variability:
;; Proportional
;; 12. Estimation:
;; FOCE

$INPUT C ID TIME TAPD AMT DV MDV EVID ADDL II CMT BLQ OCC STUDYID DOSE DAY AGE BCRCL BWT SEXM RACE RATE

$DATA AZD0000_nm_20190102.csv IGNORE=@ IGNORE=(BLQ.EQ.1)

$SUB ADVAN2 TRANS2

$PK

TVKA = EXP(THETA(1))
MU_1 = LOG(TVKA)
KA   = EXP(MU_1+ETA(1))

TVCL  = EXP(THETA(2))
MU_2 = LOG(TVCL)
CL = EXP(MU_2+ETA(2))

TVV = EXP(THETA(3))
MU_3 = LOG(TVV)
V    = EXP(MU_3+ETA(3))

S2 = V

$ERROR 

IPRED = F
W = SQRT(SIGMA(1,1)*IPRED**2 + SIGMA(2,2))  ; proportional + additive error
IRES = DV-IPRED
IWRES = IRES/W
Y = IPRED + IPRED*EPS(1) + EPS(2)


$THETA
1          	; KA ; h-1 ; LOG
9          	; CL ; L/h ; LOG
280         ; V  ; L ; LOG

$OMEGA 
0 FIX 	          ; IIV_KA ; LOG
0.1			          ; IIV_CL ; LOG
0.1			          ; IIV_V  ; LOG

$SIGMA
0.1           	; prop error
0 FIX          	; add error


; Parameter estimation - FOCE
$EST METHOD=1 INTER NOABORT MAXEVAL=9999 PRINT=1 NSIG=3 SIGL=9 MSFO=MSF001

$COV MATRIX=R PRINT=E UNCONDITIONAL SIGL=10

$TABLE ID TIME TAPD AMT DV MDV EVID ADDL II CMT BLQ OCC STUDYID DOSE DAY AGE BCRCL BWT SEXM RACE RATE PRED IPRED IWRES IRES CWRES NPDE KA CL V ETAS(1:LAST) 
NOPRINT NOAPPEND ONEHEADER FORMAT=tF13.4 ESAMPLE=1000 SEED=190108854 FILE=tab001
