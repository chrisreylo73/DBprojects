import java.sql.Connection;
import java.sql.DriverManager;

public class cms {

    public static void main(String[] args) throws Exception {
        String server = "localhost";
        String database = "hr";
        String user = "hr_admin";

        // you should NEVER hard-code passwords like shown in this example in a production environment!!!
        String password = "135791";
        String connectURL = "jdbc:postgresql://" + server + "/" + database + "?user=" + user + "&password=" + password;

        // connects to the database
        Connection conn = DriverManager.getConnection(connectURL);
        System.out.println("Connection to Postgres database " + database + " was successful!");

        // closes the connection
        System.out.println("Bye!");
        conn.close();
    }
}