<#
.SYNOPSIS
    Remove PhpIpam Nameserver by nameserver ID
.DESCRIPTION
    Remove PhpIpam Nameserver by nameserver ID
.PARAMETER ID
    The nameserver id
.EXAMPLE
    # Create a nameserver
    PS C:\> New-PhpIpamNameserver -Params @{name='Google;namesrv1='8.8.8.8;8.8.4.4';permissions='1;2}
    # Get this nameserver
    PS C:\> $nameserver=Get-PhpIpamNameservers|?{$_.name -eq 'Google' -and $_.id -eq 7 }
    # Delete this nameserver
    PS C:\> Remove-PhpIpamNameserverByID -ID $nameserver
    OR
    PS C:\> $Nameserver|Remove-PhpIpamNameserver

.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function Remove-PhpIpamNameserver {
    [cmdletBinding()]
    Param(
        [parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, position = 0)]
        [int]$ID
    )

    begin {
        Write-Verbose $ID
    }
    process {
        $r = Invoke-PhpIpamExecute -method delete -controller tools -identifiers @('nameservers', $ID)
        if ($r -and $r.success) {
            return $true
        }
        else {
            return $false
        }
    }

    end {

    }
}
New-Alias -name Remove-PhpIpamNameserverByID -Value Remove-PhpIpamNameserver
Export-ModuleMember -Function Remove-PhpIpamNameserver -alias Remove-PhpIpamNameserverByID