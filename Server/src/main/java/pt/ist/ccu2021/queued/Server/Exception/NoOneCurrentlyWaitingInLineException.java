package pt.ist.ccu2021.queued.Server.Exception;

public class NoOneCurrentlyWaitingInLineException extends Exception{

    public NoOneCurrentlyWaitingInLineException(int id, String name) {
        super("No one is waiting currently in line for the given counter - CounterId:" + id + ", CounterName:" + name);
    }
}
