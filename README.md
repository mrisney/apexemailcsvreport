# Simple Salesforce Utility to email CSV Reports
An APEX class used in conjuction with the APEX Scheduler to Email Reports as CSV


*3 APEX Classes*

EmailCSVReport
EmailCSVReportJob
EmailCSVReportTest

*Report by DeveloperName*

Go to Developer Cponsole, get a list of reports from a SOQL (Saleforce Object Query Language)

'SELECT Id, DeveloperName FROM Report'

This will give you a list of reports that are in production.
There are many, so I wrote this utility to be general. You can email any report in CSV
and have it sent to anyone, anytime, you can disable it in the APEX Scheduled jobs
I scripted this, to use Salesforce CRON's format, which is slightly differnt than standard
UNIX CRON, I have attached an image to show how to use the differnt Salesforce CRON expressions.

![ScreenShot](https://raw.github.com/mrisney/apexemailcsvreport/master/SaleforceCron.png)

For example, suppose I want to send a CSV report M-F at 11:20 in the morning to myself.
Here is how I would do it (paste the following into Developer Console - all properties are mandatory)


```// Fires Mon-Friday at 11:20 in the morning
string cronString = '0 20 11 ? * MON-FRI';
EmailCSVReportJob emailReportJob = new EmailCSVReportJob();
emailReportJob.emailToAddress = 'xxx@xxxxx.com';
emailReportJob.emailFromAdress = 'xxx@xxxx.com';
emailReportJob.subject = 'test automated user report';
emailReportJob.name = 'InAuth_Users';

system.schedule('Email InauthUser Report Job', cronString, emailReportJob);```



