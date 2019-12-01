BEGIN{
	TCPPacketRec = 0;
	UDPPacketRec = 0;
	TCPPacketDrop = 0;
	UDPPacketDrop = 0;
}
{
	event = $1;
	packetType = $5;
	if(event == "r"){
		if(packetType == "tcp"){
			TCPPacketRec++;
		}
		else if(packetType == "cbr"){
			UDPPacketRec++;
		}
	}
	else if(event == "d"){
		if(packetType == "tcp"){
			TCPPacketDrop++;
		}
		else if(packetType == "cbr"){
			UDPPacketDrop++;
		}
	}
}
END{
	printf("\nTCP:\t Recieved: %d\tDropped: %d",TCPPacketRec,TCPPacketDrop);
	printf("\nUDP:\t Recieved: %d\tDropped: %d\n",UDPPacketRec,UDPPacketDrop);
}
