;; 1. Based on: 
;; 2. Description: 2 cmt, 1st order oral
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

$INPUT C ID TIME TAPD AMT DV MDV EVID ADDL II CMT BLQ OCC STUDYID DOSE DAY AGE BCRCL BWT SEXM RACE RATE=DROP

$DATA ../DerivedData/AZD0000_nm_20190102.csv IGNORE=@ IGNORE=(BLQ.EQ.1)

$SUB ADVAN4 TRANS4

$PK

TVKA = THETA(1)
KA   = TVKA * EXP(ETA(1))

TVCL  = THETA(2)
CL    = TVCL * EXP(ETA(2))

TVV2  = THETA(3)
V2    = TVV2 * EXP(ETA(3))

TVQ  = THETA(4)
Q    = TVQ * EXP(ETA(4))

TVV3 = THETA(5)
V3   = TVV3 * EXP(ETA(5))

S2 = V2

$ERROR 

IPRED = F

W = SQRT(SIGMA(1,1)*IPRED**2 + SIGMA(2,2))  ; proportional + additive error
IRES = DV-IPRED
IWRES = IRES/W

Y = IPRED + IPRED*EPS(1) + EPS(2)

$THETA
1.5         ; KA  ; h-1 ; 
9          	; CL  ; L/h ; 
65          ; V2  ; L   ; 
20         	; Q   ; L/h ; 
200         ; V3  ; L   ; 

$OMEGA 
0 FIX 	          ; IIV_KA ; 
0.1			          ; IIV_CL ; 
0.1			          ; IIV_V2 ; 
0 FIX			        ; IIV_Q  ; 
0 FIX			        ; IIV_V3 ; 

$SIGMA
0.1           	; prop error
0 FIX          	; add error


; Parameter estimation - FOCE
$EST METHOD=1 INTER NOABORT MAXEVAL=9999 PRINT=1 NSIG=3 SIGL=9 MSFO=MSF001

$COV MATRIX=R PRINT=E UNCONDITIONAL SIGL=10

$TABLE ID TIME TAPD AMT DV MDV EVID ADDL II CMT BLQ OCC STUDYID DOSE DAY AGE BCRCL BWT SEXM RACE PRED IPRED IWRES IRES CWRES NPDE KA CL V2 Q V3 ETAS(1:LAST) 
NOPRINT NOAPPEND ONEHEADER ESAMPLE=1000 SEED=190108854 FILE=tab001
