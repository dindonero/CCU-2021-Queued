package pt.ist.ccu2021.queued.Server.Exception;

public class NoOneWaitingInLineException extends Exception{

    public NoOneWaitingInLineException(int id, String name) {
        super("No one is waiting in line for the given counter - CounterId:" + id + ", CounterName:" + name);
    }
}
