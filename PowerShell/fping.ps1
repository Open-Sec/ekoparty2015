$subnet='192.168.1.'
$ip=1
for ($ip; $ip -lt 255; $ip++)
{
  $ipaddress=$subnet+$ip
  ping $ipaddress
}
