
//import java.sql.Connection;
//import java.sql.DriverManager;
import java.sql.*;
import java.util.*;
import java.io.*;

public class cms {
    ArrayList<String[]> providers = new ArrayList<>();
    ArrayList<String[]> drg = new ArrayList<>();
    ArrayList<String[]> providersDrgs = new ArrayList<>();
    ArrayList<String[]> providerLocations = new ArrayList<>();
    ArrayList<String[]> ruca = new ArrayList<>();
    String providersStmt;
    String drgStmt;
    String providersDrgsStmt;
    String providerLocationsStmt;
    String rucaStmt;

    private void establishConnection(Scanner keyboard) {

        // connects to the database

        System.out.println("Welcome to cms file loader");
        String server = "localhost";
        String database = "cms";
        System.out.println("Enter in database username: ");
        String user = keyboard.nextLine();
        System.out.println("Enter in password: ");
        String password = keyboard.nextLine();
        // USER "cms_admin" PASSWORD '024680';
        // USER "cms" PASSWORD '135791';
        try {
            String connectURL = "jdbc:postgresql://" + server + "/" + database + "?user=" + user + "&password="
                    + password;
            Connection conn = DriverManager.getConnection(connectURL);
            System.out.println("Connection to Postgres database " + database + " was successful!");
            // Statement stmt = conn.createStatement();
            // ResultSet resultSet = stmt.executeQuery(providersStmt);

            this.readFile(keyboard);

            this.createStatments(keyboard, conn);

            // stmt.executeUpdate(providersStmt);
            // stmt.executeUpdate(drgStmt);

            // String sql = "SELECT id, name FROM employees";
            // ResultSet resultSet = stmt.executeQuery(sql);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        // System.out.println("Connection Ending : Bye!");
        // conn.close();

    }

    private void readFile(Scanner keyboard) {
        /* Asking user to enter in a path */

        try {
            System.out.println("Enter in a path to file : ");
            String path = keyboard.nextLine();
            path = path.replace("\\", "\\\\");

            File file = new File(path);
            BufferedReader br = new BufferedReader(new FileReader(file));
            String line;
            String[] data = new String[20];
            String[] providersInfo;
            String[] drgInfo;
            String[] providers_DrgsInfo;
            String[] providerLocationsInfo;
            String[] rucaInfo;
            String[] splitRucaDesc = new String[2];
            // Need to split up further later on!!!

            while ((line = br.readLine()) != null) {
                data = line.split(",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)", -1);

                providersInfo = new String[4];
                providersInfo[0] = data[0];
                providersInfo[1] = data[1];
                providersInfo[2] = data[2];
                providersInfo[3] = data[7];
                providers.add(providersInfo);

                drgInfo = new String[2];
                drgInfo[0] = data[9];
                drgInfo[1] = String.valueOf(data[10]).replace("\"", "");
                drg.add(drgInfo);

                providers_DrgsInfo = new String[6];
                providers_DrgsInfo[0] = data[0];
                providers_DrgsInfo[1] = data[9];
                providers_DrgsInfo[2] = data[11];
                providers_DrgsInfo[3] = data[12];
                providers_DrgsInfo[4] = data[13];
                providers_DrgsInfo[5] = data[14];
                providersDrgs.add(providers_DrgsInfo);

                providerLocationsInfo = new String[5];
                providerLocationsInfo[0] = data[2];
                providerLocationsInfo[1] = data[3];
                providerLocationsInfo[2] = data[4];
                providerLocationsInfo[3] = data[5];
                providerLocationsInfo[4] = data[6];
                providerLocations.add(providerLocationsInfo);

                rucaInfo = new String[2];
                rucaInfo[0] = data[7];
                rucaInfo[1] = String.valueOf(data[8]).replace("\"", "");
                ruca.add(rucaInfo);

            }
            // System.out.println(providers.get(0)[0]);
            System.out.println(Arrays.toString(providers.get(0)));
            System.out.println(Arrays.toString(providers.get(1)));
            // System.out.println(drg.get(0)[0]);
            System.out.println(Arrays.toString(drg.get(0)));
            System.out.println(Arrays.toString(drg.get(1)));
            System.out.println(Arrays.toString(providersDrgs.get(0)));
            System.out.println(Arrays.toString(providersDrgs.get(1)));

            System.out.println(Arrays.toString(providerLocations.get(0)));
            System.out.println(Arrays.toString(providerLocations.get(1)));

            System.out.println(Arrays.toString(ruca.get(0)));
            System.out.println(Arrays.toString(ruca.get(1)));

            // for (String k[] : providers) {
            // System.out.println(Arrays.toString(k));
            //
            br.close(); /// close file
        } catch (FileNotFoundException s) {
            System.out.println("File does Not Exist ");
        } catch (IOException e) {
            System.out.println(e.toString());
        }

    }

    private void createStatments(Scanner keyboard, Connection conn) {
        // providersStmt = "INSERT INTO Providers VALUES ";
        // for (int i = 1; i < providers.size(); i++) {
        // providersStmt += "\n('" + providers.get(i)[0] + "','" + providers.get(i)[1];
        // providersStmt += "','" + providers.get(i)[2] + "','" + providers.get(i)[3] +
        // "'";
        // if (i != providers.size() - 1) {
        // providersStmt += "),";
        // } else {
        // providersStmt += ");";
        // }
        // }

        // providersStmt = "\n INSERT INTO Providers VALUES ('" + providers.get(1)[0] +
        // "','"
        // + providers.get(1)[1] + "','" + providers.get(1)[2] + "','" +
        // providers.get(1)[3] + "');";

        PreparedStatement stmt;
        try {
            stmt = conn.prepareStatement("INSERT INTO Providers VALUES('?'','?','?','?');");
            for (int i = 1; i < providers.size(); i++) {
                stmt.setString(1, providers.get(i)[0]);
                stmt.setString(2, providers.get(i)[1]);
                stmt.setString(3, providers.get(i)[2]);
                stmt.setString(4, providers.get(i)[3]);
                stmt.executeUpdate();
            }
        } catch (SQLException e1) {
            e1.printStackTrace();
        }

    }

    public static void main(String[] args) throws Exception {
        Scanner keyboard = new Scanner(System.in);
        cms dataFilter = new cms();
        dataFilter.establishConnection(keyboard);
    }
}