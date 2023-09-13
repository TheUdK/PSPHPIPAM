function Get-PhpIpamNameservers {
    [cmdletbinding()]
    param(

    )
    $r = Invoke-PhpIpamExecute -method get -controller tools -identifiers @('nameservers')
    Resolve-PhpIpamExecuteResult -result $r
}

New-Alias -Name Get-PhpIpamAllNameservers -Value Get-PhpIpamNameservers
Export-ModuleMember -Function Get-PhpIpamNameservers -Alias Get-PhpIpamAllNameservers