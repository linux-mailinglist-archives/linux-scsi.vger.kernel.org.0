Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28CDC5D96B
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Jul 2019 02:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfGCAnA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 2 Jul 2019 20:43:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726736AbfGCAnA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 2 Jul 2019 20:43:00 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x62L1ZO2007995
        for <linux-scsi@vger.kernel.org>; Tue, 2 Jul 2019 17:02:09 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tgax7g97k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Tue, 02 Jul 2019 17:02:09 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-scsi@vger.kernel.org> from <bblock@linux.ibm.com>;
        Tue, 2 Jul 2019 22:02:07 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Jul 2019 22:02:06 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x62L24fV59965592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Jul 2019 21:02:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58BE2AE051;
        Tue,  2 Jul 2019 21:02:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4486BAE045;
        Tue,  2 Jul 2019 21:02:04 +0000 (GMT)
Received: from t480-pf1aa2c2 (unknown [9.145.93.34])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  2 Jul 2019 21:02:04 +0000 (GMT)
Received: from bblock by t480-pf1aa2c2 with local (Exim 4.92)
        (envelope-from <bblock@linux.ibm.com>)
        id 1hiPud-0007zj-Fx; Tue, 02 Jul 2019 23:02:03 +0200
From:   Benjamin Block <bblock@linux.ibm.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Benjamin Block <bblock@linux.ibm.com>,
        Steffen Maier <maier@linux.ibm.com>,
        Fedor Loshakov <loshakov@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-scsi@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 3/3] zfcp: fix GCC compiler warning emitted with -Wmaybe-uninitialized
Date:   Tue,  2 Jul 2019 23:02:02 +0200
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1562098940.git.bblock@linux.ibm.com>
References: <cover.1562098940.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19070221-0008-0000-0000-000002F93B9E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070221-0009-0000-0000-00002266865D
Message-Id: <8d531fd6170e5dbc4908bddda28f8f80f7312019.1562098940.git.bblock@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=946 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907020233
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

GCC v9 emits this warning:
      CC      drivers/s390/scsi/zfcp_erp.o
    drivers/s390/scsi/zfcp_erp.c: In function 'zfcp_erp_action_enqueue':
    drivers/s390/scsi/zfcp_erp.c:217:26: warning: 'erp_action' may be used uninitialized in this function [-Wmaybe-uninitialized]
      217 |  struct zfcp_erp_action *erp_action;
          |                          ^~~~~~~~~~

This is a possible false positive case, as also documented in the GCC
documentations:
    https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wmaybe-uninitialized

The actual code-sequence is like this:
    Various callers can invoke the function below with the argument "want"
    being one of:
    ZFCP_ERP_ACTION_REOPEN_ADAPTER,
    ZFCP_ERP_ACTION_REOPEN_PORT_FORCED,
    ZFCP_ERP_ACTION_REOPEN_PORT, or
    ZFCP_ERP_ACTION_REOPEN_LUN.

    zfcp_erp_action_enqueue(want, ...)
        ...
        need = zfcp_erp_required_act(want, ...)
            need = want
            ...
            maybe: need = ZFCP_ERP_ACTION_REOPEN_PORT
            maybe: need = ZFCP_ERP_ACTION_REOPEN_ADAPTER
            ...
            return need
        ...
        zfcp_erp_setup_act(need, ...)
            struct zfcp_erp_action *erp_action; // <== line 217
            ...
            switch(need) {
            case ZFCP_ERP_ACTION_REOPEN_LUN:
                    ...
                    erp_action = &zfcp_sdev->erp_action;
                    WARN_ON_ONCE(erp_action->port != port); // <== access
                    ...
                    break;
            case ZFCP_ERP_ACTION_REOPEN_PORT:
            case ZFCP_ERP_ACTION_REOPEN_PORT_FORCED:
                    ...
                    erp_action = &port->erp_action;
                    WARN_ON_ONCE(erp_action->port != port); // <== access
                    ...
                    break;
            case ZFCP_ERP_ACTION_REOPEN_ADAPTER:
                    ...
                    erp_action = &adapter->erp_action;
                    WARN_ON_ONCE(erp_action->port != NULL); // <== access
                    ...
                    break;
            }
            ...
            WARN_ON_ONCE(erp_action->adapter != adapter); // <== access

When zfcp_erp_setup_act() is called, 'need' will never be anything else
than one of the 4 possible enumeration-names that are used in the
switch-case, and 'erp_action' is initialized for every one of them,
before it is used. Thus the warning is a false positive, as documented.

We introduce the extra if{} in the beginning to create an extra code-flow,
so the compiler can be convinced that the switch-case will never see any
other value.

BUG_ON()/BUG() is intentionally not used to not crash anything, should
this ever happen anyway - right now it's impossible, as argued above; and
it doesn't introduce a 'default:' switch-case to retain warnings should
'enum zfcp_erp_act_type' ever be extended and no explicit case be
introduced. See also v5.0 commit 399b6c8bc9f7 ("scsi: zfcp: drop old
default switch case which might paper over missing case").

Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_erp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
index e8fc28dba8df..96f0d34e9459 100644
--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
 #include <linux/kthread.h>
+#include <linux/bug.h>
 #include "zfcp_ext.h"
 #include "zfcp_reqlist.h"
 
@@ -217,6 +218,12 @@ static struct zfcp_erp_action *zfcp_erp_setup_act(enum zfcp_erp_act_type need,
 	struct zfcp_erp_action *erp_action;
 	struct zfcp_scsi_dev *zfcp_sdev;
 
+	if (WARN_ON_ONCE(need != ZFCP_ERP_ACTION_REOPEN_LUN &&
+			 need != ZFCP_ERP_ACTION_REOPEN_PORT &&
+			 need != ZFCP_ERP_ACTION_REOPEN_PORT_FORCED &&
+			 need != ZFCP_ERP_ACTION_REOPEN_ADAPTER))
+		return NULL;
+
 	switch (need) {
 	case ZFCP_ERP_ACTION_REOPEN_LUN:
 		zfcp_sdev = sdev_to_zfcp(sdev);
-- 
2.17.1

