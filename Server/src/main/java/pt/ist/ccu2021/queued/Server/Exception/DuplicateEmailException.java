package pt.ist.ccu2021.queued.Server.Exception;

public class DuplicateEmailException extends Exception{

    public DuplicateEmailException(String email) {
        super("Duplicate email in Database - Email:" + email);
    }
}
