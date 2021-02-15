﻿Public Class Barcode128
    Public Function Encode128A(chaine$) As String
        'Cette fonction est régie par la Licence Générale Publique Amoindrie GNU (GNU LGPL)
        'This function is governed by the GNU Lesser General Public License (GNU LGPL)
        'V 2.0.0
        'Paramètres : une chaine
        'Parameters : a string
        'Retour : * une chaine qui, affichée avec la police CODE128.TTF, donne le code barre
        '         * une chaine vide si paramètre fourni incorrect
        'Return : * a string which give the bar code when it is dispayed with CODE128.TTF font
        '         * an empty string if the supplied parameter is no good
        Dim i As Integer, checksum As Integer, mini As Integer, dummy As Integer, tableB As Boolean
        Encode128A = ""
        If Len(chaine$) > 0 Then
            'Vérifier si caractères valides
            'Check for valid characters
            For i% = 1 To Len(chaine$)
                Select Case Asc(Mid$(chaine$, i%, 1))
                    Case 32 To 126, 203
                    Case Else
                        i% = 0
                        Exit For
                End Select
            Next
            'Calculer la chaine de code en optimisant l'usage des tables B et C
            'Calculation of the code string with optimized use of tables B and C
            Encode128A = ""
            tableB = True
            If i% > 0 Then
                i% = 1 'i% devient l'index sur la chaine / i% become the string index
                Do While i% <= Len(chaine$)
                    If tableB Then
                        'Voir si intéressant de passer en table C / See if interesting to switch to table C
                        'Oui pour 4 chiffres au début ou à la fin, sinon pour 6 chiffres / yes for 4 digits at start or end, else if 6 digits
                        mini% = IIf(i% = 1 Or i% + 3 = Len(chaine$), 4, 6)
                        'GoTo testnum
                        If mini% < 0 Then 'Choix table C / Choice of table C
                            If i% = 1 Then 'Débuter sur table C / Starting with table C
                                Encode128A = Chr(210)
                            Else 'Commuter sur table C / Switch to table C
                                Encode128A = Encode128A & Chr(204)
                            End If
                            tableB = False
                        Else
                            If i% = 1 Then Encode128A = Chr(209) 'Débuter sur table B / Starting with table B
                        End If
                    End If
                    If Not tableB Then
                        'On est sur la table C, essayer de traiter 2 chiffres / We are on table C, try to process 2 digits
                        mini% = 2
                        'GoTo testnum
                        If mini% < 0 Then 'OK pour 2 chiffres, les traiter / OK for 2 digits, process it
                            dummy% = Val(Mid$(chaine$, i%, 2))
                            dummy% = IIf(dummy% < 95, dummy% + 32, dummy% + 105)
                            Encode128A = Encode128A & Chr(dummy%)
                            i% = i% + 2
                        Else 'On n'a pas 2 chiffres, repasser en table B / We haven't 2 digits, switch to table B
                            Encode128A = Encode128A & Chr(205)
                            tableB = True
                        End If
                    End If
                    If tableB Then
                        'Traiter 1 caractère en table B / Process 1 digit with table B
                        Encode128A = Encode128A & Mid$(chaine$, i%, 1)
                        i% = i% + 1
                    End If
                Loop
                'Calcul de la clé de contrôle / Calculation of the checksum
                For i% = 1 To Len(Encode128A)
                    dummy% = Asc(Mid$(Encode128A, i%, 1))
                    dummy% = IIf(dummy% < 127, dummy% - 32, dummy% - 105)
                    If i% = 1 Then checksum = dummy%
                    checksum = (checksum + (i% - 1) * dummy%) Mod 103
                Next
                'Calcul du code ASCII de la clé / Calculation of the checksum ASCII code
                checksum = IIf(checksum < 95, checksum + 32, checksum + 105)
                'Ajout de la clé et du STOP / Add the checksum and the STOP
                Encode128A = Encode128A & Chr(checksum) & Chr(211)
            End If
        End If
        Exit Function
testnum:
        'si les mini% caractères à partir de i% sont numériques, alors mini%=0
        'if the mini% characters from i% are numeric, then mini%=0
        mini% = mini% - 1
        If i% + mini% <= Len(chaine$) Then
            Do While mini% >= 0
                If Asc(Mid$(chaine$, i% + mini%, 1)) < 48 Or Asc(Mid$(chaine$, i% + mini%, 1)) > 57 Then Exit Do
                mini% = mini% - 1
            Loop
        End If
        Return Encode128A
    End Function
End Class
