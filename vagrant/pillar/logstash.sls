logstash:
  elasticsearch_http: False
  elasticsearch_host: 192.168.35.31
  jar_source: 'https://download.elasticsearch.org/logstash/logstash/logstash-1.2.1-flatjar.jar'
  jar_hash: 'md5=863272192b52bccf1fc2cf839a888eaf'
  tags:
    - abc
    - 123
  ssl_enabled: true
  ssl_key: |
    -----BEGIN RSA PRIVATE KEY-----
    MIIEpQIBAAKCAQEA5Qcla2DXrKejcjZJb+CjooKKJa+vDseeb0wQFPWYC4L9SzjL
    09CdsQ0RDU7hZFDpyDFFzWauq+RbpYRRaWi/9zggYgk3ZldiOni6RCGFypPvxjXg
    32ALMHnlMEGOvZ8a06nJsURA1grnNvmFXuAtLwFjJeshYh00q5rOMxNDv8RcH1ir
    44EgTVSWBDomO5C3KQMbRm0zix+w8pPem02s6DW5djQ+8gQNUfpqeyi9fDAGECPZ
    Seqa3zsPzUfTp6t1NRUX7eTF6kHXYavhsHG7zVbmBq6RQP6s1LtORNsuUwWS4JLt
    /dPkbKvLuARORZFMHF4bVTblyWvXh/VjdJ9XzQIDAQABAoIBAQCHCF+Xn9GJio1j
    mX5S6C+ScUTiU2LzY96V4FLbCLJMlz6gSyxiBm3zJbEYF5nse4ha8DInmJMD5e/i
    9tDJRWlpaT4ujyCKxpqzvtqTsPAhMHf+dWXQTeBLBJOMkBqI0nYOtdylF4jiqisI
    zrVD6wi43iiHAsr7/hw/0VYh5wna1d1kREXRS8Gnlo9Y8j5NTOhhi8jUXCBi1359
    MeA1Ju6j07XN0IGaxXv2J4XWGi/A1DgZMsMfwjG/qC3J7RumQYMnDosX9MWc76jU
    RZcQEKcvaVLNdwLyhPGtGYHyQiKiq1AUwJ6kK73LI2Zpg+tyDCZrUfsPQApobi3k
    8Ee2UVABAoGBAP2o5qMiOKPcNzlsUzSb2LlnhRgDcpBzXGK7g6bOxLPoo8oL88pF
    Wvff9/SKQOLvU8GAQC8ivcVQQSdth1NDUDIV1YMFmZDiuvKsEdTrEppEzvgSdWGn
    o05JcMOZ4x/AuO6dYs6fkft52wONPFnmTeFIWsaVA4+Yw1WIqvNDJlaNAoGBAOck
    EbczcG4b8F63exbwvNRsqUy4t4FIymYkFhC+LVwlnCdgCJht2+vQis8AEGoc5MuF
    vzk97kgi/4r4boX86k4yGxocjgGABMnCHudriPRgCLW6EW6AmwzNJtMYwyDg3K7c
    yIi0XrrlqcMZbxcaGSvrEPacZ1IbFR7BtucWEFZBAoGBALqrYldpJq+HruhGTJEp
    o3sFsI90cgnVq4ZJImBOR7lyGZ7l3tna4lAJ9Wpzl76pi0SaQiGt+mPLZLdERlNC
    9TB2mvLZ2yIhiJxvfovnFoCK5Jjw1IsyF97T8vUvOVKzvCR1lDIkggTDryZU+LXb
    4zJH0e3T2ZQCQrWeZtewcfU9AoGANVG+vHIjR2MuicrtnBcgmCgQzd/2hN5Twkgk
    xuv37r/GS9b9ZJxDFRzgSGwNXU0ZAlHyELRWmVFpfZddd48mRa+NTPK1V2c+s4QS
    OPQ3fZgBqlon10PXgJZ6lEusB5OXlMbdg5uIFrkP9i+RztR4ZgctvJXLx8bzkkrB
    dIFEd4ECgYEAvTX47VcONiLa5vHXzv3x+ZtWcMqkL9sdUNlJPSBkYhN3ZTzc2Ynr
    aEJiXsjcJ3I+PMuRl9m7G0fRfpcWkijhaUHoL9X72OPiU1OcITwUeS12EfvANSal
    bVVETdE7GmvKZ/C+Zh5LXwD6eP44HjIdWbObQzoKNaC3yha4R4yQ7+A=
    -----END RSA PRIVATE KEY-----
  ssl_cert: |
    -----BEGIN CERTIFICATE-----
    MIIESDCCAzCgAwIBAgIJAKXR2hD+KfFWMA0GCSqGSIb3DQEBBQUAMHUxCzAJBgNV
    BAYTAlVTMQ4wDAYDVQQIEwVDbG91ZDELMAkGA1UEBxMCSFAxCzAJBgNVBAoTAkhQ
    MQswCQYDVQQLEwJIUDERMA8GA1UEAxMIbG9nc3Rhc2gxHDAaBgkqhkiG9w0BCQEW
    DWRuc2Fhc0BocC5jb20wHhcNMTMxMDE4MDg1NjI0WhcNMTQxMDE4MDg1NjI0WjB1
    MQswCQYDVQQGEwJVUzEOMAwGA1UECBMFQ2xvdWQxCzAJBgNVBAcTAkhQMQswCQYD
    VQQKEwJIUDELMAkGA1UECxMCSFAxETAPBgNVBAMTCGxvZ3N0YXNoMRwwGgYJKoZI
    hvcNAQkBFg1kbnNhYXNAaHAuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
    CgKCAQEA5Qcla2DXrKejcjZJb+CjooKKJa+vDseeb0wQFPWYC4L9SzjL09CdsQ0R
    DU7hZFDpyDFFzWauq+RbpYRRaWi/9zggYgk3ZldiOni6RCGFypPvxjXg32ALMHnl
    MEGOvZ8a06nJsURA1grnNvmFXuAtLwFjJeshYh00q5rOMxNDv8RcH1ir44EgTVSW
    BDomO5C3KQMbRm0zix+w8pPem02s6DW5djQ+8gQNUfpqeyi9fDAGECPZSeqa3zsP
    zUfTp6t1NRUX7eTF6kHXYavhsHG7zVbmBq6RQP6s1LtORNsuUwWS4JLt/dPkbKvL
    uARORZFMHF4bVTblyWvXh/VjdJ9XzQIDAQABo4HaMIHXMB0GA1UdDgQWBBQUk8n3
    UQquzjOcanBmNpmu+sj/szCBpwYDVR0jBIGfMIGcgBQUk8n3UQquzjOcanBmNpmu
    +sj/s6F5pHcwdTELMAkGA1UEBhMCVVMxDjAMBgNVBAgTBUNsb3VkMQswCQYDVQQH
    EwJIUDELMAkGA1UEChMCSFAxCzAJBgNVBAsTAkhQMREwDwYDVQQDEwhsb2dzdGFz
    aDEcMBoGCSqGSIb3DQEJARYNZG5zYWFzQGhwLmNvbYIJAKXR2hD+KfFWMAwGA1Ud
    EwQFMAMBAf8wDQYJKoZIhvcNAQEFBQADggEBAMbQYbBk4W6LCu94AGGKZ/RURw9C
    KBSSQoCCzhvT1mGSytQ3/zVBfBaUku++lvi6hm2DwyypeWCNDlmUcpljgsxev9IE
    QICpHKuXnA/hmsD29R9fXHxuDoP7tBDteBQmD3MDclvEItUHoY5qHNsxxL6+UFav
    c72bB0x9qS0qq6aB1/Y+1L8CEA6CvxK1YxtjkkCK0PZLItEO0C0efKnluIWiMtve
    f6SdGaa8NNsSqPcKQiwVpftRV8TnhTO38j7gkrmLWLPqczApp17cYYw7ALlxlrn9
    lnPc2cqZxBzPgynUdsGGq3pu7VrjAm+BZowm/EsmdrDLLSpI7nzUtlj5t44=
    -----END CERTIFICATE-----
