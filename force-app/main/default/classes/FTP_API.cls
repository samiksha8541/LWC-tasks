public class FTP_API {
    
    public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;
    
    public static void getFileFromFTPServer(){
        request = new HttpRequest();
        request.setHeader('ftp-host', 'ssh.strato.de');
        request.setHeader('username', 'sftp_AboData@nextcloudsolution.de');
       	request.setHeader('password', 'BJG1xrp!cax3uqg-ywh	');
       	request.setHeader('port', '22');
       	request.setHeader('Content-Type', 'application/json');
        request.setHeader('ftp-type', 'SFTP');
       	request.setMethod('GET');
        request.setEndpoint('https://www.ftp-api.com/ftp/download');
        request.setTimeout(5000);
        response = http.send(request); 

        System.debug(response.getBody());
        
    }

}