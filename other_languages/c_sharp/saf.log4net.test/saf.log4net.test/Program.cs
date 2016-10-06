using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using log4net;
using log4net.Config;

namespace saf.log4net.test
{
    class Program
    {
        static ILog logger = LogManager.GetLogger(typeof(Program));

        static void Main(string[] args)
        {
            XmlConfigurator.Configure(new System.IO.FileInfo("log4net.xml"));
            //BasicConfigurator.Configure();

            logger.Fatal("This is an interesting message!");
            Console.Write("C'est fini, press enter to quit.");
            Console.ReadLine();
        }
    }
}
