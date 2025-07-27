 ****** ***************************** Top of Data ***************************
 000001 //KC03J29A JOB CLASS=A,MSGCLASS=O,MSGLEVEL=(1,1),NOTIFY=&SYSUID,     
 000002 //             TIME=(,5) ,RESTART=STEP4                              
 000003 //************************************                               
 000004 //* EJEMPLO EJECUCION JOB BATCH      *                               
 000005 //************************************                               
 000006 //*                                                                  
 000007 //STEP1    EXEC PGM=IDCAMS,COND=(8,LT)                               
 000008 //SYSPRINT DD SYSOUT=*                                               
 000009 //SYSIN    DD *                                                      
 000010      DELETE   KC03J29.ALU9999.CLIENTE.CLAS                           
 000011      DELETE   KC03J29.ALU9999.MOVIMICC.CLAS                          
 000012      DELETE   KC03J29.ALU9999.SALCLIEN.NUE                           
 000013      SET MAXCC=0                                                     
 000014 //*                                                                  
 000015 //*********************************                                  
 000016 //*     SORT POR CLIENTE          *                                  
 000017 //*********************************                                  
 000018 //STEP2       EXEC PGM=SORT,COND=EVEN                                
 000019 //SYSOUT    DD SYSOUT=*                                              
 000020 //SORTIN    DD DSN=KC02788.ALU9999.CLIENTE,DISP=SHR                  
 000021 //SORTOUT   DD DSN=KC03J29.ALU9999.CLIENTE.CLAS,DISP=(,CATLG),       
 000022 //          UNIT=SYSDA,VOL=SER=ZASWO1,                               
 000023 //          DCB=(LRECL=30,BLKSIZE=3000,RECFM=FB),                    
 000024 //          SPACE=(TRK,(1,1),RLSE)                                   
 000025 //SYSIN     DD *                                                     
 000026  SORT       FORMAT=BI,FIELDS=(10,5,A)                                
 000027 //*                                                                  
 000028 //*********************************                                  
 000029 //*     SORT POR CLIENTE          *                                  
 000030 //*********************************                                  
 000031 //STEP3       EXEC PGM=SORT,COND=EVEN                                
 000032 //SYSOUT    DD SYSOUT=*                                              
 000033 //SORTIN    DD DSN=KC02788.ALU9999.MOVIMICC,DISP=SHR                 
 000034 //SORTOUT   DD DSN=KC03J29.ALU9999.MOVIMICC.CLAS,DISP=(,CATLG),      
 000035 //          UNIT=SYSDA,VOL=SER=ZASWO1,                               
 000036 //          DCB=(LRECL=80,BLKSIZE=8000,RECFM=FB),                    
  000037 //          SPACE=(TRK,(1,1),RLSE)                                   
 000038 //SYSIN     DD *                                                     
 000039  SORT       FORMAT=BI,FIELDS=(1,5,A)                                 
 000040 //*                                                                  
 000041 //*                                                                  
 000042 //************************************                               
 000043 //* EJECUCION PROGRAMA PGMAPAR       *                               
 000044 //************************************                               
 000045 //STEP4    EXEC PGM=PGMAPJ29                                         
 000046 //STEPLIB  DD DSN=KC03J29.CURSOS.PGMLIB,DISP=SHR                     
 000047 //DDCLI    DD DSN=KC03J29.ALU9999.CLIENTE.CLAS,DISP=SHR              
 000048 //DDMOV    DD DSN=KC03J29.ALU9999.MOVIMICC.CLAS,DISP=SHR             
 000049 //DDCLIUPD DD DSN=KC03J29.ALU9999.SALCLIEN.NUE,DISP=(NEW,CATLG,CATLG)
 000050 //            UNIT=SYSDA,VOL=SER=ZASWO1,                             
 000051 //            DCB=(LRECL=30,BLKSIZE=3000,RECFM=FB),                  
 000052 //            SPACE=(TRK,(1,1),RLSE)                                 
 000053 //SYSOUT   DD SYSOUT=*,OUTLIM=1000                                   
 000054 //SYSUDUMP DD SYSOUT=*                                               
 000055 //SYSIN    DD *                                                      
 000056 240430                                                               
 000057 //                                                                   
 ****** **************************** Bottom of Data *************************