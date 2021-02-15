﻿using System;

namespace TrustBarcode
{
    public class Barcode
    {
        /// <summary>
        /// Use Font IDAutomationC128.ttf
        /// </summary>
        /// <param name="value">Enter Plain Text (0~9,A~Z)</param>
        /// <returns>Barcode encryption text with checksome</returns>
        public string Convert_128A(string value)
        {
            value = value.ToUpper();
            char[] a = value.ToCharArray();
            long sum = 103;

            for (int i = 0; i < a.Length; i++)
            {
                sum += (i + 1) * ((int)a[i] - ((int)a[i] < 95 ? 32 : 100));
            }
            return ((char)203 + value + (char)((sum % 103) + ((sum % 103) < 95 ? 32 : 100)) + (char)206).Replace(" ", "Â");
        }

        /// <summary>
        /// Use Font IDAutomationC128.ttf
        /// </summary>
        /// <param name="value">Enter Plain Text (0~9,a~z,A~Z)</param>
        /// <returns>Barcode encryption text with checksome</returns>
        public string Convert_128B(string value)
        {          
            char[] a = value.ToCharArray();
            long sum = 104;

            for (int i = 0; i < a.Length; i++)
            {
                sum += (i + 1) * ((int)a[i] - ((int)a[i] < 95 ? 32 : 100));
            }

            return ((char)204 + value + (char)((sum % 103) + ((sum % 103) < 95 ? 32 : 100)) + (char)206).Replace(" ", "Â");          
        }

        /// <summary>
        /// Use Font IDAutomationC128.ttf
        /// </summary>
        /// <param name="value">Enter Plain Text (0~9)</param>
        /// <returns>Barcode encryption text with checksome</returns>
        public string Convert_128C(string value)
        {
            if (value.Length % 2 != 0) value = "0" + value;

            int ind = 1;
            int checksum = 0;
            int mini;
            int dummy;
            bool tableB;
            String code128;
            int longueur;

            code128 = "";
            longueur = value.Length;

            if (longueur == 0)
            {
                //Console.WriteLine("\n value vide");
            }
            else
            {
                for (ind = 0; ind < longueur; ind++)
                {
                    if ((value[ind] < 32) || (value[ind] > 126))
                    {
                        //Console.WriteLine("\n value invalide");
                    }
                }
            }

            tableB = true;
            ind = 0;

            while (ind < longueur)
            {
                if (tableB == true)
                {
                    if ((ind == 0) || (ind + 3 == longueur - 1))
                    {
                        mini = 4;
                    }
                    else
                    {
                        mini = 6;
                    }

                    mini = mini - 1;

                    if ((ind + mini) <= longueur - 1)
                    {
                        while (mini >= 0)
                        {
                            if ((value[ind + mini] < 48) || (value[ind + mini] > 57))
                            {
                                //Console.WriteLine("\n exit");
                                break;
                            }
                            mini = mini - 1;
                        }
                    }

                    if (mini < 0)
                    {
                        if (ind == 0)
                        {
                            code128 = Char.ToString((char)205);

                        }
                        else
                        {
                            code128 = code128 + Char.ToString((char)199);

                        }
                        tableB = false;
                    }
                    else
                    {

                        if (ind == 0)
                        {
                            code128 = Char.ToString((char)204);
                        }
                    }
                }

                if (tableB == false)
                {
                    mini = 2;
                    mini = mini - 1;
                    if (ind + mini < longueur)
                    {
                        while (mini >= 0)
                        {

                            if (((value[ind + mini]) < 48) || ((value[ind]) > 57))
                            {
                                break;
                            }
                            mini = mini - 1;
                        }
                    }
                    if (mini < 0)
                    {
                        dummy = Int32.Parse(value.Substring(ind, 2));

                        //Console.WriteLine("\n  dummy ici : " + dummy);

                        if (dummy < 95)
                        {
                            dummy = dummy + 32;
                        }
                        else
                        {
                            dummy = dummy + 100;
                        }
                        code128 = code128 + (char)(dummy);

                        ind = ind + 2;
                    }
                    else
                    {
                        code128 = code128 + Char.ToString((char)200);
                        tableB = true;
                    }
                }
                if (tableB == true)
                {

                    code128 = code128 + value[ind];
                    ind = ind + 1;
                }
            }

            for (ind = 0; ind <= code128.Length - 1; ind++)
            {
                dummy = code128[ind];
                //Console.WriteLine("\n  et voila dummy : " + dummy);
                if (dummy < 127)
                {
                    dummy = dummy - 32;
                }
                else
                {
                    dummy = dummy - 100;
                }
                if (ind == 0)
                {
                    checksum = dummy;
                }
                checksum = (checksum + (ind) * dummy) % 103;
            }

            if (checksum < 95)
            {
                checksum = checksum + 32;
            }
            else
            {
                checksum = checksum + 100;
            }
            code128 = code128 + Char.ToString((char)checksum) + Char.ToString((char)206);

            return code128.Replace(" ", "Â");
        }
    }
}
