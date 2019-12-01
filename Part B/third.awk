BEGIN {
	TCPSent = 0;
	TCPReceived = 0;
		TCPLost = 0;
	UDPSent = 0;
	UDPReceived = 0;
	UDPLost = 0;
	totalSent = 0;
	totalReceived = 0;
	totalLost = 0;

}
{
packetType = $5
event = $1
 if(packetType == "tcp")
	{
	if(event == "+")
	{
	 TCPSent++;
	}
     else if(event == "r")
	{
	TCPReceived++;
	}
	else if(event == "d")
	{
	TCPLost++;
	}
}
 else if(packetType == "cbr")
	{
	if(event == "+")
	{
	 UDPSent++;
	}
     else if(event == "r")
	{
	UDPReceived++;
	}
	else if(event == "d")
	{
	UDPLost++;
	}
}
}
END {
	totalSent =TCPSent+UDPSent;
	totalReceived=TCPReceived+UDPReceived;
	totalLost=TCPLost+UDPLost;

	printf("\nTCP Packets sent: %d\n",TCPSent);
	printf("TCP Packets Received: %d\n",TCPReceived);

	printf("TCP Packets lost: %d\n",TCPLost);

	printf("UDP Packet Sent: %d\n",UDPSent);

	printf("UDP Packet Received: %d\n",UDPReceived);

	printf("UDP Packet Dropped: %d\n",UDPLost);
	printf("Total Sent : %d\n",totalSent);
	printf("Total Received : %d\n",totalReceived);
	printf("Total Dropped: %d\n",totalLost);


}
