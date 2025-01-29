* Programa: FoxMusic.prg
* Autor...: Juan Carlos Ocampo de la Cruz, 
* Fecha...: 23/05/2023 version FoxPro https://www.youtube.com/watch?v=q23IQBRXsbA&t=5s
* Creditos: IBM, programa original en GWBASIC, 1981, http://www.youtube.com/watch?v=y_bqgTDtV8s
*           Version en Clipper 04/11/1993, http://www.youtube.com/watch?v=1wQMHsqxo_s
*           SodaStereano@hotmail.com 
*           Acapulco, Mexico

SET ESCAPE OFF
SET TALK OFF   
SET BELL ON
SET COLOR TO W+/B,W+/R,R
SET MESSAGE TO 24 CENTER

DIMENSION aColumna(70)
nColumna =5
lTarSon  =.T.

*** llena el arreglo de las columnas donde se colocara el simbolo musical
FOR nIndice=1 TO 70
    IF nIndice>39
       nColumna=nColumna+1
    ENDIF
    IF nIndice=40 .OR. nIndice=45 .OR. nIndice=52 .OR. nIndice=57 .OR. nIndice=64 .OR. nIndice=70
       nColumna=nColumna+1
    ENDIF
    aColumna(nIndice)=nColumna
NEXT

CLEAR
@0,0 TO 23,79
@03,0 SAY CHR(195)+REPLICATE(CHR(196),78)+CHR(180)
@21,0 SAY CHR(195)+REPLICATE(CHR(196),78)+CHR(180)
SET COLOR TO GR*+/B
@0,34 SAY " FoxPro M£sica "
SET COLOR TO BG+/B
@02,1 SAY "(C) Copyright IBM & Juan Carlos Ocampo de la Cruz, 1982, 1993, 2023"
@22,1 SAY "["+CHR(25)+CHR(24)+"] Elige melodia  ["+CHR(17)+CHR(196)+CHR(217)+"] Toca   [Esc] Salir"

DO Piano

USE TONE

DO WHILE .T.
  
  @04,40 PROMPT "A Yankee Doodle                   " MESSAGE "A n ¢ n i m o"
  @05,40 PROMPT "B La Cucaracha                    " MESSAGE "Melodia tradicional Mexicana"
  @06,40 PROMPT "C Vals del Danubio Azul           " MESSAGE "Johann Strauss (1825-1899)"
  @07,40 PROMPT "D Humoresque                      " MESSAGE "Anton Dvorak (1841-1904)"
  @08,40 PROMPT "E Pop! Goes The Weasel            " MESSAGE "A n ¢ n i m o"
  @09,40 PROMPT "F Sinfon¡a 40                     " MESSAGE "Wolfgang Amadeus Mozart (27/01/1756 - 05/12/1791)"
  @10,40 PROMPT "G Funeral March of a Marionette   " MESSAGE "Carlos Gounod (1818-1893)"
  @11,40 PROMPT "H Estrellas y barras para siempre " MESSAGE "John Philipp Sousa (1854-1932)"
  @12,40 PROMPT "I El Sombrero                     " MESSAGE "Melodia tradicional Mexicana"
  @13,40 PROMPT "J Sakura                          " MESSAGE "Melodia tradicional Japonesa"
  @14,40 PROMPT "K Escalas                         " MESSAGE "E s c a l a s"
  
  MENU TO nOpcion
 
  SAVE SCREEN TO cPantalla

  IF nOpcion=0
     EXIT
  ELSE
     DO TOCA WITH nOpcion
  ENDIF
ENDDO

CLOSE DATABASE

CLEAR

SET TALK ON
SET BELL OFF

RETURN

*** Toca la melodia
PROCEDURE Toca
PARAMETER nOpcion

  lLinea11=.T.
  
  LOCA FOR FOLIO=nOpcion
  
  DO WHILE FOLIO=nOpcion

     *** coloca un simbolo musical en el teclado de piano
     IF lLinea11
       @11,aColumna(VALOR) SAY CHR(14)
       lLinea11=.F.
     ELSE
       @07,aColumna(VALOR) SAY CHR(13)
       lLinea11=.T.
     ENDIF
     
     * Formula para calcular frecuencias
     nFrecuencia=36.8*(2^(1/12))^(VALOR-6)

     DO SOUND WITH nFRECUENCIA,DURACION
           
     RESTORE SCREEN FROM cPantalla
     
     IF INKEY()=27 && Esc 
	   EXIT
     ENDIF
         
     SKIP
  ENDDO

RETURN

*** Dibuja teclado de piano
PROCEDURE Piano
  SET COLOR TO W+/N
  FOR nColumna=0 TO 15
    FOR nLinea=0 TO 8
      @5+nLinea,5+nColumna*2 SAY CHR(219)+CHR(221)
    NEXT
  NEXT

  FOR nColumna=0 TO 12
    FOR nLinea=0 TO 4
      IF nColumna=2 .OR. nColumna=6 .OR. nColumna=9
	    LOOP
      ENDIF
      @5+nLinea,8+nColumna*2 SAY CHR(32)+CHR(222)
    NEXT
  NEXT

  FOR nLinea=0 TO 9
    SET COLOR TO R/N
    @4+nLinea,4  SAY CHR(221)
    SET COLOR TO W+/N
    @4+nLinea,36 SAY CHR(221)
    SET COLOR TO R/B
    ??CHR(221)
  NEXT
  @4,4 SAY CHR(219)
  FOR nColumna=0 TO 31
    ??CHR(219)
  NEXT
  ??CHR(221)
  @13,4 SAY CHR(219)
  FOR nColumna=0 TO 31
    ??CHR(219)
  NEXT
  ??CHR(221)
  SET COLOR TO W+/B
RETURN

* You can adjust the pitch of the bell and the length of time the bell is
* sounded with SET BELL TO.  Specify the pitch with <frequency>, which can be
* 19 through 10,000 hertz.  The default frequency is 512 hertz.  Specify the
* length of time with <duration>, which can be 1 through 19 seconds.  The
* default duration is 2 seconds.
PROCEDURE SOUND
PARAMETER nFrec,nDurac
  SET BELL TO nFrec,nDurac
  ??CHR(7)
RETURN
