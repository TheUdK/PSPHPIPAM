function Resolve-PhpIpamExecuteResult {
    [cmdletbinding()]
    param (
        $result
    )
    Write-Debug "Input Result=$($result|convertto-json -Depth 100)"

    if ($result -and $result.success -and $result.data) {
        return $result.data
    }
    elseif ($result -and $result.code -eq 404 -and $result.success -match 'false') {
        #return error with code and message
        throw "Error $($result.code): $($result.message)"
    }
    else {
        throw $result
    }

}
