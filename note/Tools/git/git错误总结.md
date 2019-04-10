#错误一
```
git - error: RPC failed; result=22, HTTP code = 400
```

解决：
```
https://mirrors.edge.kernel.org/pub/software/scm/git/docs/git-config.html
http.postBuffer
Maximum size in bytes of the buffer used by smart HTTP transports when POSTing data to the remote system. For requests larger than this buffer size, HTTP/1.1 and Transfer-Encoding: chunked is used to avoid creating a massive pack file locally. Default is 1 MiB, which is sufficient for most requests.

git config --global http.postBuffer 52428800
```
