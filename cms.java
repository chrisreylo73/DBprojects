package DBprojects;

//import java.sql.Connection;
//import java.sql.DriverManager;
import java.sql.*;
import java.util.*;
import java.io.*;

public class cms {
    ArrayList<String[]> providers = new ArrayList<>();
    ArrayList<String[]> drgs = new ArrayList<>();
    ArrayList<String[]> finances = new ArrayList<>();
    ArrayList<String[]> providerStates = new ArrayList<>();
    ArrayList<String[]> ruca = new ArrayList<>();
    String providersStmt;
    String drgsStmt;
    String financesStmt;
    String providerStatesStmt;
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
            // stmt.executeUpdate(drgsStmt);

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
            String[] drgsInfo;
            String[] financesInfo;
            String[] providerStatesInfo;
            String[] rucaInfo;
            String[] splitRucaDesc = new String[2];
            // Need to split up further later on!!!

            while ((line = br.readLine()) != null) {
                data = line.split(",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)", -1);

                providersInfo = new String[4];
                providersInfo[0] = data[0];
                providersInfo[1] = data[1];
                providersInfo[2] = data[2];
                providersInfo[3] = data[3];
                providers.add(providersInfo);

                drgsInfo = new String[2];
                drgsInfo[0] = data[9];
                drgsInfo[1] = String.valueOf(data[10]).replace("\"", "");
                drgs.add(drgsInfo);

                financesInfo = new String[6];
                financesInfo[0] = data[0];
                financesInfo[1] = data[9];
                financesInfo[2] = data[11];
                financesInfo[3] = data[12];
                financesInfo[4] = data[13];
                financesInfo[5] = data[14];
                finances.add(financesInfo);

                providerStatesInfo = new String[3];
                providerStatesInfo[0] = data[4];
                providerStatesInfo[1] = data[5];
                providerStatesInfo[2] = data[0];
                providerStates.add(providerStatesInfo);

                rucaInfo = new String[3];
                rucaInfo[0] = data[7];
                rucaInfo[1] = String.valueOf(data[8]).replace("\"", "");
                rucaInfo[2] = data[6];
                ruca.add(rucaInfo);
            }
            // System.out.println(providers.get(0)[0]);
            System.out.println(Arrays.toString(providers.get(0)));
            System.out.println(Arrays.toString(providers.get(1)));
            // System.out.println(drgs.get(0)[0]);
            System.out.println(Arrays.toString(drgs.get(0)));
            System.out.println(Arrays.toString(drgs.get(1)));
            System.out.println(Arrays.toString(finances.get(0)));
            System.out.println(Arrays.toString(finances.get(1)));

            System.out.println(Arrays.toString(providerStates.get(0)));
            System.out.println(Arrays.toString(providerStates.get(1)));

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
            stmt = conn.prepareStatement("INSERT INTO Drgs VALUES(?,?);");
            for (int i = 1; i < drgs.size(); i++) {

                stmt.setString(1, drgs.get(i)[0]);
                stmt.setString(2, drgs.get(i)[1]);

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