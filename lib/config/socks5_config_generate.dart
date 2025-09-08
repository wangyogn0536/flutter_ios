/// Created by 刘冰.
/// Date:2024/2/20
/// des:socks5的封装文件结构体

String socks5ConfigGenerate(
  String serverAddress,
  int serverPort,
  String username,
  String password,
) =>
    '''
{
  "inbounds": [
    {
      "listen": "127.0.0.1",
      "port": 10808,
      "protocol": "socks",
      "settings": {
        "auth": "noauth",
        "udp": true,
        "userLevel": 8
      },
      "sniffing": {
        "destOverride": [
          "http",
          "tls",
          "fakedns"
        ],
        "enabled": true
      },
      "tag": "socks"
    },
    {
      "listen": "127.0.0.1",
      "port": 10809,
      "protocol": "http",
      "settings": {
        "userLevel": 8
      },
      "tag": "http"
    },
    {
      "listen": "127.0.0.1",
      "port": 10853,
      "protocol": "dokodemo-door",
      "settings": {
        "address": "119.29.29.29",
        "network": "tcp,udp",
        "port": 53
      },
      "tag": "dns-in"
    }
  ],
  "outbounds": [
    {
      "mux": {
        "concurrency": -1,
        "enabled": false,
        "xudpConcurrency": 8,
        "xudpProxyUDP443": ""
      },
      "protocol": "socks",
      "settings": {
        "servers": [
          {
            "address": "$serverAddress",
            "level": 8,
            "method": "chacha20-poly1305",
            "ota": false,
            "password": "",
            "port": $serverPort,
            "users": [
              {
                "level": 8,
                "pass": "$password",
                "user": "$username"
              }
            ]
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": ""
      },
      "tag": "proxy"
    },
    {
      "protocol": "freedom",
      "settings": {
        "domainStrategy": "UseIP"
      },
      "tag": "direct"
    },
    {
      "protocol": "dns",
      "tag": "dns-out"
    }
  ],
  "remarks": "1",
  "routing": {
    "domainStrategy": "IPIfNonMatch",
    "rules": [
      {
        "inboundTag": [
          "dns-in"
        ],
        "outboundTag": "dns-out"
      },
      {
        "ip": [
          "119.29.29.29"
        ],
        "outboundTag": "proxy",
        "port": "53"
      },
      {
        "outboundTag": "proxy",
        "port": "0-65535"
      }
    ]
  }
}
''';
