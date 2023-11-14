# Persistant shell

## Information

This is a reverse shell script written for Linux. The reverse shell itself is a basic one-liner, but the script is to try and persistently make a connection, while trying to hide and make copies of itself. The script also makes itself a Daemon and enables itself.

## Usage

This script is a payload that it supposed to run on the victim machine.

The shell retains the user that creates this file on the victim machine.

### Required changes to the script:

- The *ip* and *port* of the attacker listener
- The *destinations* and *filename* for the copies
- The *service_name* of the unit

I tried with basic netcat to recieve the connection, but it is not stable because the shell being created is from a service. To run properly use the following Metasploit module/commands:

```
msf6> use payload/linux/x64/shell/reverse_tcp
msf6> set LHOST eth1 #Or whatever your network interface is called
msf6> exploit
```

Once the connection is established, connect with the following command:
```
msf6> sessions [session number]
```

### **PS. First connection is dropped and then the next connection will connect. Patience is required.**

## To Contribute

You can add for functions to the script and increase the different things the script can do. 
