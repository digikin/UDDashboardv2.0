Get-UDDashboard | Stop-UDDashboard
$Theme = Get-UDTheme Azure
$Schedule = New-UDEndpointSchedule -Every 1 -Minute
$Endpoint = New-UDEndpoint -Schedule $Schedule -Endpoint {
    $Cache:Random = (Get-Random -Minimum 0 -Maximum 10)
}
Start-UDDashboard -Content {
    New-UDDashboard -Title "Server - Test" -Theme $Theme -Content{

        New-UDMonitor -Title "Downloads per second" -Type Line -Endpoint {
            $Cache:Random | Out-UDMonitorData
        }

        New-UDCard -Title 'Hello' -Content{
            New-UDParagraph -Text 'Simple Data Put Here'
        }


    }
} -Port 10000 -Endpoint $Endpoint -Name 'Demo'
