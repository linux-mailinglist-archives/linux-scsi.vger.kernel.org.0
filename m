Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6554176EA5
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 18:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfGZQK2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 12:10:28 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:13738 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726871AbfGZQK2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 26 Jul 2019 12:10:28 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6QG6wSE025944;
        Fri, 26 Jul 2019 09:08:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=l0fa2yfkakNglHCsvR+g3Vvmi4b6Pb/o68AkmpvjeDU=;
 b=DDNsnnpI/eclT7bWyeGGoQXOKjBHjIQNc8Sp7uYyb5DluSdvO6ek52yJFlQRPM5pQwz1
 DrSoW0uYd4c36wGABvxTfSYjUtXkzZ/QCpWM4GxElDG6qudKtuYonq6PR0sq+MLkD6RI
 iBQOEZoJvRlTsl48axipNKTovMh8mv9UHEibEKyGIW5PfEoJEt4FOl2giEy+CAkFWgjM
 bsi/s145qCg/kjt2tLdJOJPy391oRJnXXtUM0MZl6ZuLCpVVfvG3oPr0VmslrRYyCFa9
 8hVuM1hs/ZRq0bJH8pHkFq3e2CDfmLDoKfJnahLvNutPU9Ym3l/HWksTODvYA5L8ahAR 1A== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2tx6256xdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 09:08:27 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 26 Jul
 2019 09:08:25 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 26 Jul 2019 09:08:25 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 8799E3F703F;
        Fri, 26 Jul 2019 09:08:25 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x6QG8PBO025790;
        Fri, 26 Jul 2019 09:08:25 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x6QG8PBL025789;
        Fri, 26 Jul 2019 09:08:25 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 15/15] qla2xxx: Update driver version to 10.01.00.18-k
Date:   Fri, 26 Jul 2019 09:07:40 -0700
Message-ID: <20190726160740.25687-16-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190726160740.25687-1-hmadhani@marvell.com>
References: <20190726160740.25687-1-hmadhani@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-26_11:2019-07-26,2019-07-26 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_version.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_version.h b/drivers/scsi/qla2xxx/qla_version.h
index cd6bdf71e533..0833546a1b43 100644
--- a/drivers/scsi/qla2xxx/qla_version.h
+++ b/drivers/scsi/qla2xxx/qla_version.h
@@ -7,7 +7,7 @@
 /*
  * Driver version
  */
-#define QLA2XXX_VERSION      "10.01.00.16-k"
+#define QLA2XXX_VERSION      "10.01.00.18-k"
 
 #define QLA_DRIVER_MAJOR_VER	10
 #define QLA_DRIVER_MINOR_VER	1
-- 
2.12.0

