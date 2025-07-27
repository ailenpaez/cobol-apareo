 =COLS> ----+----1----+----2----+----3----+----4----+----5----+----6----+----7--
 ****** ***************************** Top of Data ******************************
 000100        IDENTIFICATION DIVISION.                                         
 000200       *                                                        *        
 000300        PROGRAM-ID. PGMAPJ29.                                            
 000400       **********************************************************        
 000500       *                                                        *        
 000600       *  OBJETIVO: TP - PRÁCTICA APAREO                        *        
 000700       *                                                        *        
 000900       **********************************************************        
 001000        ENVIRONMENT DIVISION.                                            
 001100        INPUT-OUTPUT SECTION.                                            
 001200        FILE-CONTROL.                                                    
 001300              SELECT CLIENTE-FILE ASSIGN TO DDCLI.                       
 001400              SELECT MOVIM-FILE ASSIGN TO DDMOV.                         
 001500              SELECT CLIENTE-UPD ASSIGN TO DDCLIUPD.                     
 002100                                                                         
 002200        DATA DIVISION.                                                   
 002300        FILE SECTION.                                                    
 002400        FD CLIENTE-FILE.                                                 
 002410        COPY CLIENTE.                                                    
 002420                                                                         
 002430        FD MOVIM-FILE.                                                   
 002440        COPY MOVIMCC.                                                    
 002450                                                                         
 002460        FD CLIENTE-UPD.                                                  
 002470        COPY CLIENTE.                                                    
 026032                                                                         
 026038        WORKING-STORAGE SECTION.                                         
 026039                                                                         
 026040        01 WS-SWITCHES.                                                  
 026050            05 WS-FIN-CLIENTE         PIC X VALUE 'N'.                   
 026060               88 FIN-CLIENTE             VALUE 'S'.                     
 026070            05 WS-FIN-MOVIM           PIC X VALUE 'N'.                   
 026080               88 FIN-MOVIM               VALUE 'S'.                     
 026081               88 NO-FIN-MOVIM            VALUE 'N'.                     
 026082                                                                         
 026083        01 WS-CLAVES.                                                    
 026084            05 WS-CLAVE-CLI.                                             
 026085               10 WS-NRO-CLI          PIC 9(05).                         
 026086               10 WS-CLAVE-CUE-CLI.                                      
 026087                  15 WS-TIPO-CUE-CLI  PIC 9(02).                         
 026088                  15 WS-NUM-CUE-CLI   PIC 9(08).                         
 026089            05 WS-CLAVE-MOV.                                             
 026090               10 WS-NRO-CLI-MOV      PIC 9(05).                         
 026091               10 WS-CLAVE-MOV-MOV.                                      
 026092                  15 WS-TIPO-MOV-MOV  PIC 9(02).                         
 026093                  15 WS-NUM-MOV-MOV   PIC 9(08).                         
 026094                                                                         
 026095        01 WS-CONTADORES.                                                
 026096            05 WS-REG-CLI-LEIDOS      PIC 9(06) VALUE 0.                 
 026097            05 WS-REG-MOV-LEIDOS      PIC 9(06) VALUE 0.                 
 026098            05 WS-REG-CLI-ACTUAL      PIC 9(06) VALUE 0.                 
 026099            05 WS-MOV-SIN-CLIENTE     PIC 9(06) VALUE 0.                 
 026100                                                                         
 026101       * CORRECCION                                                      
 026102        01 WS-REGIS-TRABAJO.                                             
 026103           03 WS-TRAB-NRO            PIC 9(05).                          
 026104           03 WS-TRAB-TIP            PIC 9(02).                          
 026105           03 WS-TRAB-CUENTA         PIC 9(08).                          
 026106           03 WS-TRAB-SALDO          PIC S9(09)V99.                      
 026107                                                                         
 026108        PROCEDURE DIVISION.                                              
 026109                                                                         
 026110                                                                         
 026111        INICIO.                                                          
 026112            DISPLAY " * INICIO APAREO * ".                               
 026113                                                                         
 026114            OPEN INPUT CLIENTE-FILE                                      
 026115                 INPUT MOVIM-FILE                                        
 026116                 OUTPUT CLIENTE-UPD.                                     
 026117                                                                         
 026118            PERFORM LEER-CLIENTE.                                        
 026119            PERFORM LEER-MOVIMIENTO.                                     
 026120                                                                         
 026121            PERFORM PROCESO-APAREO                                       
 026122                 UNTIL FIN-CLIENTE AND FIN-MOVIM.                        
 026123                                                                         
 026124            CLOSE CLIENTE-FILE                                           
 026125                  MOVIM-FILE                                             
 026126                  CLIENTE-UPD.                                           
 026127                                                                         
 026128            PERFORM MOSTRAR-ESTADISTICAS.                                
 026129                                                                         
 026130            DISPLAY " * FIN PROCESO APAREO * ".                          
 026131            STOP RUN.                                                    
 026132                                                                         
 026133        LEER-CLIENTE.                                                    
 026134            READ CLIENTE-FILE                                            
 026135                 AT END                                                  
 026136                    SET FIN-CLIENTE TO TRUE                              
 026137                 NOT AT END                                              
 026138                    ADD 1 TO WS-REG-CLI-LEIDOS                           
 026139                    MOVE WS-CLI-NRO OF CLIENTE-FILE TO WS-NRO-CLI        
 026140                    MOVE WS-CLI-TIPO OF CLIENTE-FILE TO WS-TIPO-CUE-CLI  
 026141                    MOVE WS-CLI-CUENTA OF CLIENTE-FILE TO WS-NUM-CUE-CLI 
 026142                    MOVE WS-CLI-NRO OF CLIENTE-FILE TO WS-TRAB-NRO       
 026143                    MOVE WS-CLI-TIPO OF CLIENTE-FILE TO WS-TRAB-TIP      
 026144                    MOVE WS-CLI-CUENTA OF CLIENTE-FILE TO WS-TRAB-CUENTA 
 026145                    MOVE WS-CLI-SALDO OF CLIENTE-FILE TO WS-TRAB-SALDO   
 026146            END-READ.                                                    
 026147                                                                         
 026148        LEER-MOVIMIENTO.                                                 
 026149            READ MOVIM-FILE                                              
 026150                 AT END                                                  
 026151                     SET FIN-MOVIM TO TRUE                               
 026152                 NOT AT END                                              
 026153                     ADD 1 TO WS-REG-MOV-LEIDOS                          
 026154                     MOVE WS-MOV-NRO    TO WS-NRO-CLI-MOV                
 026155                     MOVE WS-MOV-TIPO   TO WS-TIPO-MOV-MOV               
 026156                     MOVE WS-MOV-CUENTA TO WS-NUM-MOV-MOV                
 026157            END-READ.                                                    
 026158                                                                         
 026159        PROCESO-APAREO.                                                  
 026160            EVALUATE TRUE                                                
 026161                 WHEN FIN-CLIENTE AND FIN-MOVIM                          
 026162                      CONTINUE                                           
 026163                 WHEN FIN-CLIENTE AND NO-FIN-MOVIM                       
 026164                      PERFORM MOVIM-SIN-CLIENTE                          
 026165                 WHEN WS-CLAVE-CLI < WS-CLAVE-MOV                        
 026166                      PERFORM CLIENTE-SIN-MOVIM                          
 026167                 WHEN WS-CLAVE-CLI = WS-CLAVE-MOV                        
 026168                      PERFORM ACTUALIZAR-CLIENTE                         
 026169                 WHEN WS-CLAVE-CLI > WS-CLAVE-MOV                        
 026170                      PERFORM MOVIM-SIN-CLIENTE                          
 026171            END-EVALUATE.                                                
 026172                                                                         
 026173        CLIENTE-SIN-MOVIM.                                               
 026174            MOVE WS-TRAB-NRO TO WS-CLI-NRO OF CLIENTE-UPD                
 026175            MOVE WS-TRAB-TIP TO WS-CLI-TIPO OF CLIENTE-UPD               
 026176            MOVE WS-TRAB-CUENTA TO WS-CLI-CUENTA OF CLIENTE-UPD          
 026177            MOVE WS-TRAB-SALDO TO WS-CLI-SALDO OF CLIENTE-UPD            
 026178            WRITE WS-REG-CLIENTE OF CLIENTE-UPD                          
 026179            PERFORM LEER-CLIENTE.                                        
 026180                                                                         
 026181        ACTUALIZAR-CLIENTE.                                              
 026182            ADD WS-MOV-IMPORTE TO WS-TRAB-SALDO.                         
 026183            MOVE WS-TRAB-NRO TO WS-CLI-NRO OF CLIENTE-UPD                
 026184            MOVE WS-TRAB-TIP TO WS-CLI-TIPO OF CLIENTE-UPD               
 026185            MOVE WS-TRAB-CUENTA TO WS-CLI-CUENTA OF CLIENTE-UPD          
 026186            MOVE WS-TRAB-SALDO TO WS-CLI-SALDO OF CLIENTE-UPD            
 026187            WRITE WS-REG-CLIENTE OF CLIENTE-UPD.                         
 026188            ADD 1 TO WS-REG-CLI-ACTUAL.                                  
 026189            PERFORM LEER-CLIENTE.                                        
 026190            PERFORM LEER-MOVIMIENTO.                                     
 026191                                                                         
 026192        MOVIM-SIN-CLIENTE.                                               
 026193            DISPLAY "CLIENTE/CUENTA NO ENCONTRADA: "                     
 026194                  WS-NRO-CLI-MOV   " - "                                 
 026195                  WS-TIPO-MOV-MOV  " - "                                 
 026196                  WS-NUM-MOV-MOV.                                        
 026197            ADD 1 TO WS-MOV-SIN-CLIENTE.                                 
 026198            PERFORM LEER-MOVIMIENTO.                                     
 026199                                                                         
 026200        MOSTRAR-ESTADISTICAS.                                            
 026210            DISPLAY "***********************".                           
 026300            DISPLAY "REGISTRO CLIENTE LEIDOS: " WS-REG-CLI-LEIDOS.       
 026400            DISPLAY "REGISTROS MOVIM LEIDOS:  " WS-REG-MOV-LEIDOS.       
 026500            DISPLAY "CLIENTES ACTUALIZADOS:   " WS-REG-CLI-ACTUAL.       
 026600            DISPLAY "MOVIMIENTOS SIN CLIENTE: " WS-MOV-SIN-CLIENTE.      
 026700            DISPLAY "************************".                          
 ****** **************************** Bottom of Data ****************************