Class {
	#name : #DPFalsePositiveTests,
	#superclass : #DPDetectorTest,
	#category : #'Duplication-Detection-Tests'
}

{ #category : #accessing }
DPFalsePositiveTests >> insideProcedureDivision [
	^ '###### *PROCEDURE *DIVISION*'
]

{ #category : #tests }
DPFalsePositiveTests >> testForAbsenceOfFalsePositives [
	| dupSys |
	dupSys := DPDetector
		runOn:
			{(self mockProgramWith: self text1).
			(self mockProgramWith: self text2)}
		parametrizedWith:
			(DPParameters new
				minNumberOfLines: 20;
				frequency: 2;
				minNumberOfCharacters: 75;
				cleaner: DPCobolCleaner new).
	self assert: dupSys fragments size equals: 0
]

{ #category : #tests }
DPFalsePositiveTests >> testForAbsenceOfFalsePositivestext3and4 [
	| dupSys |
	dupSys := DPDetector
		runOn:
			{(self mockProgramWith: self text3).
			(self mockProgramWith: self text4)}
		parametrizedWith:
			(DPParameters new
				minNumberOfLines: 19;
				frequency: 2;
				minNumberOfCharacters: 75;
				cleaner: DPCobolCleaner new).
	self assert: dupSys fragments size equals: 1
]

{ #category : #tests }
DPFalsePositiveTests >> testForSameHash [
	|firstStringHash secondStringHash|
	firstStringHash := 'CONVERT-NOPO.IFELE-POL-ANC(I-CONVER)=WK-NOPO-1A2MOVEELE-POL-NOU(I-CONVER)TORX-NOPO-1A3MOVE200TOI-CONVER.N02-TRAIT-CONFECTION.IFLANPINCSGPAI=''N''THENMOVE2TOI-LANGUEELSEMOVE1TOI-LANGUE.PERFORMTRAIT-QUITTANCEMENTTHRUEND-TRAIT-QUITTANCEMENT.MOVEW-ZONE-NOMTOCTIT-NOM1-PNOMINLIGNE1.MOVEADR1INCSGNRITOADR1INLIGNE2.MOVEW-ZONE-ADR2TOADR2INLIGNE3.MOVESPACESTOLIGNE4-VILLEIF(COPAINCSGNRINOT=''B''ANDCOPAINCSGNRINOT=SPACESANDCOPAINCSGNRINOT=LOW-VALUE)STRING' hash.
	secondStringHash := 'MOVENOQIINCSGQII-IOTONOQIINQIIK.ADD1TONOQIINQIIK.MOVE+4TOWK-PCB.EXECDLIGNUSINGPCB(WK-PCB)SEGMENT(SGQII)SEGLENGTH(CSGQII-L)INTO(CSGQII-IO)END-EXEC.IFDIBSTAT=''GB''MOVENOQIINQIIKTONOQIINCSGQIIGOTOGN-END-NEW-HERE.IFDIBSTATNOT=''''THENDISPLAY''PROB99''DIVIDEK-VALEUR-UNBYK-VALEUR-ZEROGIVINGK-VALEURGOBACK.IFCEQIINCSGQII-IO=''00''ORCEQIINCSGQII-IO=''01''ORCEQIINCSGQII-IO=''09''THENMOVE''Y''TOSW-CONTENTIEUX.IFNOSOINQIIKNOT=NOSOINCSGQII-IOORNOPOINQIIKNOT=NOPOINCSGQII-IO' hash.
		self flag: #Pharo40.
		(Smalltalk version = 'Pharo4.0'
				ifTrue: [ self assert: firstStringHash equals: secondStringHash. ]
				ifFalse: [ self deny: firstStringHash = secondStringHash. ])
	
]

{ #category : #samples }
DPFalsePositiveTests >> text1 [
	^ self insideProcedureDivision, '
VD9404     CALL ''RXBARCOD''   USING ZONEINN ZONEOUTN.

VD9404     MOVE ZONEOUTN                  TO RX-CBAR.
VD9404     MOVE ZONEINN                   TO IN-CBAR.
VD9404     MOVE SPACES                    TO IN-CBARM.

       CONVERT-NOPO.
      *============*
           IF ELE-POL-ANC (I-CONVER) = WK-NOPO-1A2
              MOVE ELE-POL-NOU (I-CONVER) TO RX-NOPO-1A3
              MOVE 200                     TO I-CONVER.


       N02-TRAIT-CONFECTION.
      *--------------------*
           IF LANP           IN CSGPAI  = ''N''
           THEN
               MOVE 2                 TO I-LANGUE
           ELSE
               MOVE 1                 TO I-LANGUE.

920511         PERFORM TRAIT-QUITTANCEMENT
920511            THRU END-TRAIT-QUITTANCEMENT.

           MOVE W-ZONE-NOM           TO CTIT-NOM1-PNOM IN LIGNE1.
           MOVE ADR1 IN CSGNRI       TO ADR1 IN LIGNE2.
           MOVE W-ZONE-ADR2          TO ADR2 IN LIGNE3.
DD9603     MOVE SPACES TO LIGNE4-VILLE
DD9603     IF ( COPA IN CSGNRI NOT = ''B  ''  AND
DD9603          COPA IN CSGNRI NOT = SPACES AND
DD9603          COPA IN CSGNRI NOT = LOW-VALUE )
DD9603          STRING
DD9603          COPA IN CSGNRI DELIMITED BY SIZE '' ''
DD9603          CPOS IN CSGNRI DELIMITED BY SIZE '' ''
DD9603          LOCA IN CSGNRI DELIMITED BY SIZE
DD9603          INTO    LIGNE4-VILLE
DD9603     ELSE
           MOVE CPOS IN CSGNRI       TO CPOS IN LIGNE4
           MOVE LOCA IN CSGNRI       TO LOCA IN LIGNE4.
           MOVE NOAG IN CSGPAA       TO NOAG IN LIGNE5.
           MOVE NOPO IN CSGPAI       TO NOPO IN LIGNE6.
'
]

{ #category : #samples }
DPFalsePositiveTests >> text2 [
	^ self insideProcedureDivision, '
            IF CEQI IN CSGQII-IO = ''00'' OR
               CEQI IN CSGQII-IO = ''01'' OR
               CEQI IN CSGQII-IO = ''09''
            THEN MOVE ''Y'' TO SW-CONTENTIEUX
            PERFORM GN-NEW-HERE THRU GN-END-NEW-HERE
            ELSE
            PERFORM GN-NEW-HERE THRU GN-END-NEW-HERE.
       END-READ-QII.        EXIT.

       GN-NEW-HERE.
            MOVE NOQI IN CSGQII-IO  TO       NOQI IN QIIK.
            ADD 1                   TO       NOQI IN QIIK.
           MOVE +4 TO WK-PCB.
           EXEC DLI GN USING PCB(WK-PCB)
                    SEGMENT (SGQII)       SEGLENGTH (CSGQII-L)
                    INTO (CSGQII-IO)
                    END-EXEC.
             IF DIBSTAT  = ''GB''
             MOVE NOQI IN QIIK TO NOQI IN CSGQII
             GO TO GN-END-NEW-HERE.
            IF DIBSTAT NOT = ''  ''
GN0201*     THEN  DISPLAY ''PROB 99 ''  GOBACK.
GN0201      THEN  DISPLAY ''PROB 99 ''
GN0201            DIVIDE K-VALEUR-UN BY K-VALEUR-ZERO GIVING K-VALEUR
GN0201            GOBACK.
            IF CEQI IN CSGQII-IO = ''00'' OR
               CEQI IN CSGQII-IO = ''01'' OR
               CEQI IN CSGQII-IO = ''09''
            THEN MOVE ''Y'' TO SW-CONTENTIEUX.

            IF NOSO IN QIIK NOT = NOSO IN CSGQII-IO OR
               NOPO IN QIIK NOT = NOPO IN CSGQII-IO
            THEN
             MOVE NOQI IN QIIK TO NOQI IN CSGQII
             GO TO GN-END-NEW-HERE.

            GO TO GN-NEW-HERE.

       GN-END-NEW-HERE.      EXIT.

      *****************************************************************
      ******************************************************************
'
]

{ #category : #samples }
DPFalsePositiveTests >> text3 [ 
	^ self insideProcedureDivision, '           DISPLAY '' ''.
           DISPLAY '' ''.
           MOVE NB-PAI-LUS TO EDIT.
           DISPLAY ''NB PAI LUS                            = '' EDIT.
           DISPLAY '' ''.
           MOVE NB-ECRITS TO EDIT.
           DISPLAY ''NB ENR ECRITS                         = '' EDIT.
           DISPLAY '' ''.
           MOVE NB-A TO EDIT.
           DISPLAY ''NB POLICES ANNULEES                   = '' EDIT.
           DISPLAY '' ''.
           MOVE NB-S TO EDIT.
           DISPLAY ''NB POLICES SUSPENDUES                 = '' EDIT.
           DISPLAY '' ''.
           MOVE NB-R TO EDIT.
           DISPLAY ''NB POLICES REMPLACEES                 = '' EDIT.
           DISPLAY '' ''.
           MOVE NO-PAA TO EDIT.
           DISPLAY ''NB PAI SANS PAA                       = '' EDIT.
           DISPLAY '' ''.
'
]

{ #category : #samples }
DPFalsePositiveTests >> text4 [
	^ self insideProcedureDivision, '           DISPLAY '' ''.
           DISPLAY '' ''.
           MOVE NB-PAI-LUS TO EDIT.
           DISPLAY ''NB PAI LUS                            = '' EDIT.
           DISPLAY '' ''.
           MOVE NB-ECRITS TO EDIT.
           DISPLAY ''NB ENR ECRITS                         = '' EDIT.
           DISPLAY '' ''.
           MOVE NB-A TO EDIT.
           DISPLAY ''NB POLICES ANNULEES                   = '' EDIT.
           DISPLAY '' ''.
           MOVE NB-S TO EDIT.
           DISPLAY ''NB POLICES SUSPENDUES                 = '' EDIT.
           DISPLAY '' ''.
           MOVE NB-R TO EDIT.
           DISPLAY ''NB POLICES REMPLACEES                 = '' EDIT.
           DISPLAY '' ''.
           MOVE NO-PAA TO EDIT.
           DISPLAY ''NB PAI SANS PAA                       = '' EDIT.
           DISPLAY '' ''.
DD0901     MOVE CTR-CREN-00 TO EDIT
DD0901     DISPLAY ''NB PAI (COURT TERME) IGNORE           = '' EDIT.
DD0901     DISPLAY '' ''.
           DISPLAY ''**************************************************''.
           DISPLAY '' ''.

LM1109 AFFICHER-NON-AUTO-BIS.
LM1109*---------------------*
LM1109     DISPLAY '' ''.
LM1109     DISPLAY ''******************   AFFICHER   ******************''.
LM1109     DISPLAY ''***                  NON-AUTO  HP !!!         ****''.
LM1109     DISPLAY '' ''.
LM1109     DISPLAY '' ''.
LM1109     MOVE NB-PAI-LUS TO EDIT.
LM1109     DISPLAY ''NB PAI LUS                            = '' EDIT.
LM1109     DISPLAY '' ''.
LM1109     MOVE NB-ECRITS TO EDIT.
LM1109     DISPLAY ''NB ENR ECRITS                         = '' EDIT.
LM1109     DISPLAY '' ''.
LM1109     MOVE NB-A TO EDIT.
LM1109     DISPLAY ''NB POLICES ANNULEES                   = '' EDIT.
LM1109     DISPLAY '' ''.
LM1109     MOVE NB-S TO EDIT.
LM1109     DISPLAY ''NB POLICES SUSPENDUES                 = '' EDIT.
LM1109     DISPLAY '' ''.
LM1109     MOVE NB-R TO EDIT.
LM1109     DISPLAY ''NB POLICES REMPLACEES                 = '' EDIT.
LM1109     DISPLAY '' ''.
LM1109     MOVE NO-PAA TO EDIT.
LM1109     DISPLAY ''NB PAI SANS PAA                       = '' EDIT.
LM1109     DISPLAY '' ''.
'
]
