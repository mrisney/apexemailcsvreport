# Simple Salesforce Utility to email CSV Reports
APEX class and Job used in conjuction with the APEX Scheduler to Email Reports as CSV

Go to Developer Cponsole, get a list of reports from a SOQL (Saleforce Object Query Language)

```javascript 
'SELECT Id, DeveloperName FROM Report'
```

This will give you a list of reports that are in production.
There are many, so I wrote this utility to be general. You can email any report in CSV
and have it sent to anyone, anytime, you can disable it in the APEX Scheduled jobs
I scripted this, to use Salesforce CRON's format, which is slightly differnt than standard
UNIX CRON, I have attached an image to show how to use the differnt Salesforce CRON expressions.

![ScreenShot](https://raw.github.com/mrisney/apexemailcsvreport/master/screenshots/SaleforceCron.png)

For example, suppose I want to send a CSV report of all Users M-F at 11:20 in the morning to myself.
Here is how I would do it (paste the following into Developer Console - all properties are mandatory)
in the "Debug">"Open Execute Annoymous Window" or CTRL+E

```javascript 
// Fires Mon-Friday at 11:20 in the morning
string cronString = '0 20 11 ? * MON-FRI';
EmailCSVReportJob emailReportJob = new EmailCSVReportJob();
emailReportJob.emailToAddress = 'xxx@xxxxx.com';
emailReportJob.emailFromAdress = 'xxx@xxxx.com';
emailReportJob.subject = 'test automated user report';
emailReportJob.name = 'InAuth_Users';

system.schedule('Email InauthUser Report Job', cronString, emailReportJob);`
```
![ScreenShot](https://raw.github.com/mrisney/apexemailcsvreport/tree/master/screenshots/devconsole.screenshot.png)

To disable the job, goto setup, look for All scheduled jobs, there should be an entry that was entered 
by you, the adminsitrator, or developr, you can modify or delete it.

![ScreenShot](https://raw.github.com/mrisney/apexemailcsvreport/master/screenshots/schedjobs.screenshot.png)

Delete or modiy the frequency of the scheduled job.

![ScreenShot](https://raw.github.com/mrisney/apexemailcsvreport/master/screenshots/modify.schedjob.screenshot.png)








