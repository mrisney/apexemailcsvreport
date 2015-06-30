global class EmailCSVReportJob implements Schedulable {
    
    public string emailToAddress;
    public string emailFromAdress;
    public string subject;
    public string name;
    
    global void execute(SchedulableContext ctx) {
        EmailCSVReport emailCSVReport = new EmailCSVReport(name);
        emailCSVReport.emailToAddress = emailToAddress;
        emailCSVReport.emailFromAdress = emailFromAdress;
        emailCSVReport.subject = subject;
        emailCSVReport.send();
   }   
}