#!/bin/bash
#server local time
VPS_TIME='Asia/Manila'
function InstUpdates(){
 export DEBIAN_FRONTEND=noninteractive
 apt-get update
 apt-get upgrade -y
 
 # Removing some firewall tools that may affect other services
 apt-get remove --purge ufw firewalld -y

 
 # Installing some important machine essentials
 apt-get install nano wget curl zip unzip tar gzip p7zip-full bc rc openssl cron net-tools dnsutils dos2unix screen bzip2 ccrypt -y
 
 
 # Installing a text colorizer
 gem install lolcat

 # Trying to remove obsolette packages after installation
 apt-get autoremove -y
}
InstUpdates

#adding ports
openvpn_port='110'
Privoxy_Port1='8000'
Privoxy_Port2='8080'
function privoxy (){
 #Removing Duplicate privoxy config
 apt-get install privoxy -y
 rm -rf /etc/privoxy/config*
 # Creating Privoxy server config using cat eof tricks
 cat <<'myPrivoxy' > /etc/privoxy/config
# My Privoxy Server Config
user-manual /usr/share/doc/privoxy/user-manual
confdir /etc/privoxy
logdir /var/log/privoxy
filterfile default.filter
logfile logfile
listen-address 0.0.0.0:Privoxy_Port1
listen-address 0.0.0.0:Privoxy_Port2
toggle 1
enable-remote-toggle 0
enable-remote-http-toggle 0
enable-edit-actions 0
enforce-blocks 0
buffer-limit 4096
enable-proxy-authentication-forwarding 1
forwarded-connect-retries 1
accept-intercepted-requests 1
allow-cgi-request-crunching 1
split-large-forms 0
keep-alive-timeout 5
tolerate-pipelining 1
socket-timeout 300
permit-access 0.0.0.0/0 IP-ADDRESS
myPrivoxy
    }
privoxy

 # Setting machine's IP Address inside of our privoxy config(security that only allows this machine to use this proxy server)
 #sed -i "s|IP-ADDRESS|$IPADDR|g" /etc/privoxy/config
 
 # Setting privoxy ports
 sed -i "s|Privoxy_Port1|$Privoxy_Port1|g" /etc/privoxy/config
 sed -i "s|Privoxy_Port2|$Privoxy_Port2|g" /etc/privoxy/config

function openvpn (){
    #removing openvpn files
    rm -Rf /etc/openvpn/*
    echo >> /etc/sysctl.conf net.ipv4.ip_forward = 1
    sysctl -p
    #make directories
    mkdir /etc/openvpn/
    mkdir /etc/openvpn/server
    mkdir /etc/openvpn/client/
    mkdir /etc/openvpn/easy-rsa
    mkdir /etc/openvpn/easy-rsa/keys
    mkdir /etc/openvpn/xFocus
    #touch /etc/openvpn/xFocus/config.ovpn
#install openvpn
    apt-get install openvpn -y
    cp -r /usr/share/easy-rsa /etc/openvpn/
    #ca.crt here
    cat <<EOF1> /etc/openvpn/easy-rsa/keys/ca.crt
#or /usr/share/doc/openvpn/examples/sample-keys/ca.crt
    -----BEGIN CERTIFICATE-----
MIIE6DCCA9CgAwIBAgIJAISjqDk245utMA0GCSqGSIb3DQEBCwUAMIGoMQswCQYD
VQQGEwJQSDEWMBQGA1UECBMNTnVldmEgVml6Y2F5YTEOMAwGA1UEBxMFRHVwYXgx
ETAPBgNVBAoTCFBFUlNPTkFMMREwDwYDVQQLEwhQRVJTT05BTDEUMBIGA1UEAxML
UEVSU09OQUwgQ0ExDjAMBgNVBCkTBWlEZXJmMSUwIwYJKoZIhvcNAQkBFhZ4Zm9j
dXMubWUwMDFAZ21haWwuY29tMB4XDTIxMDIyODE3NTE1MVoXDTMxMDIyNjE3NTE1
MVowgagxCzAJBgNVBAYTAlBIMRYwFAYDVQQIEw1OdWV2YSBWaXpjYXlhMQ4wDAYD
VQQHEwVEdXBheDERMA8GA1UEChMIUEVSU09OQUwxETAPBgNVBAsTCFBFUlNPTkFM
MRQwEgYDVQQDEwtQRVJTT05BTCBDQTEOMAwGA1UEKRMFaURlcmYxJTAjBgkqhkiG
9w0BCQEWFnhmb2N1cy5tZTAwMUBnbWFpbC5jb20wggEiMA0GCSqGSIb3DQEBAQUA
A4IBDwAwggEKAoIBAQDGHPWgctAjH40SFKdYPUhqRQ3By7dwCKLmLcz3TfCsNJy5
uuDJ4VteBFUtbS9mcyoQu97T88OsCzzA4w7LTnU5gFiV1slOpapQwmlpOKyICosF
/5ba9dzjYEDYQAHNE1315O9zhr72pUKAOw1awyVEhKjjxiODZjCNljsMF55wgrP6
4p35LOTcXyqWBE7Cvh//80+WEudo3KwlvQORu0UKnYYuQoZQDT+EXo8wHCzacmq/
IxJnOgl00vlfJ1Mus1khkqsDocRWSSEkp1NHBASriufjJmDqiHuHnKsh/wlja6An
SbqrfZwCkCHmZrk5d84xswrfGcfXLAW5639IxPUlAgMBAAGjggERMIIBDTAdBgNV
HQ4EFgQUT/qlddonZQ1NSedOVs1K7R5zUIQwgd0GA1UdIwSB1TCB0oAUT/qlddon
ZQ1NSedOVs1K7R5zUIShga6kgaswgagxCzAJBgNVBAYTAlBIMRYwFAYDVQQIEw1O
dWV2YSBWaXpjYXlhMQ4wDAYDVQQHEwVEdXBheDERMA8GA1UEChMIUEVSU09OQUwx
ETAPBgNVBAsTCFBFUlNPTkFMMRQwEgYDVQQDEwtQRVJTT05BTCBDQTEOMAwGA1UE
KRMFaURlcmYxJTAjBgkqhkiG9w0BCQEWFnhmb2N1cy5tZTAwMUBnbWFpbC5jb22C
CQCEo6g5NuObrTAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBCwUAA4IBAQAeAIF3
jE5N3GESiEnkqOf4VfEX5V8I1cycvYWJKbuHQLFQy1DbYW/HNYIXQy7j0VdZ3tCl
rhG4XDBXu3m6svPGRDsOpY4h9hJMJI+0c9O5iLosWcDoes3JkFIUwsB5JRZkH70n
kjwD1r974bUy96kLqvn2FnQeJYFE/M/QWBfx0HcS1sOaWidMSVepbpQJVMYZ9jVx
n2mKPwrIrH9l8Fah+RFIYwCXFoNwyBSPWzHH3Od8JKz6Q+6N1hTUEHj8TI2iyB/z
bUkl2LOZ9BkVg7hfkH+WrACZRymLXHrjePDhBRjJ57U+d4bmLr+aQz3R6aI/gTjX
LIBsEs5oIQrq435Y
....-----END CERTIFICATE-----
EOF1
#server.crt HERE
cat <<EOF2> /etc/openvpn/server.crt #or /etc/openvpn/easy-rsa/keys/server.crt #or /usr/share/doc/openvpn/examples/sample-keys/server.crt
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 1 (0x1)
    Signature Algorithm: sha256WithRSAEncryption
        Issuer: C=PH, ST=Nueva Vizcaya, L=Dupax, O=PERSONAL, OU=PERSONAL, CN=PERSONAL CA/name=iDerf/emailAddress=xfocus.me001@gmail.com
        Validity
            Not Before: Feb 28 17:51:51 2021 GMT
            Not After : Feb 26 17:51:51 2031 GMT
        Subject: C=PH, ST=Nueva Vizcaya, L=Dupax, O=PERSONAL, OU=PERSONAL, CN=server/name=iDerf/emailAddress=xfocus.me001@gmail.com
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:bf:ae:50:d7:cd:3c:77:90:ae:bd:36:6d:20:40:
                    82:f3:6f:c3:d1:5a:3f:21:22:eb:20:ad:13:db:c3:
                    ae:b1:39:d4:0b:ba:b9:f1:79:35:04:a7:95:65:d9:
                    38:ae:b8:b0:db:ad:d5:07:fc:f3:90:22:a4:9c:5b:
                    22:9f:81:aa:96:8f:be:5f:a7:67:86:62:31:ae:bc:
                    17:9b:9b:e7:d6:6e:15:47:3a:ce:21:67:51:3e:c8:
                    7a:40:9e:b0:8e:bb:bf:6d:c7:db:12:b5:66:31:bd:
                    4a:c1:cd:fe:fc:76:08:a1:5a:db:7b:df:5c:6c:8c:
                    d0:85:f1:d0:cd:82:0c:e8:bc:24:cd:69:6a:4f:93:
                    34:43:28:fa:a7:1c:0f:70:dd:25:c9:d4:43:6c:49:
                    03:a7:ff:c7:a6:08:92:55:36:91:98:54:cd:b2:3f:
                    6d:12:23:f0:d4:08:06:dc:94:4f:6e:b8:d8:ba:fb:
                    fe:35:b3:6b:e7:ef:35:08:93:93:99:f1:8c:9a:7d:
                    4c:33:a1:03:a6:be:fc:0c:8f:fd:09:41:18:2d:4c:
                    78:4a:ab:6c:af:82:aa:33:9f:b3:34:2c:32:2f:9a:
                    5e:71:6b:81:15:58:ff:48:a0:6d:d1:48:e7:19:77:
                    19:cc:15:09:81:78:5f:0e:96:fc:a8:5e:9d:05:33:
                    a8:f1
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Basic Constraints:
                CA:FALSE
            Netscape Cert Type:
                SSL Server
            Netscape Comment:
                Easy-RSA Generated Server Certificate
            X509v3 Subject Key Identifier:
                2B:91:66:83:0B:A9:08:90:EC:15:30:AB:2A:F7:B9:53:51:E1:77:98
            X509v3 Authority Key Identifier:
                keyid:4F:FA:A5:75:DA:27:65:0D:4D:49:E7:4E:56:CD:4A:ED:1E:73:50:84
                DirName:/C=PH/ST=Nueva Vizcaya/L=Dupax/O=PERSONAL/OU=PERSONAL/CN=PERSONAL CA/name=iDerf/emailAddress=xfocus.me001@gmail.com
                serial:84:A3:A8:39:36:E3:9B:AD

            X509v3 Extended Key Usage:
                TLS Web Server Authentication
            X509v3 Key Usage:
                Digital Signature, Key Encipherment
            X509v3 Subject Alternative Name:
                DNS:server
    Signature Algorithm: sha256WithRSAEncryption
         3c:d8:48:2c:af:68:aa:f6:bc:5b:c7:83:6b:94:1b:18:a9:01:
         ce:a7:f8:13:c9:63:59:d4:82:a5:a6:6a:b5:a6:76:4e:98:69:
         25:78:f0:d9:96:33:bf:d6:32:80:b6:4e:ce:92:71:9c:57:0b:
         64:db:f8:53:f9:d8:cc:c2:fd:80:50:b7:7d:d3:aa:8f:e0:ad:
         a3:c1:46:19:70:4c:b6:1a:b1:cf:d4:8c:a0:39:89:87:2c:94:
         65:90:c9:ac:fe:b8:2f:ae:98:a7:12:8e:28:c3:c5:24:10:ea:
         09:f6:d0:97:33:77:9d:13:cf:1c:18:4e:29:a9:05:91:57:c4:
         ab:3e:82:32:44:cc:81:1d:35:2d:c7:19:c8:93:ab:fc:36:e2:
         86:fb:34:96:30:6b:e7:90:c3:74:44:9f:2e:f7:f6:a3:ae:11:
         ac:2e:a4:37:3b:53:1a:97:07:68:87:c2:da:2a:e6:16:f9:2c:
         7e:f5:c0:d1:16:d2:01:6f:54:9d:1c:08:b6:3a:79:a3:7e:86:
         83:ee:ab:de:f7:63:24:d5:c4:9b:43:b6:e3:37:20:a5:8b:b9:
         cf:13:a2:07:a9:ef:e5:e2:87:89:03:09:1c:70:3d:e6:c9:d1:
         9d:1a:9b:a7:82:82:45:08:fa:b1:5d:e4:05:d4:1a:6a:61:65:
         d2:d5:63:20
-----BEGIN CERTIFICATE-----
MIIFVjCCBD6gAwIBAgIBATANBgkqhkiG9w0BAQsFADCBqDELMAkGA1UEBhMCUEgx
FjAUBgNVBAgTDU51ZXZhIFZpemNheWExDjAMBgNVBAcTBUR1cGF4MREwDwYDVQQK
EwhQRVJTT05BTDERMA8GA1UECxMIUEVSU09OQUwxFDASBgNVBAMTC1BFUlNPTkFM
IENBMQ4wDAYDVQQpEwVpRGVyZjElMCMGCSqGSIb3DQEJARYWeGZvY3VzLm1lMDAx
QGdtYWlsLmNvbTAeFw0yMTAyMjgxNzUxNTFaFw0zMTAyMjYxNzUxNTFaMIGjMQsw
CQYDVQQGEwJQSDEWMBQGA1UECBMNTnVldmEgVml6Y2F5YTEOMAwGA1UEBxMFRHVw
YXgxETAPBgNVBAoTCFBFUlNPTkFMMREwDwYDVQQLEwhQRVJTT05BTDEPMA0GA1UE
AxMGc2VydmVyMQ4wDAYDVQQpEwVpRGVyZjElMCMGCSqGSIb3DQEJARYWeGZvY3Vz
Lm1lMDAxQGdtYWlsLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AL+uUNfNPHeQrr02bSBAgvNvw9FaPyEi6yCtE9vDrrE51Au6ufF5NQSnlWXZOK64
sNut1Qf885AipJxbIp+BqpaPvl+nZ4ZiMa68F5ub59ZuFUc6ziFnUT7IekCesI67
v23H2xK1ZjG9SsHN/vx2CKFa23vfXGyM0IXx0M2CDOi8JM1pak+TNEMo+qccD3Dd
JcnUQ2xJA6f/x6YIklU2kZhUzbI/bRIj8NQIBtyUT2642Lr7/jWza+fvNQiTk5nx
jJp9TDOhA6a+/AyP/QlBGC1MeEqrbK+CqjOfszQsMi+aXnFrgRVY/0igbdFI5xl3
GcwVCYF4Xw6W/KhenQUzqPECAwEAAaOCAYwwggGIMAkGA1UdEwQCMAAwEQYJYIZI
AYb4QgEBBAQDAgZAMDQGCWCGSAGG+EIBDQQnFiVFYXN5LVJTQSBHZW5lcmF0ZWQg
U2VydmVyIENlcnRpZmljYXRlMB0GA1UdDgQWBBQrkWaDC6kIkOwVMKsq97lTUeF3
mDCB3QYDVR0jBIHVMIHSgBRP+qV12idlDU1J505WzUrtHnNQhKGBrqSBqzCBqDEL
MAkGA1UEBhMCUEgxFjAUBgNVBAgTDU51ZXZhIFZpemNheWExDjAMBgNVBAcTBUR1
cGF4MREwDwYDVQQKEwhQRVJTT05BTDERMA8GA1UECxMIUEVSU09OQUwxFDASBgNV
BAMTC1BFUlNPTkFMIENBMQ4wDAYDVQQpEwVpRGVyZjElMCMGCSqGSIb3DQEJARYW
eGZvY3VzLm1lMDAxQGdtYWlsLmNvbYIJAISjqDk245utMBMGA1UdJQQMMAoGCCsG
AQUFBwMBMAsGA1UdDwQEAwIFoDARBgNVHREECjAIggZzZXJ2ZXIwDQYJKoZIhvcN
AQELBQADggEBADzYSCyvaKr2vFvHg2uUGxipAc6n+BPJY1nUgqWmarWmdk6YaSV4
8NmWM7/WMoC2Ts6ScZxXC2Tb+FP52MzC/YBQt33Tqo/graPBRhlwTLYasc/UjKA5
iYcslGWQyaz+uC+umKcSjijDxSQQ6gn20Jczd50TzxwYTimpBZFXxKs+gjJEzIEd
NS3HGciTq/w24ob7NJYwa+eQw3REny739qOuEawupDc7UxqXB2iHwtoq5hb5LH71
wNEW0gFvVJ0cCLY6eaN+hoPuq973YyTVxJtDtuM3IKWLuc8Togep7+Xih4kDCRxw
PebJ0Z0am6eCgkUI+rFd5AXUGmphZdLVYyA=
-----END CERTIFICATE-----
EOF2
#server.key HERE
cat <<EOF3>> /etc/openvpn/easy-rsa/keys/server.key #/usr/share/doc/openvpn/examples/sample-keys/server.key
-----BEGIN PRIVATE KEY-----
MIIEwAIBADANBgkqhkiG9w0BAQEFAASCBKowggSmAgEAAoIBAQC/rlDXzTx3kK69
Nm0gQILzb8PRWj8hIusgrRPbw66xOdQLurnxeTUEp5Vl2TiuuLDbrdUH/POQIqSc
WyKfgaqWj75fp2eGYjGuvBebm+fWbhVHOs4hZ1E+yHpAnrCOu79tx9sStWYxvUrB
zf78dgihWtt731xsjNCF8dDNggzovCTNaWpPkzRDKPqnHA9w3SXJ1ENsSQOn/8em
CJJVNpGYVM2yP20SI/DUCAbclE9uuNi6+/41s2vn7zUIk5OZ8YyafUwzoQOmvvwM
j/0JQRgtTHhKq2yvgqozn7M0LDIvml5xa4EVWP9IoG3RSOcZdxnMFQmBeF8Olvyo
Xp0FM6jxAgMBAAECggEBAIwudq8sSLGEnVaBjFNO+rYAIexknNCmEeEm0uQg+wxf
p2UgnUYtB4os6UTAFQUqyyUNv0OFSbc6rrouqGaQ1Oohm++mpT6RZ5ZLttQ1s9qN
TYB3UDL7tV4+DbJem+72/avSwrOu+Fsd/aM4/Oczh2JB6UxxcM1uOj4LOFJjbv9w
/FXbCVLn6OeqjFzSRtOiPshlXQHENvEYRDiYkmGeNsr5iHwvXYWYe+4i0/sLXDWj
A1vuiCASNKm9CIkegAp0RgzI/rCA2eQbtpt+hW+qwWptDRxnPyF2Y/g0cT0vMY8f
T1gMlsu1bmbxN67Z8Iy6um1t+AG8njQyDQbQqCQV2dUCgYEA74GzI6wRTfz0LFO9
7Srzp1o5UClPf01gSdmGL7WkO8/aQMPSzlTgwWQG2WFQqb9L3vsBzcKfor6Bf/5L
LiwLfne5JWpJ5tYylht0RgKXmVm+JgiT0fRw5bUwbahwSeqKsvdN07qXmO9Z86EK
z+hD1lZd49B+6dJEYFME0UPfOwsCgYEAzOF9KUHC96mHiULzYAuBW+VnyM8NfUvs
PkVd1HiArhwvTlw8S03ZgDcMBmv3EuyXoXWo8uN5+Gkik3AJ2BsXgcto/Bt8Toqv
7J1V7e7SuVVS9hkcwt3HgC/fo183xZp9VsH+RuGgMVh9/v9zz4Jelzx6BRLvRyLt
2jp0OX4CSXMCgYEAv5H6e5nx7XNayungjIdChKWCGkAwuh5l2iwHTLn5N241oIAB
adAyRf2ADPft0RiV0zDqbG4zybSfWIVKFRBd0TZp/SdbHSxPIgmroyQHpj1F/p31
voXKl7GpnsyPpE/ZyPROaABjqYwpYtl5EHszZ4mFZ+co3FW3I2TEAa5MK6kCgYEA
pQAEeLGJf0N88EKHFpate4DpcIOv7XSzsgLTakYR/CaewpDtzgfIXsX2XUWeGhOI
mnPTuKkSlci2G99jTjOjXtiemEradbajr/+WMKTh+HiK87+NtjI+dTIY/c21cOLW
hoR9cEBNbvBBqJe6gSgRXeNKscNqCPRMcjAZYiPlW5kCgYEAhN8utwfoJpy0DfNh
v9VJLWEMPuBUbMMOuR119P8YArNPPx7PTXi4XzbPv7rf99lfuizXZBzmGjKqEOWH
EMtP6kaosO6oZcU6L3w8izeFqYFn+hxL9DENC11xKpCoqFkYKNkKuqghi9KIjoVt
TVxXp5vGwz5umT+nrSnjrkgO6h8=
-----END PRIVATE KEY-----
EOF3
#singin the server key using CA
openssl dhparam -out /etc/openvpn/dh.pem 2048
#configure openvn server
cat <<EOF4> /etc/openvpn/server.conf
port $openvpn_port
proto tcp
dev tun
ca /usr/share/doc/openvpn/examples/sample-keys/ca.crt
cert /etc/openvpn/server.crt
key /etc/openvpn/easy-rsa/keys/server.key
dh /etc/openvpn/dh.pem
server 10.8.0.0 255.255.255.0
push "redirect-gateway def1"

push "dhcp-option DNS 208.67.222.222"
push "dhcp-option DNS 208.67.220.220"
duplicate-cn
cipher AES-256-CBC
tls-version-min 1.2
tls-cipher TLS-DHE-RSA-WITH-AES-256-GCM-SHA384:TLS-DHE-RSA-WITH-AES-256-CBC-SHA256:TLS-DHE-RSA-WITH-AES-128-GCM-SHA256:TLS-DHE-RSA-WITH-AES-128-CBC-SHA256
auth SHA512
auth-nocache
keepalive 20 60
persist-key
persist-tun
compress lz4
daemon
user nobody
group nogroup
log-append /var/log/openvpn.log
verb 2
EOF4
#start openvpn
systemctl start openvpn@server
systemctl enable openvpn@server
#generate client configurstion
cat <<EOF5> /etc/openvpn/client/client.ovpn
client
dev tun
proto tcp
remote IPADDR $openvpn_port
ca ca.crt
cert client.crt
key client.key
cipher AES-256-CBC
auth SHA512
auth-nocache
tls-version-min 1.2
tls-cipher TLS-DHE-RSA-WITH-AES-256-GCM-SHA384:TLS-DHE-RSA-WITH-AES-256-CBC-SHA256:TLS-DHE-RSA-WITH-AES-128-GCM-SHA256:TLS-DHE-RSA-WITH-AES-128-CBC-SHA256
resolv-retry infinite
compress lz4
nobind
persist-key
persist-tun
mute-replay-warnings
verb 2
EOF5
#systemctl status openvpn@server
}
openvpn

function ip_address(){
  local IP="$( ip addr | egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | egrep -v "^192\.168|^172\.1[6-9]\.|^172\.2[0-9]\.|^172\.3[0-2]\.|^10\.|^127\.|^255\.|^0\." | head -n 1 )"
  [ -z "${IP}" ] && IP="$( wget -qO- -t1 -T2 ipv4.icanhazip.com )"
  [ -z "${IP}" ] && IP="$( wget -qO- -t1 -T2 ipinfo.io/ip )"
  [ ! -z "${IP}" ] && echo "${IP}" || echo
}
IPADDR="$(ip_address)"

function ConfStartup(){
 # Daily reboot time of our machine
 # For cron commands, visit https://crontab.guru
 echo -e "0 4\t* * *\troot\treboot" > /etc/cron.d/b_reboot_job
 }
 ConfStartup
 #creating user's opvn config
cat <<EOF999> /etc/openvpn/xFocus/config.ovpn
client
dev tun
proto tcp
remote $IPADDR $openvpn_port
remote-cert-tls server
resolv-retry infinite
nobind
tun-mtu 1500
tun-mtu-extra 32
mssfix 1450
persist-key
persist-tun
auth-user-pass
auth none
auth-nocache
cipher none
keysize 0
comp-lzo
setenv CLIENT_CERT 0
reneg-sec 0
verb 1
http-proxy $IPADDR $Privoxy_Port1

<ca>
$(cat /etc/openvpn/easy-rsa/keys/ca.crt)
</ca>
EOF999
ip_address
 # I'm setting Some Squid workarounds to prevent Privoxy's overflowing file descriptors that causing 50X error when clients trying to connect to your proxy server(thanks for this trick @homer_simpsons)
 rm -rf /etc/squid/sq*
 cat <<'mySquid' > /etc/squid/squid.conf
via off
forwarded_for delete
request_header_access Authorization allow all
request_header_access Proxy-Authorization allow all
request_header_access Cache-Control allow all
request_header_access Content-Length allow all
request_header_access Content-Type allow all
request_header_access Date allow all
request_header_access Host allow all
request_header_access If-Modified-Since allow all
request_header_access Pragma allow all
request_header_access Accept allow all
request_header_access Accept-Charset allow all
request_header_access Accept-Encoding allow all
request_header_access Accept-Language allow all
request_header_access Connection allow all
request_header_access X-Forwarded-For deny all
request_header_access Via deny all
request_header_access Referer deny all
request_header_access All deny all
http_access allow localhost
http_access deny all
http_port 127.0.0.1:8989
cache_peer 127.0.0.1 parent SquidCacheHelper 7 no-query no-digest default
cache deny all
mySquid
 sed -i "s|SquidCacheHelper|$privoxy_port1|g" /etc/squid/squid.conf
clear
echo 'Installation Complete!'
