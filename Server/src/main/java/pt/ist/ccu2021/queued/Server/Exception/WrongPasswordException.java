package pt.ist.ccu2021.queued.Server.Exception;

public class WrongPasswordException extends Exception{

    public WrongPasswordException(String email, String password) {
        super("Wrong password - Email:" + email + ", Password" + password);
    }
}
