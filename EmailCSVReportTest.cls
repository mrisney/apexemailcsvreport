@isTest
public class EmailCSVReportTest {
    
    public static testMethod void testSendMessage(){
        EmailCSVReport emailCSVReport = new EmailCSVReport('InAuth_Users');
        emailCSVReport.emailToAddress = 'mrisney@inauth.com';
        emailCSVReport.emailFromAdress = 'mrisney@inauth.com';
        emailCSVReport.subject = 'test subject';
        boolean messageConfirmation = emailCSVReport.send();
        System.assertEquals(messageConfirmation, false);
    }
}