public class EmailCSVReport{
    
    public string developerName;
    public string emailToAddress;
    public string emailFromAdress;
    public string subject;
    private Messaging.SingleEmailMessage emailMessage;
    
    public EmailCSVReport(String name) {
        developerName = name;
    }

    public boolean send(){
        boolean sent = true;
        try{
                createEmailMessage();
            if (!Test.IsRunningTest()){
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { emailMessage });
            }
         
        } catch (Exception e){
            if (!Test.IsRunningTest()){
                Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
                String[] toAddresses = new String[] {emailFromAdress};
                mail.setToAddresses(toAddresses);
                mail.setReplyTo(emailFromAdress);
                mail.setSenderDisplayName('salesforce APEX error message');
                mail.setSubject('Error from Org : ' + UserInfo.getOrganizationName());
                mail.setPlainTextBody(e.getMessage());
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            }
            sent = false;
        }
        return sent;
    }

    private void createEmailMessage(){
        emailMessage = new Messaging.SingleEmailMessage();
        emailMessage.setReplyTo(emailToAddress);
        emailMessage.setSenderDisplayName(emailFromAdress); 
        emailMessage.setToAddresses(new List<String>{emailToAddress});
        emailMessage.setSubject(subject);
        emailMessage.setUseSignature(false);
        string msgText = 'attached is a generated report, contact '+emailFromAdress + ' if you no longer wish to receive';
        emailMessage.setHtmlBody(msgText);
        
        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        attachment.setContentType('text/csv');
        attachment.setFileName('report.csv');
        attachment.setInline(false);
        string csv = getReportAsCSV(developerName);
        attachment.Body = blob.valueOf(csv);
        Messaging.EmailFileAttachment [] attachmentList = new List<Messaging.EmailFileAttachment> () ;
        attachmentList.add(attachment);
        emailMessage.setFileAttachments(attachmentList);
    }

    private string getReportAsCSV(string developerName){
        // Get the report ID
        List <Report> reportList = [SELECT Id,DeveloperName FROM Report where DeveloperName = :developerName];
        string reportId = (String)reportList.get(0).get('Id');
        
        Reports.ReportMetadata reportMetadata = Reports.ReportManager.describeReport(reportId).getReportMetadata();
        Reports.ReportResults reportResults = Reports.ReportManager.runReport(reportId,true);
        Reports.ReportFactWithDetails factWithDetails = (Reports.ReportFactWithDetails) reportResults.getFactMap().get('T!T');
        string csv = '';

        for (Reports.ReportDetailRow row : factWithDetails.getRows()) {
            for (Reports.ReportDataCell cell : row.getDataCells()) {
                csv = csv + cell.getLabel() + ',';
            
            }
           csv = csv + '\n';  
        }  
        return csv;
   }
}