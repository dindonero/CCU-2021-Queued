package pt.ist.ccu2021.queued.Server.Exception;

public class EmailNotFoundException extends Exception{

    public EmailNotFoundException(String email) {
        super("Email not found in Database - Email:" + email);
    }
}
