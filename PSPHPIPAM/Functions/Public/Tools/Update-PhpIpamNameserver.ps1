<#
.SYNOPSIS
    Update PhpIpamNameserver
.DESCRIPTION
    Update PhpIpamNameserver
.EXAMPLE
    PS C:\> Update-PhpIpamNameserver -Params @{id=37;description="test"}
.INPUTS
    Params (hashtable) which contains nameserver info should be provided
.OUTPUTS
    Output (if any)
.NOTES

#>
function Update-PhpIpamSection {
    [cmdletBinding()]
    param(
        [parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, Position = 0)]
        [validatescript({ $_ -is [hashtable] -or $_ -is [psCustomObject] })]
        $Params = @{}
    )
    BEGIN {

    }
    PROCESS {
        $r = Invoke-PhpIpamExecute -method patch -controller sections -params $Params -ErrorAction stop
        if ($r -and $r.success) {
            Get-PhpIpamNameserver -ID $Params['id']
        }
    }
    END {

    }
}


Export-ModuleMember -Function Update-PhpIpamSection