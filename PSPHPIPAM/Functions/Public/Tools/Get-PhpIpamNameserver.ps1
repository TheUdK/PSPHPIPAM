<#
.SYNOPSIS
    Get PhpIpam Nameserver by nameserver name or nameserver id
.DESCRIPTION
    Get PhpIpam Nameserver by nameserver name or nameserver id
.EXAMPLE
    PS C:\> New-PhpIpamNameserver -Param @{"name"="nameserver2"}

    id          : 1
    name        : znameserver1
    namesrv1    : 8.8.8.8;9.9.9.9
    description : this is a nameserver

    # get nameserver by nameserver name
    PS C:\> get-PhpIpamNameserver nameserver2

    # get nameserver by nameserver id
    PS C:\> get-PhpIpamNameserver 8

    # specify -id to using explicitly ById ParameterSet
    PS C:\> get-PhpIpamNameserver -id 8

    # specify -name to using explicitly ByName ParameterSet
    PS C:\> get-PhpIpamNameserver -name nameserver2

    # Create an nameserver and get nameserver info using pipeline
    PS C:\> New-PhpIpamNameserver -Param @{"name"="nameserver3"}|get-PhpIpamNameserver

    id          : 1
    name        : Google
    namesrv1    : 8.8.8.8;9.9.9.9
    description : this is a nameserver
    permissions : 4
    editDate    : 2023-03-27 16:38:37
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function Get-PhpIpamNameserver {
    [cmdletbinding()]
    Param(
        [parameter(
            Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            position = 0,
            ParameterSetName = "ByName"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [parameter(
            Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            position = 0,
            ParameterSetName = "ByID"
        )]
        [ValidateNotNullOrEmpty()]
        [int]$ID
    )

    begin {

    }
    process {
        if ($PSCmdlet.ParameterSetName -eq 'ByName') {
            $r = Invoke-PhpIpamExecute -method get -controller tools -identifiers @('nameservers', $name)
        }
        if ($PSCmdlet.ParameterSetName -eq 'ByID') {
            $r = Invoke-PhpIpamExecute -method get -controller tools -identifiers @('nameservers', $ID)
        }
        Resolve-PhpIpamExecuteResult -result $r
    }

    end {

    }
}

New-Alias -Name Get-PhpIpamNameserverByName -Value Get-PhpIpamNameserver
new-alias -Name Get-PhpIpamNameserverByID -Value Get-PhpIpamNameserver
Export-ModuleMember  -function  Get-PhpIpamNameserver -alias "Get-PhpIpamNameserverByName", "Get-PhpIpamNameserverByID"