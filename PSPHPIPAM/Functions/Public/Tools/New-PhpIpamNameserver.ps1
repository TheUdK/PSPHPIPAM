<#
.SYNOPSIS
    Create PhpIpamNameserver
.DESCRIPTION
    Create PhpIpamNameserver
.EXAMPLE
    # Create an nameserver and get nameserver info using pipeline
    PS C:\> New-PhpIpamNameserver -Param @{"name"="section3"}|get-PhpIpamNameserver

    id          : 3
    name        : namesservers
    namesrv1    : 172.10.10.10;172.10.10.10
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
        $Params = @{},
        [parameter]
        [switch]$AllSections
    )
    begin {

    }
    process {
        if ($AllSections) {
            Get-PhpIpamSections | % { $Params.Add('permissions', $_.id) }
        }
        if ($(Invoke-PhpIpamExecute -method post -controller tools -identifiers @('nameservers') -params $Params).success) {
            if ($Params.ContainsKey('name')) {
                Get-PhpIpamNameserver -Name $Params['name']
            }
        }
    }
    end {

    }
}

Export-ModuleMember -Function New-PhpIpamNameserver