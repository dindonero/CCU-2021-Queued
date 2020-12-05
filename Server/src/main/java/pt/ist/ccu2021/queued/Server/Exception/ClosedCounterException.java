package pt.ist.ccu2021.queued.Server.Exception;

public class ClosedCounterException extends Exception{

    public ClosedCounterException(int id, String name) {
        super("Chosen counter is closed - Id:" + id + ", Name:" + name);
    }
}
