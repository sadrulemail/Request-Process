using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RequestProcess.Class
{
    public class IDAutomation
    {

        int I = 0;
        int J = 0;
        int F = 0;
        string DataToPrint = null;
        string OnlyCorrectData = null;
        string PrintableString = null;
        string Encoding = null;
        long WeightedTotal = 0;
        int WeightValue = 0;
        long CurrentValue = 0;
        int CheckDigitValue = 0;
        int Factor = 0;
        int CheckDigit = 0;
        string CurrentEncoding = null;
        string NewLine = null;
        string msg = null;
        string CurrentChar = null;
        int CurrentCharNum = 0;
        string C128_StartA = null;
        string C128_StartB = null;
        string C128_StartC = null;
        string C128_Stop = null;
        string C128Start = null;
        string C128CheckDigit = null;
        string StartCode = null;
        string StopCode = null;
        string Fnc1 = null;
        int LeadingDigit = 0;
        string EAN2AddOn = null;
        string EAN5AddOn = null;
        string EANAddOnToPrint = null;
        string HumanReadableText = null;
        int StringLength = 0;
        int CorrectFNC = 0;
        int CID = 0;
        int FID = 0;
        int NCID = 0;


        public string Code128(string DataToFormat, int ReturnType = 0, bool ApplyTilde = false)
        {
            string functionReturnValue = null;
            //This method has been updated to support ReturnTypes 6 to 9,
            //which increases its complexity. IDAutomation suggests using
            //the prior version (http://www.idautomation.com/fonts/tools/barcodeapp/module1.txt)
            //of this code when performing conversions or modifications.
            //ReturnTypes are explained at http://www.idautomation.com/barcode/return-type.html
            //
            //The next 12 lines were added to support ReturnTypes 6-9
            CID = 0;
            //Character ID
            NCID = 0;
            //Numbers Character ID (for set C)
            FID = 0;
            //Function ID used for start, stop and check characters
            if (ReturnType == 6 | ReturnType == 7)
                CID = 11000;
            if (ReturnType == 8)
                CID = 11300;
            if (ReturnType == 9)
                CID = 11500;
            if (ReturnType == 6 | ReturnType == 9)
                FID = 11500;
            if (ReturnType == 7 | ReturnType == 8)
                FID = 11300;
            if (ReturnType == 6 | ReturnType == 7)
                NCID = 12000;
            if (ReturnType == 8)
                NCID = 11300;
            if (ReturnType == 9)
                NCID = 11500;
            string SetString = null;

            string DataToEncode = null;
            CorrectFNC = 0;
            PrintableString = "";
            DataToEncode = "";
            SetString = "";
            //ProcessTilde was modified to support ReturnTypes 6-9 and
            //support using ( and ) to define AIs for GS1-128
            if (ApplyTilde)
                DataToFormat = ProcessTilde(DataToFormat);

            if (ReturnType == 0 | ReturnType == 2 | ReturnType > 5)
            {
                //Select the character set A, B or C for the START character
                //The next 15 lines were modified to support ReturnTypes 6-9
                //by the addition of the FID. The SetAry records the character set
                //so that the correct character can be displayed for HR text.
                string[] SetAry = new string[] {"0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
                "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
                "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
                "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
                "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
                "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
                "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
                "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
                "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
                "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
                "0", "0", "0", "0", "0", "0"};
                CurrentChar = left(DataToFormat, 1);
                CurrentCharNum = AscW(CurrentChar);
                StringLength = Strings.Len(DataToFormat);
                C128Start = Strings.ChrW(204 + FID);
                if (CurrentCharNum < 32)
                    C128Start = Strings.ChrW(203 + FID);
                if (CurrentCharNum > 31 & CurrentCharNum < 127)
                    C128Start = Strings.ChrW(204 + FID);
                if (((StringLength > 3) & Information.IsNumeric(Strings.Mid(DataToFormat, 1, 4))))
                    C128Start = Strings.ChrW(205 + FID);
                //202 & 212-215 is for the FNC1, with this Start C is mandatory
                if (CurrentCharNum == 197)
                    C128Start = Strings.ChrW(204 + FID);
                if (CurrentCharNum > 201)
                    C128Start = Strings.ChrW(205 + FID);
                if (C128Start == Strings.ChrW(203 + FID))
                    CurrentEncoding = "A";
                if (C128Start == Strings.ChrW(204 + FID))
                    CurrentEncoding = "B";
                if (C128Start == Strings.ChrW(205 + FID))
                    CurrentEncoding = "C";
                //The next line was added to support ReturnTypes 6-9
                J = 0;
                for (I = 1; I <= StringLength; I++)
                {
                    //The next line was added to support ReturnTypes 6-9
                    J = J + 1;
                    //Check for FNC1 in any set which is ASCII 202 and ASCII 212-217
                    CurrentCharNum = Strings.AscW(Strings.Mid(DataToFormat, I, 1));

                    if (CurrentCharNum > 201)
                    {
                        //The next 5 lines were added to support ReturnTypes 6-9
                        //Switch to set C if not already in it BEFORE the AI
                        //Change SetAry(J) to B so the number 99 does not show up for the set switch
                        if (CurrentEncoding != "C")
                        {
                            SetAry(J) = "B";
                            DataToEncode = DataToEncode + Strings.ChrW(199);
                            J = J + 1;
                            CurrentEncoding = "C";
                        }
                        DataToEncode = DataToEncode + Strings.ChrW(202);
                        //The next 14 lines were added to support ReturnTypes 6-9
                        //Change SetAry(J) to B so the number 99 does not show up for the AI
                        SetAry(J) = "B";
                        if (CurrentCharNum > 211)
                        {
                            //Change SetAry to reflect the location of proper HR text
                            //E indicates the ) is at the end of a number pair instead of the Middle
                            if (CurrentCharNum == 212)
                                SetAry(J + 1) = "E";
                            if (CurrentCharNum == 213)
                                SetAry(J + 2) = "M";
                            if (CurrentCharNum == 214)
                                SetAry(J + 2) = "E";
                            if (CurrentCharNum == 215)
                                SetAry(J + 3) = "M";
                            if (CurrentCharNum == 216)
                                SetAry(J + 3) = "E";
                            if (CurrentCharNum == 217)
                                SetAry(J + 4) = "M";
                        }
                        //Check for switching
                    }
                    else if (CurrentCharNum == 195)
                    {
                        if (CurrentEncoding == "C")
                        {
                            DataToEncode = DataToEncode + Strings.ChrW(200);
                            //The next line was added to support ReturnTypes 6-9
                            if (SetAry(J) == "0")
                                SetAry(J) = "B";
                            CurrentEncoding = "B";
                        }
                        DataToEncode = DataToEncode + Strings.ChrW(195);
                        //The next line was added to support ReturnTypes 6-9
                        if (SetAry(J) == "0")
                            SetAry(J) = "B";
                    }
                    else if (CurrentCharNum == 196)
                    {
                        if (CurrentEncoding == "C")
                        {
                            DataToEncode = DataToEncode + Strings.ChrW(200);
                            //The next line was added to support ReturnTypes 6-9
                            if (SetAry(J) == "0")
                                SetAry(J) = "B";
                            CurrentEncoding = "B";
                        }
                        DataToEncode = DataToEncode + Strings.ChrW(196);
                        //The next line was added to support ReturnTypes 6-9
                        if (SetAry(J) == "0")
                            SetAry(J) = "B";
                    }
                    else if (CurrentCharNum == 197)
                    {
                        if (CurrentEncoding == "C")
                        {
                            DataToEncode = DataToEncode + Strings.ChrW(200);
                            //The next line was added to support ReturnTypes 6-9
                            if (SetAry(J) == "0")
                                SetAry(J) = "B";
                            CurrentEncoding = "B";
                        }
                        DataToEncode = DataToEncode + Strings.ChrW(197);
                        //The next line was added to support ReturnTypes 6-9
                        if (SetAry(J) == "0")
                            SetAry(J) = "B";
                    }
                    else if (CurrentCharNum == 198)
                    {
                        if (CurrentEncoding == "C")
                        {
                            DataToEncode = DataToEncode + Strings.ChrW(200);
                            //The next line was added to support ReturnTypes 6-9
                            if (SetAry(J) == "0")
                                SetAry(J) = "B";
                            CurrentEncoding = "B";
                        }
                        DataToEncode = DataToEncode + Strings.ChrW(198);
                        //The next line was added to support ReturnTypes 6-9
                        if (SetAry(J) == "0")
                            SetAry(J) = "B";
                    }
                    else if (CurrentCharNum == 200)
                    {
                        if (CurrentEncoding == "C")
                        {
                            DataToEncode = DataToEncode + Strings.ChrW(200);
                            //The next line was added to support ReturnTypes 6-9
                            if (SetAry(J) == "0")
                                SetAry(J) = "B";
                            CurrentEncoding = "B";
                        }
                        DataToEncode = DataToEncode + Strings.ChrW(200);
                        //The next line was added to support ReturnTypes 6-9
                        if (SetAry(J) == "0")
                            SetAry(J) = "B";
                    }
                    else if (((I < StringLength - 2) & (Information.IsNumeric(Strings.Mid(DataToFormat, I, 1))) & (Information.IsNumeric(Strings.Mid(DataToFormat, I + 1, 1))) & (Information.IsNumeric(Strings.Mid(DataToFormat, I, 4)))) | ((I < StringLength) & (Information.IsNumeric(Strings.Mid(DataToFormat, I, 1))) & (Information.IsNumeric(Strings.Mid(DataToFormat, I + 1, 1))) & (CurrentEncoding == "C")))
                    {
                        //check to see if there is an odd number of digits to encode,
                        //if so stay in current set for 1 number and then switch to save space
                        //This IF statement was modified to support ReturnTypes 6-9; changed counter variable name from J to F
                        if (CurrentEncoding != "C")
                        {
                            F = I;
                            Factor = 3;
                            while (F <= StringLength & Information.IsNumeric(Strings.Mid(DataToFormat, F, 1)))
                            {
                                Factor = 4 - Factor;
                                F = F + 1;
                            }
                            if (Factor == 1)
                            {
                                //if so stay in current set for 1 character to save space
                                DataToEncode = DataToEncode + Strings.ChrW(CurrentCharNum);
                                //The next line was added to support ReturnTypes 6-9
                                if (SetAry(J) == "0")
                                    SetAry(J) = CurrentEncoding;
                                I = I + 1;
                                J = J + 1;
                            }
                        }
                        //Switch to set C if not already in it
                        if (CurrentEncoding != "C")
                            DataToEncode = DataToEncode + Strings.ChrW(199);
                        //The next 2 lines of code were added to support ReturnTypes 6-9
                        //Sets the encoding in SetAry to the previous mode to keep switch characters from showing up in HR text.
                        if (CurrentEncoding != "C")
                            SetAry(J) = CurrentEncoding;
                        if (CurrentEncoding != "C")
                            J = J + 1;
                        CurrentEncoding = "C";
                        CurrentChar = (Strings.Mid(DataToFormat, I, 2));
                        CurrentValue = Conversion.Val(CurrentChar);
                        //Set the CurrentValue to the number of String CurrentChar
                        if ((CurrentValue < 95 & CurrentValue > 0))
                            DataToEncode = DataToEncode + Strings.ChrW(CurrentValue + 32);
                        if (CurrentValue > 94)
                            DataToEncode = DataToEncode + Strings.ChrW(CurrentValue + 100);
                        if (CurrentValue == 0)
                            DataToEncode = DataToEncode + Strings.ChrW(194);
                        //The next line was added to support ReturnTypes 6-9
                        if (SetAry(J) == "0")
                            SetAry(J) = CurrentEncoding;
                        I = I + 1;
                        //Check for switching to character set A
                    }
                    else if ((I <= StringLength) & ((Strings.AscW(Strings.Mid(DataToFormat, I, 1)) < 31) | ((CurrentEncoding == "A") & (Strings.AscW(Strings.Mid(DataToFormat, I, 1)) > 32 & (Strings.AscW(Strings.Mid(DataToFormat, I, 1))) < 96))))
                    {
                        //Switch to set A if not already in it
                        if (CurrentEncoding != "A")
                            DataToEncode = DataToEncode + Strings.ChrW(201);
                        //The next 2 lines were added to support ReturnTypes 6-9
                        if (CurrentEncoding != "A")
                            SetAry(J) = "A";
                        if (CurrentEncoding != "A")
                            J = J + 1;
                        CurrentEncoding = "A";
                        //Get the ASCII value of the next character
                        CurrentCharNum = Strings.AscW(Strings.Mid(DataToFormat, I, 1));
                        if (CurrentCharNum == 32)
                        {
                            DataToEncode = DataToEncode + Strings.ChrW(194);
                        }
                        else if (CurrentCharNum < 32)
                        {
                            DataToEncode = DataToEncode + Strings.ChrW(CurrentCharNum + 96);
                        }
                        else if (CurrentCharNum > 32)
                        {
                            DataToEncode = DataToEncode + Strings.ChrW(CurrentCharNum);
                        }
                        //The next line was added to support ReturnTypes 6-9
                        if (SetAry(J) == "0")
                            SetAry(J) = CurrentEncoding;
                        //Check for switching to character set B
                    }
                    else if ((I <= StringLength) & ((Strings.AscW(Strings.Mid(DataToFormat, I, 1))) > 31 & (Strings.AscW(Strings.Mid(DataToFormat, I, 1)))) < 127)
                    {
                        //Switch to set B if not already in it
                        if (CurrentEncoding != "B")
                            DataToEncode = DataToEncode + Strings.ChrW(200);
                        //The next 2 lines were added to support ReturnTypes 6-9
                        if (CurrentEncoding != "B")
                            SetAry(J) = "B";
                        if (CurrentEncoding != "B")
                            J = J + 1;
                        //J = J + 1
                        CurrentEncoding = "B";
                        //Get the ASCII value of the next character
                        CurrentCharNum = Strings.AscW(Strings.Mid(DataToFormat, I, 1));
                        if (CurrentCharNum == 32)
                        {
                            DataToEncode = DataToEncode + Strings.ChrW(194);
                        }
                        else
                        {
                            DataToEncode = DataToEncode + Strings.ChrW(CurrentCharNum);
                        }
                        //The next line was added to support ReturnTypes 6-9
                        if (SetAry(J) == "0")
                            SetAry(J) = CurrentEncoding;
                    }
                }
            }

            //FORMAT TEXT FOR AIs
            if (ReturnType == 1)
            {
                //ReturnType 1 = format the data for human readable text only
                HumanReadableText = "";
                StringLength = Strings.Len(DataToFormat);
                for (I = 1; I <= StringLength; I++)
                {
                    CorrectFNC = 0;
                    //Get ASCII value of each character
                    CurrentCharNum = Strings.AscW(Strings.Mid(DataToFormat, I, 1));
                    //Check for FNC1
                    if (((I < StringLength - 2) & ((CurrentCharNum == 202) | ((CurrentCharNum > 211) & (CurrentCharNum < 219)))))
                    {
                        //2005.12 BDA updated the next if/else to eliminate errors from text after the AI
                        //It appears that there is an AI
                        //Get the value of the next 2 digits to try to determine the length of the AI, if text is used here
                        //Set this value to 81 for a 4 digit AI
                        if (Information.IsNumeric(Strings.Mid(DataToFormat, I + 1, 1)) & Information.IsNumeric(Strings.Mid(DataToFormat, I + 2, 1)))
                        {
                            CurrentChar = Strings.Mid(DataToFormat, I + 1, 2);
                            CurrentCharNum = Conversion.Val(CurrentChar);
                        }
                        else
                        {
                            CurrentCharNum = 81;
                        }
                        //Is 2 digit AI by entering ASCII 212?
                        if (((CorrectFNC == 0) & (Strings.AscW(Strings.Mid(DataToFormat, I, 1)) == 212)))
                        {
                            HumanReadableText = HumanReadableText + " (" + (Strings.Mid(DataToFormat, I + 1, 2)) + ") ";
                            I = I + 2;
                            CorrectFNC = 1;
                            //Is 3 digit AI by entering ASCII 213?
                        }
                        else if (((I < StringLength - 3) & (CorrectFNC == 0) & (Strings.AscW(Strings.Mid(DataToFormat, I, 1)) == 213)))
                        {
                            HumanReadableText = HumanReadableText + " (" + (Strings.Mid(DataToFormat, I + 1, 3)) + ") ";
                            I = I + 3;
                            CorrectFNC = 1;
                            //Is 4 digit AI by entering ASCII 214?
                        }
                        else if (((I < StringLength - 4) & (CorrectFNC == 0) & (Strings.AscW(Strings.Mid(DataToFormat, I, 1)) == 214)))
                        {
                            HumanReadableText = HumanReadableText + " (" + (Strings.Mid(DataToFormat, I + 1, 4)) + ") ";
                            I = I + 4;
                            CorrectFNC = 1;
                            //Is 5 digit AI by entering ASCII 215?
                        }
                        else if (((I < StringLength - 5) & (CorrectFNC == 0) & (Strings.AscW(Strings.Mid(DataToFormat, I, 1)) == 215)))
                        {
                            HumanReadableText = HumanReadableText + " (" + (Strings.Mid(DataToFormat, I + 1, 5)) + ") ";
                            I = I + 5;
                            CorrectFNC = 1;
                            //Is 6 digit AI by entering ASCII 216?
                        }
                        else if (((I < StringLength - 6) & (CorrectFNC == 0) & (Strings.AscW(Strings.Mid(DataToFormat, I, 1)) == 216)))
                        {
                            HumanReadableText = HumanReadableText + " (" + (Strings.Mid(DataToFormat, I + 1, 6)) + ") ";
                            I = I + 6;
                            CorrectFNC = 1;
                            //Is 7 digit AI by entering ASCII 217?
                        }
                        else if (((I < StringLength - 7) & (CorrectFNC == 0) & (Strings.AscW(Strings.Mid(DataToFormat, I, 1)) == 217)))
                        {
                            HumanReadableText = HumanReadableText + " (" + (Strings.Mid(DataToFormat, I + 1, 7)) + ") ";
                            I = I + 7;
                            CorrectFNC = 1;
                            //Is 8 digit AI by entering ASCII 218?
                        }
                        else if (((I < StringLength - 8) & (CorrectFNC == 0) & (Strings.AscW(Strings.Mid(DataToFormat, I, 1)) == 218)))
                        {
                            HumanReadableText = HumanReadableText + " (" + (Strings.Mid(DataToFormat, I + 1, 8)) + ") ";
                            I = I + 8;
                            CorrectFNC = 1;
                            //Is 4 digit AI by detection?
                        }
                        else if (((I < StringLength - 4) & (CorrectFNC == 0) & ((CurrentCharNum <= 81 & CurrentCharNum >= 80) | (CurrentCharNum <= 34 & CurrentCharNum >= 31))))
                        {
                            HumanReadableText = HumanReadableText + " (" + (Strings.Mid(DataToFormat, I + 1, 4)) + ") ";
                            I = I + 4;
                            CorrectFNC = 1;
                            //Is 3 digit AI by detection?
                        }
                        else if (((I < StringLength - 3) & (CorrectFNC == 0) & ((CurrentCharNum <= 49 & CurrentCharNum >= 40) | (CurrentCharNum <= 25 & CurrentCharNum >= 23))))
                        {
                            HumanReadableText = HumanReadableText + " (" + (Strings.Mid(DataToFormat, I + 1, 3)) + ") ";
                            I = I + 3;
                            CorrectFNC = 1;
                            //Is 2 digit AI by detection?
                        }
                        else if (((CurrentCharNum <= 30 & (CorrectFNC == 0) & CurrentCharNum >= 0) | (CurrentCharNum <= 99 & CurrentCharNum >= 90)))
                        {
                            HumanReadableText = HumanReadableText + " (" + (Strings.Mid(DataToFormat, I + 1, 2)) + ") ";
                            I = I + 2;
                            CorrectFNC = 1;
                            //If no AI was detected, set default to 4 digit AI:
                        }
                        else if (((I < StringLength - 4) & (CorrectFNC == 0)))
                        {
                            HumanReadableText = HumanReadableText + " (" + (Strings.Mid(DataToFormat, I + 1, 4)) + ") ";
                            I = I + 4;
                            CorrectFNC = 1;
                        }
                    }
                    else if ((Strings.AscW(Strings.Mid(DataToFormat, I, 1)) < 32))
                    {
                        HumanReadableText = HumanReadableText + " ";
                    }
                    else if (((Strings.AscW(Strings.Mid(DataToFormat, I, 1)) > 31) & (Strings.AscW(Strings.Mid(DataToFormat, I, 1)) < 128)))
                    {
                        HumanReadableText = HumanReadableText + Strings.Mid(DataToFormat, I, 1);
                    }
                }
            }

            //The next line was modified to support ReturnTypes 3-5
            if (ReturnType > 2 & ReturnType < 6)
            {
                //ReturnType 3, 4 or 5 = format the data for human readable text only
                //inserting a space for every 3, 4 or 5 characters
                HumanReadableText = "";
                StringLength = Strings.Len(DataToFormat);
                J = 0;
                for (I = 1; I <= StringLength; I++)
                {
                    CurrentCharNum = Strings.AscW(Strings.Mid(DataToFormat, I, 1));
                    if (CurrentCharNum > 31 & CurrentCharNum < 128)
                    {
                        HumanReadableText = HumanReadableText + Strings.Mid(DataToFormat, I, 1);
                        J = J + 1;
                    }
                    if ((J % ReturnType) == 0)
                        HumanReadableText = HumanReadableText + " ";
                }
            }

            if (ReturnType == 0 | ReturnType == 2 | ReturnType > 5)
            {
                DataToFormat = "";
                //The next line was modified to support ReturnTypes 6-9
                WeightedTotal = Strings.AscW(C128Start) - (FID + 100);
                StringLength = Strings.Len(DataToEncode);
                for (I = 1; I <= StringLength; I++)
                {
                    CurrentCharNum = Strings.AscW(Strings.Mid(DataToEncode, I, 1));
                    if (CurrentCharNum < 135)
                        CurrentValue = CurrentCharNum - 32;
                    if (CurrentCharNum > 134)
                        CurrentValue = CurrentCharNum - 100;
                    if (CurrentCharNum == 194)
                        CurrentValue = 0;
                    CurrentValue = CurrentValue * I;
                    WeightedTotal = WeightedTotal + CurrentValue;
                    if (CurrentCharNum == 32)
                        CurrentCharNum = 194;
                    //The next 10 lines were modified/added to support ReturnTypes 6-9
                    //so that set C characters show the correct HR number pairs
                    if (ReturnType > 5 & SetAry(I) == "C")
                    {
                        PrintableString = PrintableString + Strings.ChrW(CurrentCharNum + NCID);
                    }
                    else if ((ReturnType == 6 | ReturnType == 7) & SetAry(I) == "E")
                    {
                        PrintableString = PrintableString + Strings.ChrW(CurrentCharNum + 10500);
                    }
                    else if ((ReturnType == 6 | ReturnType == 7) & SetAry(I) == "M")
                    {
                        PrintableString = PrintableString + Strings.ChrW(CurrentCharNum + 10700);
                    }
                    else
                    {
                        PrintableString = PrintableString + Strings.ChrW(CurrentCharNum + CID);
                    }
                }
                CheckDigitValue = (WeightedTotal % 103);
                if (CheckDigitValue < 95 & CheckDigitValue > 0)
                    C128CheckDigit = Strings.ChrW(CheckDigitValue + 32 + FID);
                if (CheckDigitValue > 94)
                    C128CheckDigit = Strings.ChrW(CheckDigitValue + 100 + FID);
                if (CheckDigitValue == 0)
                    C128CheckDigit = Strings.ChrW(194 + FID);
            }

            DataToEncode = "";
            //ReturnType 0 returns data formatted to the barcode font
            if (ReturnType == 0 | ReturnType > 2)
                functionReturnValue = C128Start + PrintableString + C128CheckDigit + Strings.ChrW(206 + FID);
            //ReturnType 1 returns data formatted for human readable text
            if (ReturnType == 1)
                functionReturnValue = HumanReadableText;
            //ReturnType 2 returns the check digit for the data supplied
            if (ReturnType == 2)
                functionReturnValue = C128CheckDigit;
            return functionReturnValue;
        }

        private string left(string inString, int inInt)
        {
            if (inInt > inString.Length)
                inInt = inString.Length;
            return inString.Substring(0, inInt);
        }

        public string ProcessTilde(string StringToProcess)
        {
            string functionReturnValue = null;
            functionReturnValue = "";
            string OutString = null;
            int CharsAdded = 0;
            StringLength = Strings.Len(StringToProcess);
            for (I = 1; I <= StringLength; I++)
            {
                if ((I < StringLength - 2) & Strings.Mid(StringToProcess, I, 2) == "~m" & Information.IsNumeric(Strings.Mid(StringToProcess, I + 2, 2)))
                {
                    string StringToCheck = null;
                    WeightValue = Conversion.Val(Strings.Mid(StringToProcess, I + 2, 2));
                    //Dim CharsAdded As Integer
                    for (J = I; J >= 1; J += -1)
                    {
                        if (Information.IsNumeric(Strings.Mid(OutString, J, 1)))
                        {
                            StringToCheck = StringToCheck + Strings.Mid(OutString, J, 1);
                            CharsAdded = CharsAdded + 1;
                        }
                        //when the number of digits added to StringToCheck equals the weight value exit the for loop
                        if (CharsAdded == WeightValue)
                        {
                            break; // TODO: might not be correct. Was : Exit For
                        }
                    }
                    CheckDigitValue = MOD10(Strings.StrReverse(StringToCheck));
                    OutString = OutString + Strings.ChrW(CheckDigitValue + 48);
                    I = I + 3;
                }
                else if ((I < StringLength - 2) & Strings.Mid(StringToProcess, I, 1) == "~" & Information.IsNumeric(Strings.Mid(StringToProcess, I + 1, 3)))
                {
                    CurrentCharNum = Conversion.Val(Strings.Mid(StringToProcess, I + 1, 3));
                    OutString = OutString + Strings.ChrW(CurrentCharNum);
                    I = I + 3;
                    //This ElseIf was modified to support using () to add in AIs
                }
                else if ((I < StringLength - 4) & Strings.Mid(StringToProcess, I, 1) == "(" & (Strings.Mid(StringToProcess, I + 2, 1) == ")" | Strings.Mid(StringToProcess, I + 3, 1) == ")" | Strings.Mid(StringToProcess, I + 4, 1) == ")" | (Strings.Mid(StringToProcess, I + 5, 1) == ")" & (I < StringLength - 5)) | (Strings.Mid(StringToProcess, I + 6, 1) == ")" & (I < StringLength - 6)) | (Strings.Mid(StringToProcess, I + 7, 1) == ")" & (I < StringLength - 4)) | (Strings.Mid(StringToProcess, I + 8, 1) == ")" & (I < StringLength - 4))))
                {
                    //Assign ASCII 212-217 depending on how many digits between ()
                    if (Strings.Mid(StringToProcess, I + 3, 1) == ")")
                        OutString = OutString + Strings.ChrW(212);
                    if (Strings.Mid(StringToProcess, I + 4, 1) == ")")
                        OutString = OutString + Strings.ChrW(213);
                    if (Strings.Mid(StringToProcess, I + 5, 1) == ")")
                        OutString = OutString + Strings.ChrW(214);
                    if (Strings.Mid(StringToProcess, I + 6, 1) == ")")
                        OutString = OutString + Strings.ChrW(215);
                    if (Strings.Mid(StringToProcess, I + 7, 1) == ")")
                        OutString = OutString + Strings.ChrW(216);
                    if (Strings.Mid(StringToProcess, I + 8, 1) == ")")
                        OutString = OutString + Strings.ChrW(217);
                    //This ElseIf was modified to exclude ")" from being encoded
                    //ElseIf (I < StringLength - 2) And Mid(StringToProcess, I, 1) = ")" Then
                    //6/2/2010, TB, Fix bug #392, removed - 2 from the if statement
                }
                else if ((I < StringLength) & Strings.Mid(StringToProcess, I, 1) == ")")
                {
                    //Skip this character by breaking out of the else if
                }
                else
                {
                    OutString = OutString + Strings.Mid(StringToProcess, I, 1);
                }
            }
            functionReturnValue = OutString;
            StringToProcess = "";
            return functionReturnValue;
        }
    }
}