#Required by functions
#New-DialUPTunnelDynamic
#New-DialUPTunnelStatic

Function New-P2PPhase1InterfaceDialUp {
    <#
    .Description
    To create Phase 1 Interfaces for the Functions Listed in the Link help.
    #>

    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true, ParameterSetName = "Static")]
        [switch]
        $RemoteNat,
        [Parameter(Mandatory = $true, ParameterSetName = "Dynamic")]
        [switch]
        $BehindNat,
        [Parameter(Mandatory = $true, HelpMessage = "Provide a VPN Tunnel Name with a maximum 15 AlphaNumeric characters.", ParameterSetName = "Static")]
        [Parameter(Mandatory = $true, HelpMessage = "Provide a VPN Tunnel Name with a maximum 15 AlphaNumeric characters.", ParameterSetName = "Dynamic")]
        $TunnelName,
        [Parameter(Mandatory = $true, HelpMessage = "Provide the name of the public interface for this tunnel.", ParameterSetName = "Static")]
        [Parameter(Mandatory = $true, HelpMessage = "Provide the name of the public interface for this tunnel.", ParameterSetName = "Dynamic")]
        $Interface,
        [Parameter(Mandatory = $true, HelpMessage = "Specify the Public IP for the Tunnel Peer", ParameterSetName = "Dynamic")]
        $PeerAddress,
        [Parameter(Mandatory = $true, HelpMessage = "
des-md5          des-md5
des-sha1         des-sha1
des-sha256       des-sha256
des-sha384       des-sha384
des-sha512       des-sha512
3des-md5         3des-md5
3des-sha1        3des-sha1
3des-sha256      3des-sha256
3des-sha384      3des-sha384
3des-sha512      3des-sha512
aes128-md5       aes128-md5
aes128-sha1      aes128-sha1
aes128-sha256    aes128-sha256
aes128-sha384    aes128-sha384
aes128-sha512    aes128-sha512
aes192-md5       aes192-md5
aes192-sha1      aes192-sha1
aes192-sha256    aes192-sha256
aes192-sha384    aes192-sha384
aes192-sha512    aes192-sha512
aes256-md5       aes256-md5
aes256-sha1      aes256-sha1
aes256-sha256    aes256-sha256
aes256-sha384    aes256-sha384
aes256-sha512    aes256-sha512

Type in the encryption selection to use for the Phase 1 Proposal in a space delimited format.
", ParameterSetName = "Static")]
        [Parameter(Mandatory = $true, HelpMessage = "
des-md5          des-md5
des-sha1         des-sha1
des-sha256       des-sha256
des-sha384       des-sha384
des-sha512       des-sha512
3des-md5         3des-md5
3des-sha1        3des-sha1
3des-sha256      3des-sha256
3des-sha384      3des-sha384
3des-sha512      3des-sha512
aes128-md5       aes128-md5
aes128-sha1      aes128-sha1
aes128-sha256    aes128-sha256
aes128-sha384    aes128-sha384
aes128-sha512    aes128-sha512
aes192-md5       aes192-md5
aes192-sha1      aes192-sha1
aes192-sha256    aes192-sha256
aes192-sha384    aes192-sha384
aes192-sha512    aes192-sha512
aes256-md5       aes256-md5
aes256-sha1      aes256-sha1
aes256-sha256    aes256-sha256
aes256-sha384    aes256-sha384
aes256-sha512    aes256-sha512

Type in the encryption selection to use for the Phase 1 Proposal in a space delimited format.
", ParameterSetName = "Dynamic")]
        $Proposal,
        [Parameter(Mandatory = $true, HelpMessage = "Provide the DH Group or Groups in space delimeted format.", ParameterSetName = "Static")]
        [Parameter(Mandatory = $true, HelpMessage = "Provide the DH Group or Groups in space delimeted format.", ParameterSetName = "Dynamic")]
        $dhgroups,
        [Parameter(Mandatory = $true, HelpMessage = "Specify the PSK for the Tunnel", ParameterSetName = "Static")]
        [Parameter(Mandatory = $true, HelpMessage = "Specify the PSK for the Tunnel", ParameterSetName = "Dynamic")]
        $PSK,
        [Parameter(Mandatory = $true, HelpMessage = "Specify a unique 3 digit numeric peer ID to use for the tunnel.", ParameterSetName = "Static")]
        [Parameter(Mandatory = $true, HelpMessage = "Specify a unique 3 digit numeric peer ID to use for the tunnel.", ParameterSetName = "Dynamic")]
        $PeerID
    )

    if ($RemoteNat) {
        Write-Output "
config vpn ipsec phase1-interface
    edit ""$TunnelName""
        set type dynamic
        set interface ""$Interface""
        set mode aggressive
        set peertype one
        set net-device enable
        set add-route enable
        set proposal $Proposal
        set dpd on-idle
        set dhgrp $dhgroups
        set peerid $PeerID
        set dpd-retryinterval 60
        set psksecret $PSK
    next
end
"
    }
    if ($BehindNat) {
        Write-Output "
config vpn ipsec phase1-interface
    edit ""$TunnelName""
        set interface ""$Interface""
        set mode aggressive
        set peertype any
        set net-device enable
        set add-route enable
        set proposal $Proposal
        set localid $Peerid
        set dhgrp $dhgroups
        set remote-gw $Peeraddress
        set psksecret $PSK
    next
end"
    }
}