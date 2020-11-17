package pt.ist.ccu2021.queued.Server.Exception;

public class UserEmailNotFoundException extends Exception{

    public UserEmailNotFoundException(String email) {
        super("Email not found in Database - Email:" + email);
    }
}
