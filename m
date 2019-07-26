Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BABF75F4D
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 08:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfGZGwX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 02:52:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38460 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfGZGwX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 26 Jul 2019 02:52:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6Q6nOdJ043268;
        Fri, 26 Jul 2019 06:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=1K0qQi1bpToKvOSlF3a/F0j5fbid/OeKQ9Kj/5weLaE=;
 b=I5AZ/8uV0pOb1Ifw7OGmo1/hN+sEYxbRy3HUdOVgjlmLWdeBaKBCayWn3zkf5trsNyz8
 TbFiln6B1RB3bqU1qryh7hywi3u+QHhYGh3G8hyuh+dUKlHgoM0hF82LqjMovCH1uDIE
 5KBsD9S872WQ94zqg7J86IjkzQok8aY2Rj5R1L+9ibxvC3scueiOHmHNpT8msQ3i1JdE
 9T/fTJNBM4bqReaw03wsrOjT+TH/UsoYDdTbMR2azBtZqf7SXq5qgJ0B/wYQkIK+xAHK
 P5ds5n//cYkBLP8CDyCB4EsgyDMhnZZ3FWmBfmjRWQ6IzM5cAJkes0sJCy7Ol7OipnIQ jg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2tx61c8aup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jul 2019 06:52:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6Q6lXW3092078;
        Fri, 26 Jul 2019 06:52:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tycv7jgmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jul 2019 06:52:14 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6Q6qDmQ015449;
        Fri, 26 Jul 2019 06:52:13 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Jul 2019 23:52:12 -0700
Date:   Fri, 26 Jul 2019 09:52:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>
Cc:     Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] scsi: mpt3sas: clean up a couple sizeof() uses
Message-ID: <20190726065205.GA22701@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561558950.3435.2.camel@linux.ibm.com>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9329 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907260088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9329 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907260089
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

There is a copy and paste bug here.  It uses EVENT_TRIGGERS size instead
of SCSI_TRIGGERS size but fortunately both size are 84 bytes so it
doesn't affect runtime.

These days the prefered style is to just say sizeof(object) instead of
sizeof(type) so I have updated the function to the latest style as well.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: Update the style to the 21st Century

 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index d4ecfbbe738c..41c54d4c9451 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -3278,9 +3278,8 @@ diag_trigger_scsi_store(struct device *cdev,
 	ssize_t sz;
 
 	spin_lock_irqsave(&ioc->diag_trigger_lock, flags);
-	sz = min(sizeof(struct SL_WH_SCSI_TRIGGERS_T), count);
-	memset(&ioc->diag_trigger_scsi, 0,
-	    sizeof(struct SL_WH_EVENT_TRIGGERS_T));
+	sz = min(sizeof(ioc->diag_trigger_scsi), count);
+	memset(&ioc->diag_trigger_scsi, 0, sizeof(ioc->diag_trigger_scsi));
 	memcpy(&ioc->diag_trigger_scsi, buf, sz);
 	if (ioc->diag_trigger_scsi.ValidEntries > NUM_VALID_ENTRIES)
 		ioc->diag_trigger_scsi.ValidEntries = NUM_VALID_ENTRIES;
-- 
2.20.1

