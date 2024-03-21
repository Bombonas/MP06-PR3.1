package cat.iesesteveterradas;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;

import org.basex.api.client.ClientSession;
import org.basex.core.*;
import org.basex.core.cmd.*;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class Main {
    private static final Logger logger = LoggerFactory.getLogger(Main.class);    

    public static void main(String[] args) throws IOException {
         // Initialize connection details
        String host = "127.0.0.1";
        int port = 1984;
        String username = "admin"; // Default username
        String password = "admin"; // Default password
        
        // Establish a connection to the BaseX server
        try (ClientSession session = new ClientSession(host, port, username, password)) {
            File IN = new File("./data/input");
            File OUT = new File("./data/output");
            session.execute(new Open("BBDD-PR3")); 
            File[] files = IN.listFiles();

            for (File file : files) {
                if (file.isFile() && file.getName().toLowerCase().endsWith(".xquery")) {
                    logger.info(file.getName());
                    String query = Files.readString(file.toPath());

                    String name = file.getName().substring(0, file.getName().lastIndexOf("."));

                    String result = session.execute(new XQuery(query));

                    String OUTfile = OUT.getAbsolutePath() + File.separator + name + ".xml";
                    try (FileWriter writer = new FileWriter(OUTfile)) {
                        writer.write(result);
                    } catch (IOException e) {
                        logger.error("Error writing output file: " + e.getMessage());
                    }
                }
            }

        } catch (BaseXException e) {
            logger.error("Error connecting or executing the query: " + e.getMessage());
        } catch (IOException e) {
            logger.error(e.getMessage());
        }        
    }
}
