<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div id="chart"></div>
<div id="table"></div>
<div id="resources" style="display: none">
    TA_1, TA_2, BA_1, Janrain_1, SVNT_1, DEV_1
</div>
<pre id="wbs" style="display: none">
1:Align User Data
    Align with Renee |2|TA
    Align with DAT |2|TA
    Modify flow (User Data) |1|TA

    t1:Sanity Check |1|BA|1

2:Rename registrationCountry in UK
    Communicate intentions with Consent Hub Team |1|TA
    Communicate intentions with M-Connect |1|TA
    Modify flow (registrationForm) |1|TA
    Modify offline integrations (query, insert) |2|DEV
    Perform update of existing users |2|DEV

    t2:Sanity Check |1|BA|2

3:Email verification
    Configure SFMC Email Templates |1|TA
    Configure RTB Handler |1|TA
    Configure Flow (screen) |1|TA
    Obtain email template from the business  |5|TA

    t3:Sanity Check |1|BA|3

4:Postlogin screens
    Make the full set of screens in all the flows |2|BA, Janrain
    Enable desired screens |1|TA
    Translations |2|BA

    t4:Sanity Check |1|BA|4

5:FR Flow merge
    Analyze differences between flows |2|TA
    Merge flow functionality |3|TA, Janrain
    Prepare FE packages in DIH repo (FRx5) |5|TA, DEV

    t5:Sanity Check |1|BA|5

6:Flow update (default fields, settings, etc.)
    Analyze differences |2|TA, Janrain
    Update TOP6 flows |2|TA, Janrain

    t6:Sanity Check |1|BA|6

7:FE packages in DIH repository
    Regenerate HTML by builder and apply styles |1|TA
    Prepare FE packages in DIH repo (TOP6-FR) |5|TA, DEV

    t7:Sanity Check |1|BA|7

d:Website Deployment (maybe already is in integrated plan?)
    M-Connect |4|TA
    Comuniti |4|TA
    Docvadis |4|TA
    Other |4|TA

    td:Sanity Check |8|BA|d

doc:Documentation (maybe part of blueprint stuff?) |1|TA| t1, t2, t3, t4, t5, t6, t7

Testing (part of integrated plan already) |1|SVNT| t1, t2, t3, t4, t5, t6, t7
</pre>
<script src="https://cdnjs.cloudflare.com/ajax/libs/later/1.2.0/later.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/schedulejs/0.6.3/schedule.js"></script>
<script src="https://cdn.rawgit.com/mihaifm/linq/master/linq.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment-with-locales.min.js"></script>
<!-- <script type="text/javascript" src="https://rawgit.com/uxsoft/WBS/master/wbs.js"></script> -->
<script type="text/javascript" src="wbs.js"></script>