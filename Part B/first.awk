BEGIN{
   totalSent = 0;
   totalReceived = 0;
   totalLost = 0;
}
{
   packetType = $5; 
   event =$1
     if(packetType == "cbr")
	{
	if(event == "+")
	{
	 totalSent++;
	}
     else if(event == "r")
	{
	totalReceived++;
	}
	else if(event == "d")
	{
	totalLost++;
	}
 }
}
END{
	
printf("Total Received : %d\n",totalReceived);
printf("Total lost : %d\n",totalLost);
 }
