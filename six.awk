BEGIN{
	FTPPacket = 0;
	FTPSize = 0;
	cbrSize = 0;
	cbrPacket = 0;
}
{
	event = $1;
	pktType = $5;
	pktSize = $6;
	
	if(event == "r" && pktType == "tcp"){
		FTPPacket++;
		FTPSize = pktSize;
	}
	if(event == "r" && pktType == "cbr"){
		cbrPacket++;
		cbrSize = pktSize;
	}
}
END{
	totalFTP = FTPPacket*FTPSize;
	totalCBR = cbrPacket*cbrSize;
	printf("\nThroughput of FTP is: %d bytes per second\n",totalFTP/123.0);
	printf("Throughput of CBR is: %d bytes per second\n",totalCBR/124.4);
}
