#simulate  the different type of internet traffic 
set ns [new Simulator]


set traceFile [open 2.tr w]
$ns trace-all $traceFile

set namFile [open 2.nam w]
$ns namtrace-all $namFile


 proc finish {} {
	global ns namFile traceFile
	$ns flush-trace

	close $traceFile
	close $namFile

	exec awk -f second.awk 2.tr &
        exec nam 2.nam &
exit 0
}

for {set i 0} {$i < 4} {incr i} {
     set n($i) [$ns node]
}



$ns duplex-link $n(0) $n(2) 2Mb 10ms DropTail
$ns duplex-link $n(1) $n(2) 2Mb 10ms DropTail
$ns duplex-link $n(2) $n(3) 900Kb 10ms DropTail

#Set Queue Size

$ns queue-limit $n(0) $n(2) 10


$n(1) shape hexagon
$n(1) color green
$n(2) color red
$n(3) shape square
$n(3) color blue
#set connection  telnet and tcp n(0) n(3)
set tcp0 [new Agent/TCP]
$ns attach-agent $n(0) $tcp0
set sink0 [new Agent/TCPSink]
$ns attach-agent $n(3) $sink0
$ns connect $tcp0 $sink0

#attach telnet application over TCP
set telnet [new Application/Telnet]
$telnet attach-agent $tcp0
$telnet set interval  0
 
#set Tcp Ftp connection
set tcp1 [new Agent/TCP]
$ns attach-agent $n(1) $tcp1

set sink1 [new Agent/TCPSink]
$ns attach-agent $n(3) $sink1
$ns connect $tcp1 $sink1


set ftp [new Application/FTP]
$ftp attach-agent $tcp1

$ftp set type_ FTP

$ns at 0.5 "$telnet start"
$ns at 0.6 "$ftp start"
$ns at 24.5 "$telnet stop"
$ns at 24.5 "$ftp stop"
$ns at 25.0 "finish"
$ns run 
