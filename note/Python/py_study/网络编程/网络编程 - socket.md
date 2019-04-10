# socket
## Socket Families(地址簇)
- socket.AF_UNIX #unix本机进程间通信(默认进程之间不能通信)
- socket.AF_INET #IPV4
- socket.AF_INET6 #IPV6

## Socket Types
- socket.SOCK_STREAM #for tcp
- socket.SOCK_DGRAM #for udp
- socket.SOCK_RAW  #原始套接字，普通的套接字无法处理ICMP、IGMP等网络报文，而SOCK_RAW可以，其次，SOCK_RAW也可以处理特殊的IPV4报文；此外利用原始套接字，可以通过IP_HDRINCL套接字选项由用户构造IP头。
- socket.SOCK_RDM  #是一种可靠的UDP形式，即保证交付数据报但不保证顺序。SOCK_RAM用来提供对原始协议的低级访问，在需要执行某些特殊操作时使用，如发送ICMP报文。SOCK_RAM通常仅限于高级用户或管理员运行的程序使用。

## socket收发信息示例1-返回命令执行结果
```python
#客户端发送信息 centOS py3.5下
import socket

client = socket.socket()
client.connect(('localhost', 6999))

while True:
    cmd = input("Please enter command to execute >>>").strip()
    if len(cmd) == 0:
        print("Please enter valid instructions again")
        continue
    client.send(cmd.encode("utf-8"))
    cmd_res_size = client.recv(1024)
    print("Command return value size：", cmd_res_size)
    client.send("client_ack".encode())
    received_size = 0
    received_data = b''
    while received_size < int(cmd_res_size.decode()):
        data = client.recv(1024)
        received_size += len(data)
        received_data += data
    else:
        print("cmd res received done...", received_size)
        print(received_data.decode())
client.close()

```

```python
#服务端接收信息、并返回信息  centOS py3.5下
import os
import time
import socket

server = socket.socket()
server.bind(('localhost', 6999))
server.listen()

while True:
    conn, addr = server.accept()
    print("New connect：", addr)
    while True:
        print("Wait for new instruction...")
        data = conn.recv(1024)
        if not data:
            print("The client has been disconnected.")
            break
        print("The new instruction is <%s>", data, type(data))
        cmd_res = os.popen(data.decode("utf-8")).read()
        print("Before send", len(cmd_res))
        if len(cmd_res) == 0:
            cmd_res = "cmd has no output..."
        conn.send(str(len(cmd_res.encode())).encode("utf-8"))
        #time.sleep(0.5)
        client_ack = conn.recv(1024)
        conn.send(cmd_res.encode("utf-8"))
        print("Send done.")
        print("--------------------------")
server.close()
```

## socket收发信息示例2-下载文件
```python
#下载文件 客户端
import socket, hashlib

client = socket.socket()
client.connect(("localhost", 9999))

while True:
  cmd = input("Please enter instruction to executed >>> ")
  if len(cmd) == 0:
    print("You content is null, please enter again！")
    continue
  if cmd.startswith("get"):    #检查字符串是否已get开头、返回True
    client.send(cmd.encode())
    server_response = client.recv(1024)    #接收服务端传来的文件尺寸
    print("Server response：", server_response)
    client.send(b"ready to recv file")    #向服务端发送“开始发送文件”指令
    file_total_size = int(server_response.decode())    #把文件尺寸变为整型
    received_size = 0    #定义已经接受的文件尺寸变量
    filename = cmd.split()[1]    #下载的文件名
    f = open(filename + ".new", 'wb')
    m = hashlib.md5()    #客户端文件的MD5、最后用来和服务端的MD5值对比

    #循环接收文件内容、并指定最后一次剩余多少就接收多少
    while received_size < file_total_size:
      if file_total_size - received_size > 1024:
        size = 1024
      else:
        size = file_total_size - received_size
        print("The last received!", size)

      data = client.recv(size)
      received_size += len(data)    #已接收文件尺寸
      m.update(data)    #已接受文件的MD5值
      f.write(data)
    else:
      new_file_md5 = m.hexdigest()    #客户端文件的MD5
      print("file recv done", received_size, file_total_size)
      f.close()
    server_file_md5 = client.recv(1024)
    print("server file md5：", server_file_md5)
    print("client file md5：", new_file_md5)
client.close()

```

```python
#下载文件 服务端
import os
import socket, hashlib, time

server = socket.socket()
server.bind(("localhost", 9999))
server.listen()

while True:
  conn, addr = server.accept()
  print("New connect address!", addr)
  while True:
    print("Waiting for new instruction......")
    data = conn.recv(1024)
    if not data:    #如果接收内容为空、回到接收状态
      print("The client-side has been disconnected!")
      break
    cmd, filename = data.decode().split()    #cmd 是下载命令；filename是下载的文件名
    print("The client-side want to download filename：<%s>" % filename)
    if os.path.isfile(filename):    #判断是否为文件
      f = open(filename, 'rb')
      m = hashlib.md5()
      file_size = os.stat(filename).st_size    #返回文件大小
      conn.send(str(file_size).encode())    #向客户端发送文件尺寸
      #time.sleep(0.5)
      conn.recv(1024)    #接收客户端确认接收文件指令、防止粘包
      for line in f:
        m.update(line)    #生成MD5
        conn.send(line)   #向客户端逐行发送文件内容
      print("The file md5 is：", m.hexdigest())
      f.close()
      conn.send(m.hexdigest().encode())    #发送文件MD5
    print("send done!")
server.close()
```
# socketserver
## sockserver类型
- socketserver.TCPServer
- socketserver.UDPServer
- socketserver.UnixStreamServer
- socketserver.unixDatagramServer

## 实现过程
1. First, you must create a request handler class by subclassing the BaseRequestHandler class and overriding its handle() method; this method will process incoming requests. 　　
2. Second, you must instantiate one of the server classes, passing it the server’s address and the request handler class.
3. Then call the handle_request() or serve_forever() method of the server object to process one or many requests.
4. server.handle_request() #只处理一个请求
5. server.serve_forever() #处理多个请求，永远执行

## 示例1
```python
# 客户端
import socket, hashlib

client = socket.socket()
client.connect(("localhost", 6970))

while True:
    data = input("Please enter a instruction to execute >>> ")
    if len(data) == 0:
        continue
    client.send(data.encode())
    received_data = client.recv(1024)
    print(received_data)
client.close()
```

```python
# 服务器端
import socketserver


class MyTCPHandler(socketserver.BaseRequestHandler):

    def handle(self):
        while True:
            try:
                self.data = self.request.recv(1024).strip()
                print("{} wrote：".format(self.client_address[0]))
                print(self.data)
                self.request.send(self.data.upper())
            except ConnectionResetError as e:
                print("Err：", e)
                break

if __name__ == "__main__":
    HOST, PORT = "localhost", 6970

    server = socketserver.ThreadingTCPServer((HOST, PORT), MyTCPHandler)    #线程化
    # server = socketserver.ForkingTCPServer((HOST, PORT), MyTCPHandler)    #进程化
    server.serve_forever()
```
