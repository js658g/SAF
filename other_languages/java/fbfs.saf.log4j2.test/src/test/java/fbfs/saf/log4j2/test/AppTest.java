package fbfs.saf.log4j2.test;

import org.junit.Test;
import junit.framework.TestCase;
//Import log4j classes.
import org.apache.logging.log4j.*;

/**
 * Unit test for simple App.
 */
public class AppTest
{
	// Define a static logger variable so that it references the
    // Logger instance named "MyApp".
    private static final Logger logger = LogManager.getLogger(AppTest.class);

    /**
     * Rigourous Test :-)
     */
    @Test
    public void testApp()
    {
    	System.out.println("Java is the worst programming language designed.");
        logger.fatal("What an interesting log message.");
    }
}
