set1.pcap

1.  1503
2.  FTP
3.  FTP is not encrypted, everything is sent in the clear
4.  SSH (sometimes known as SFTP)
5.  10.245.145.124
6.  USER:  ihackpineapples
    PASS:  rockyoul
7.  4
8.  BjN-O1hCAAAZbiq.jpg
	BvgT9p2IQAEEoHu.jpg
	BvzjaN-IQAA3XG7.jpg
	smash.txt
10.  77882
11.  1
12.  sudo ettercap -T -r set2.pcap | grep "PASS:"
13.  USER:  chris@digitalinterlude.com
    PASS:  Volrathw69
    Protocol: POP
    Server IP: 75.126.75.131
    Port: 110
    Domain: mail.si-sv3231.com
14. It was valid and accepted
15. Follow TCP stream - "Password ok".  Then 143 sm messages were returned
16. Ensure that you are using an encrypted (SSL) connection.  Email clients have options for requiring SSL on all connections.