Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC4350497
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jun 2019 10:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfFXIa0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 04:30:26 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:26786 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726612AbfFXIaZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 24 Jun 2019 04:30:25 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5O8UJtH025749
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jun 2019 01:30:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=PzzMHQDckej4ZZU5dwQ27oJhHYNqec72OO2R6ztJi3c=;
 b=GWkI3IgjxZU9eKuqO+G3c57U1ftYQrQZfYzNVJKwkEtNrsfUUKvleYntIun12JOYUbPN
 yMRcgbk8EilhkmitGC2PHMYjzuZMiicJ6rWQPEpCc8LRsr8WnPAY8oJBs1hBLc23s+g9
 LJqebRy8+asPsMrEuSKN4rHfyiV2+kQoLMZ7HD7OPN6WI3OL5rPkxvAuokto3B5YEdZ8
 yhOlz0pvpn7XQNFZEMcd+kqVrFC1gzTU11rniGVFjst90LdJo9tJj8ill8FFoUUWOZtt
 ZshdwJYWmk2I4lbQQeQHHhwC5ALBiGL+d49+h4Xz5/gaoZn40GjU+cCq03qy9J79KlM2 8Q== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t9kujdw8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jun 2019 01:30:22 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 01:30:20 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 24 Jun 2019 01:30:20 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 507F33F7041;
        Mon, 24 Jun 2019 01:30:20 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x5O8UK9Z023243;
        Mon, 24 Jun 2019 01:30:20 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x5O8UKgC023242;
        Mon, 24 Jun 2019 01:30:20 -0700
From:   Saurav Kashyap <skashyap@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <gbasrur@marvell.com>, <svernekar@marvell.com>,
        <linux-scsi@vger.kernel.org>
Subject: [PATCH 6/6] bnx2fc: Update the driver version to 2.12.10.
Date:   Mon, 24 Jun 2019 01:30:00 -0700
Message-ID: <20190624083000.23074-7-skashyap@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190624083000.23074-1-skashyap@marvell.com>
References: <20190624083000.23074-1-skashyap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_06:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Update the driver version to 2.12.10.

Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
---
 drivers/scsi/bnx2fc/bnx2fc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc.h b/drivers/scsi/bnx2fc/bnx2fc.h
index 170abe9..3b84db8 100644
--- a/drivers/scsi/bnx2fc/bnx2fc.h
+++ b/drivers/scsi/bnx2fc/bnx2fc.h
@@ -66,7 +66,7 @@
 #include "bnx2fc_constants.h"
 
 #define BNX2FC_NAME		"bnx2fc"
-#define BNX2FC_VERSION		"2.11.8"
+#define BNX2FC_VERSION		"2.12.10"
 
 #define PFX			"bnx2fc: "
 
-- 
1.8.3.1

