<#
.SYNOPSIS
    Create PhpIpamNameserver
.DESCRIPTION
    Create PhpIpamNameserver
.EXAMPLE
    # Create an nameserver and get nameserver info using pipeline
    PS C:\> New-PhpIpamNameserver-Param @{"name"="section3"}|get-PhpIpamNameserver

    id          : 3
    name        : zNet
    namesrv1    : 172.20.61.10;172.20.202.10
    description :
    permissions : 4
    editDate    : 2023-03-27 16:38:37
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function New-PhpIpamNameserver {

    [cmdletBinding()]
    Param(
        [parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, Position = 0)]
        [validateScript({ $_ -is [system.collections.hashtable] })]
        $Params = @{}
    )
    begin {

    }
    process {
        if ($(Invoke-PhpIpamExecute -method post -controller tools -identifiers @('nameservers') -params $Params).success) {
            if ($Params.ContainsKey('name')) {
                Get-PhpIpamSectionByName -Name $Params['name']
            }
        }
    }
    end {

    }
}

Export-ModuleMember -Function New-PhpIpamNameserver