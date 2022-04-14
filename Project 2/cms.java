/*
Authors: Christian Lopez, Juan Ruiz
date:03/27/2022
Description:
This program takes in a csv file, splits the information to eventually serve it to a postgressql database named cms.
The progam asks user for username, password, and path to CSV file.

USER "cms_admin" PASSWORD '024680';
USER "cms" PASSWORD '135791';
*/
package DBprojects;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.*;
import java.util.*;
import java.io.*;

public class cms {
    // Stores split CSV file contents into respective sql tables attributes
    ArrayList<String[]> providers = new ArrayList<>();
    ArrayList<String[]> drgs = new ArrayList<>();
    ArrayList<String[]> finances = new ArrayList<>();
    ArrayList<String[]> providerStates = new ArrayList<>();
    ArrayList<String[]> ruca = new ArrayList<>();

    private void establishConnection(Scanner keyboard) {

        // Asks user for login information
        System.out.println("Welcome to cms file loader");
        String server = "localhost";
        String database = "cms";
        System.out.println("Enter in database username: ");
        String user = keyboard.nextLine();
        System.out.println("Enter in password: ");
        String password = keyboard.nextLine();
        // Connects to server
        try {
            String connectURL = "jdbc:postgresql://" + server + "/" + database + "?user=" + user + "&password="
                    + password;
            Connection conn = DriverManager.getConnection(connectURL);
            System.out.println("Connection to Postgres database " + database + " was successful!");
            this.readFile(keyboard);
            this.importValues(keyboard, conn);
            System.out.println("Connection Ending : Bye!");
            conn.close();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }

    private void readFile(Scanner keyboard) {

        // Reads in file contents and splits them into seperate Arraylists to later be
        // inserted
        try {
            // Asks User for path
            System.out.println("Enter in a path to file : ");
            String path = keyboard.nextLine();
            path = path.replace("\\", "\\\\");
            File file = new File(path);
            // Reads in file
            BufferedReader br = new BufferedReader(new FileReader(file));
            String line;
            String[] data = new String[20];
            String[] providersInfo;
            String[] drgsInfo;
            String[] financesInfo;
            String[] providerStatesInfo;
            String[] rucaInfo;

            while ((line = br.readLine()) != null) {
                // splits each line of file into feilds by commas while ignoring commas incased
                // in ""
                data = line.split(",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)", -1);
                // Selects data that is associated with Providers table
                providersInfo = new String[4];
                providersInfo[0] = data[0];
                providersInfo[1] = data[1];
                providersInfo[2] = data[2];
                providersInfo[3] = data[3];
                providers.add(providersInfo);
                // Selects data that is associated with Drgs table
                drgsInfo = new String[2];
                drgsInfo[0] = data[9];
                drgsInfo[1] = String.valueOf(data[10]).replace("\"", "");
                drgs.add(drgsInfo);
                // Selects data that is associated with Finances table
                financesInfo = new String[6];
                financesInfo[0] = data[0];
                financesInfo[1] = data[9];
                financesInfo[2] = data[11];
                financesInfo[3] = data[12];
                financesInfo[4] = data[13];
                financesInfo[5] = data[14];
                finances.add(financesInfo);
                // Selects data that is associated with ProviderStates table
                providerStatesInfo = new String[3];
                providerStatesInfo[0] = data[4];
                providerStatesInfo[1] = data[5];
                providerStatesInfo[2] = data[0];
                providerStates.add(providerStatesInfo);
                // Selects data that is associated with Ruca table
                rucaInfo = new String[4];
                rucaInfo[0] = data[7];
                rucaInfo[1] = String.valueOf(data[8]).replace("\"", "");
                rucaInfo[2] = data[6];
                rucaInfo[3] = data[0];
                ruca.add(rucaInfo);
            }
            br.close(); /// close file
        } catch (FileNotFoundException s) {
            System.out.println("File does Not Exist ");
        } catch (IOException e) {
            System.out.println(e.toString());
        }
    }

    //
    private void importValues(Scanner keyboard, Connection conn) {
        PreparedStatement stmt;
        // Arraylists to check if keys already exist as an insert
        ArrayList<String> providersKeys = new ArrayList<>();
        ArrayList<String> drgsKeys = new ArrayList<>();
        ArrayList<String> financesKeys = new ArrayList<>();
        ArrayList<String> providerStatesKeys = new ArrayList<>();
        ArrayList<String> rucaKeys = new ArrayList<>();
        try {
            // Send insert command for table Providers
            stmt = conn.prepareStatement("INSERT INTO Providers VALUES(?,?,?,?);");
            int i;
            for (i = 1; i < providers.size(); i++) {
                if (!(providersKeys.contains(providers.get(i)[0]))) {
                    providersKeys.add(providers.get(i)[0]);
                    stmt.setString(1, providers.get(i)[0]);
                    stmt.setString(2, providers.get(i)[1]);
                    stmt.setString(3, providers.get(i)[2]);
                    stmt.setString(4, providers.get(i)[3]);
                    stmt.executeUpdate();
                }
            }
            // Send insert command for table Drgs
            stmt = conn.prepareStatement("INSERT INTO Drgs VALUES(?,?);");
            for (i = 1; i < drgs.size(); i++) {
                if (!(drgsKeys.contains(drgs.get(i)[0]))) {
                    drgsKeys.add(drgs.get(i)[0]);
                    stmt.setString(1, drgs.get(i)[0]);
                    stmt.setString(2, drgs.get(i)[1]);
                    stmt.executeUpdate();
                }
            }
            // Send insert command for table Finances
            stmt = conn.prepareStatement("INSERT INTO Finances VALUES(?,?,?,?,?,?);");
            for (i = 1; i < finances.size(); i++) {
                // if (!(financesKeys.contains(finances.get(i)[0]) &&
                // /!(financesKeys.contains(finances.get(i)[1]))))

                if (!(financesKeys.contains(finances.get(i)[0] + finances.get(i)[1]))) {
                    financesKeys.add(finances.get(i)[0] + finances.get(i)[1]);
                    stmt.setString(1, finances.get(i)[0]);
                    stmt.setString(2, finances.get(i)[1]);
                    stmt.setInt(3, Integer.parseInt(finances.get(i)[2]));
                    stmt.setDouble(4, Double.parseDouble(finances.get(i)[3]));
                    stmt.setDouble(5, Double.parseDouble(finances.get(i)[4]));
                    stmt.setDouble(6, Double.parseDouble(finances.get(i)[5]));
                    stmt.executeUpdate();
                }
            }
            // Send insert command for table ProviderStates
            stmt = conn.prepareStatement("INSERT INTO ProviderStates VALUES(?,?,?);");
            for (i = 1; i < providerStates.size(); i++) {
                // if (!(providerStatesKeys.contains(providerStates.get(i)[0]))
                // && !(providerStatesKeys.contains(providerStates.get(i)[2])))
                if (!(providerStatesKeys.contains(providerStates.get(i)[0] + providerStates.get(i)[2]))) {
                    providerStatesKeys.add(providerStates.get(i)[0] + providerStates.get(i)[2]);
                    stmt.setString(1, providerStates.get(i)[0]);
                    stmt.setString(2, providerStates.get(i)[1]);
                    stmt.setString(3, providerStates.get(i)[2]);
                    stmt.executeUpdate();
                }
            }
            // Send insert command for table Ruca
            stmt = conn.prepareStatement("INSERT INTO Ruca VALUES(?,?,?,?);");
            for (i = 1; i < ruca.size(); i++) {
                if (!(rucaKeys.contains(ruca.get(i)[0] + ruca.get(i)[3]))) {
                    rucaKeys.add(ruca.get(i)[0] + ruca.get(i)[3]);
                    stmt.setString(1, ruca.get(i)[0]);
                    stmt.setString(2, ruca.get(i)[1]);
                    stmt.setString(3, ruca.get(i)[2]);
                    stmt.setString(4, ruca.get(i)[3]);
                    stmt.executeUpdate();
                }
            }
        } catch (

        SQLException e1) {
            e1.printStackTrace();
        }
    }

    public static void main(String[] args) throws Exception {
        Scanner keyboard = new Scanner(System.in);
        cms dataFilter = new cms();
        dataFilter.establishConnection(keyboard);
    }
}