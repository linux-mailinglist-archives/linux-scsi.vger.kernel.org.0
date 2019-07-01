Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 932004B364
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Jun 2019 09:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbfFSHwK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 19 Jun 2019 03:52:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46348 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfFSHwK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 19 Jun 2019 03:52:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J7mvt3095007;
        Wed, 19 Jun 2019 07:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=ZqymLuDrO6eYJVDB9tPgYhWtvN/C6n4mryzJzrUy8i8=;
 b=aSxSmNaQ7iyrOCJ/p6YEzp6sXh/qtKUZ3NziJ/5tCp+6xJ9oIeQblCsustXbVJeEnHl7
 eSyVCJp3VxOdkd/STEzkb12KYaj6wS4tJXMgLChIvHA/z6pQmF3yFtnLiNhQmdGNxqk7
 QxB3rrHL8Ai7R2OOob6Gzan/3ypkOX4BmVB55Jy3E90sZt73dBH8uV0J1ciG0seCGpyN
 kepu4BXOwPXztucbalFvHnFVtR4SuRT0vQzO64bf3O7A1jaRINZsizFBxatPpFmjAKKG
 9gRizTdm6PLGQS68pBxY4z8eVpgeM2fNDosYQAVaLmVtih0T08glm770/EnFi0IC2tbs Kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2t78099qua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 07:51:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J7m39b112615;
        Wed, 19 Jun 2019 07:49:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2t77ymx439-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 07:49:26 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5J7nPpv005684;
        Wed, 19 Jun 2019 07:49:25 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Jun 2019 00:49:25 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        pbonzini@redhat.com, stefanha@redhat.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Subject: [PATCH 1/1] scsi: virtio_scsi: remove unused 'affinity_hint_set'
Date:   Wed, 19 Jun 2019 15:52:19 +0800
Message-Id: <1560930739-25692-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190065
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190065
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The 'affinity_hint_set' is not used any longer since
commit 0d9f0a52c8b9 ("virtio_scsi: use virtio IRQ affinity").

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/scsi/virtio_scsi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 13f1b3b..1705398 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -74,9 +74,6 @@ struct virtio_scsi {
 
 	u32 num_queues;
 
-	/* If the affinity hint is set for virtqueues */
-	bool affinity_hint_set;
-
 	struct hlist_node node;
 
 	/* Protected by event_vq lock */
-- 
2.7.4

