Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04CF156660
	for <lists+linux-scsi@lfdr.de>; Wed, 26 Jun 2019 12:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfFZKM4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Jun 2019 06:12:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49252 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfFZKM4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 26 Jun 2019 06:12:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QA8Yvr072598;
        Wed, 26 Jun 2019 10:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=AN9iBdCTp++0R1aM0KHljpCXnwdkIag9kwI7UnIdRQA=;
 b=G0DCSynVQYxnpeXuOjXsrOYCgfuhTsGxBTQAZ8MaUreGkC9qFeWbeOWiYD1fklbWHStj
 zA+upOPnG5sMAirdEw4A1wV76CjD86cFnIupOI6rqgSkem/szQKXyWwpDNEah1d3hLWB
 ZbqU1+lUeQf2tRG4SN+OIybAmCrpjQnE6bFvl7J2RVeX9R9hPIl6MUuVwIfPz1cei5n4
 WTkOYA3AUos7PHGJYjM2n4Ow3uaqeV4kOCZpYlBN4S2Bhs/qOQVarEpipP5MR8psccOJ
 VF0OHLU5gvNfiqk+AjvpAu+7hzfDRviY3Nxgh1l9WER76/pHWy6ldeUrp3sYXNUrXPk/ TQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2t9brt9f0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 10:12:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QACYk3047729;
        Wed, 26 Jun 2019 10:12:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2t99f4crj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 10:12:52 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5QACpBL006491;
        Wed, 26 Jun 2019 10:12:51 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 03:12:50 -0700
Date:   Wed, 26 Jun 2019 13:12:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>
Cc:     Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] scsi: mpt3sas: clean up a sizeof()
Message-ID: <20190626101243.GF3242@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=991
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260122
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch is just a cleanup and doesn't change run time because both
sizeof EVENT and SCSI are 84 bytes.  But this is clearly a cut and paste
error and the SCSI struct was intended.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index d4ecfbbe738c..06a901ed743c 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -3280,7 +3280,7 @@ diag_trigger_scsi_store(struct device *cdev,
 	spin_lock_irqsave(&ioc->diag_trigger_lock, flags);
 	sz = min(sizeof(struct SL_WH_SCSI_TRIGGERS_T), count);
 	memset(&ioc->diag_trigger_scsi, 0,
-	    sizeof(struct SL_WH_EVENT_TRIGGERS_T));
+	    sizeof(struct SL_WH_SCSI_TRIGGERS_T));
 	memcpy(&ioc->diag_trigger_scsi, buf, sz);
 	if (ioc->diag_trigger_scsi.ValidEntries > NUM_VALID_ENTRIES)
 		ioc->diag_trigger_scsi.ValidEntries = NUM_VALID_ENTRIES;
-- 
2.20.1

