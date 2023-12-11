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
function Update-PhpIpamNameserver {
    [cmdletBinding()]
    param(
        [parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, Position = 0)]
        [validatescript({ $_ -is [hashtable] -or $_ -is [psCustomObject] })]
        $Params = @{},
        [parameter]
        [switch]$AllSections
    )
    BEGIN {

    }
    PROCESS {
        if ($AllSections) {
            Get-PhpIpamSections | % { $Params.Add('permissions', $_.id) }
        }
        $r = Invoke-PhpIpamExecute -method patch -controller sections -params $Params -ErrorAction stop
        if ($r -and $r.success) {
            Get-PhpIpamNameserver -ID $Params['id']
        }
    }
    END {

    }
}


Export-ModuleMember -Function Update-PhpIpamNameserver