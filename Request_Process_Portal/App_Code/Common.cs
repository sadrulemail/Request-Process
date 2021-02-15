using System;
using System.IO;
using System.IO.Compression;
using System.Text.RegularExpressions;


    public class Common
    {
        public static byte[] Compress(byte[] buffer)
        {
            MemoryStream ms = new MemoryStream();
            GZipStream zip = new GZipStream(ms, CompressionMode.Compress, true);
            zip.Write(buffer, 0, buffer.Length);
            zip.Close();
            ms.Position = 0;

            MemoryStream outStream = new MemoryStream();

            byte[] compressed = new byte[ms.Length];
            ms.Read(compressed, 0, compressed.Length);

            byte[] gzBuffer = new byte[compressed.Length + 4];
            Buffer.BlockCopy(compressed, 0, gzBuffer, 4, compressed.Length);
            Buffer.BlockCopy(BitConverter.GetBytes(buffer.Length), 0, gzBuffer, 0, 4);
            return gzBuffer;
        }

        public static byte[] Decompress(byte[] gzBuffer)
        {
            MemoryStream ms = new MemoryStream();
            int msgLength = BitConverter.ToInt32(gzBuffer, 0);
            ms.Write(gzBuffer, 4, gzBuffer.Length - 4);

            byte[] buffer = new byte[msgLength];

            ms.Position = 0;
            GZipStream zip = new GZipStream(ms, CompressionMode.Decompress);
            zip.Read(buffer, 0, buffer.Length);

            return buffer;
        }

        public static string FileSize(object val)
        {
            float SizeVal = (float.Parse(val.ToString()));
            string size = "Unknown Size";
            if (SizeVal > 0)
            {
                if (SizeVal >= 1073741824)
                    size = String.Format("{0:##.###}", (SizeVal / 1073741824)) + " GB";
                else if (SizeVal >= 1048576)
                    size = String.Format("{0:##.###}", (SizeVal / 1048576)) + " MB";
                else if (SizeVal >= 1024)
                    size = String.Format("{0:###}", (SizeVal / 1024)) + " KB";
                else
                    size = String.Format("{0:###}", (SizeVal)) + " Bytes";
            }
            return size;
        }

        public static bool isEmailAddress(string emailAddress)
        {
            //string patternLenient = @"\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*";
            //Regex reLenient = new Regex(patternLenient);

            string patternStrict = @"^(([^<>()[\]\\.,;:\s@\""]+"
                  + @"(\.[^<>()[\]\\.,;:\s@\""]+)*)|(\"".+\""))@"
                  + @"((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
                  + @"\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+"
                  + @"[a-zA-Z]{2,}))$";
            Regex reStrict = new Regex(patternStrict);

            //bool isLenientMatch = reLenient.IsMatch(emailAddress);
            //return isLenientMatch;

            bool isStrictMatch = reStrict.IsMatch(emailAddress);
            return isStrictMatch;
        }
    }
