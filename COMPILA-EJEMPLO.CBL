 ****** ***************************** Top of Data ***************************
 000001 //KC03J29C JOB CLASS=A,MSGCLASS=O,MSGLEVEL=(1,1),NOTIFY=&SYSUID,     
 000002 //             TIME=(,3)                                             
 000003 //JCLLIB       JCLLIB ORDER=KC02787.CURSOS.PROCLIB                   
 000004 //***********************************************                    
 000005 //*   COMPILADOR COBOL BATCH                    *                    
 000006 //*   ALUMLIB DIGITAR SU USERID ALUMNO          *                    
 000007 //*   REEMPLAZANDO XXX POR 3 ULT LETRAS USER ID *                    
 000008 //*                                             *                    
 000009 //*   GOPGM DIGITAR SU PROGRAM-ID               *                    
 000010 //*         EL MISMO DEBE ESTAR EN              *                    
 000011 //*         KC03XXX.CURSOS.FUENTE               *                    
 000012 //*                                             *                    
 000013 //*   COBOL.SYSLIB PARA UTILIZAR COPY DE        *                    
 000014 //*   ESTRUCTURA DE DATOS EN WORKING STORAGE    *                    
 000015 //*                                             *                    
 000016 //*   PARA VER SALIDA DE COMPILE INGRESAR       *                    
 000017 //*   AL SPOOL MEDIANTE OPCIóN SD               *                    
 000018 //*   PREFIX KC03XXX* U OWNER KC03XXX           *                    
 000019 //*                                             *                    
 000020 //*                                             *                    
 000021 //***********************************************                    
 000022 //STEP1  EXEC COMPCOBO,                                              
 000023 //       ALUMLIB=KC03J29.CURSOS,                                     
 000024 //       GOPGM=PGMAPJ29                                              
 000025 //COBOL.SYSLIB DD DSN=KC02788.ALU9999.COPYLIB,DISP=SHR               
 ****** **************************** Bottom of Data *************************
                                                                             
                                                                             
                                                                             
                                                                             