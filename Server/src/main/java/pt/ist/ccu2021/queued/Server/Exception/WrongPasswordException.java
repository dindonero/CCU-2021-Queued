package pt.ist.ccu2021.queued.Server.Exception;

public class WrongPasswordException extends Exception{

    public WrongPasswordException(String email, String password) {
        super("Wrong password for user - Email:" + email + ", Password" + password);
    }
}
