package it.univaq.f3i.labbd;

/**
 *
 * @author Giuseppe Della Penna
 *
 * Questo esempio lavora sul database "campionati" e richiede che esso sia
 * popolato con i dati e le procedure sviluppate a lezione, nonchè che sia
 * presente nel DBMS un utente specifico (vedi qui sotto) con accesso al
 * database
 */
public class JDBC_Example_MySQL_Main extends JDBC_Example {

    //attenzione: a partire dal connector/J 8 il nome del driver è cambiato
    private static final String DRIVER_NAME = "com.mysql.cj.jdbc.Driver";
    private static final String DB_NAME = "campionati";
    //il parametro noAccessToProcedureBodies nella connection string è usato per invocare le procedure senza avere permessi avanzati
    //il parametro serverTimezone serve a specificare la timezone in cui ci troviamo (può essere omesso se questo parametro è configurato sul server)
    private static final String CONNECTION_STRING
            = "jdbc:mysql://localhost:3306/" + DB_NAME + "?noAccessToProcedureBodies=true" + "&serverTimezone=Europe/Rome";
    //l'utente deve avere i permessi INSERT, UPDATE, SELECT ed EXECUTE sul database
    private static final String DB_USER = "campionatiUser";
    private static final String DB_PASSWORD = "campionatiPwd";

    public JDBC_Example_MySQL_Main() {
        super(CONNECTION_STRING, DB_USER, DB_PASSWORD);
    }

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        JDBC_Example_MySQL_Main instance = new JDBC_Example_MySQL_Main();
        instance.run(false, true, true);
    }
}
