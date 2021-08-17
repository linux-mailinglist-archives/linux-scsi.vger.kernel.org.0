Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1226B3EE61D
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Aug 2021 07:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbhHQFOf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Aug 2021 01:14:35 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:30854 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234162AbhHQFO1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 17 Aug 2021 01:14:27 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17GMLCqX012247
        for <linux-scsi@vger.kernel.org>; Mon, 16 Aug 2021 22:13:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=DK28IP58wmj3xFaBRwXT+XKuKuBfFYrdQzl2GDv3ToY=;
 b=EXXYfAIYtgC4C2sOJ+vcVKZybmhBBYaHoYGAhd8HbRRPKH3y0+BKMooDt6BiouC+wY21
 kajA0kaO0/yR+y1SmO4blumVnV50GNqXkI1mgktWAj1RcPo3x2IaikqeKThNDA8SDbkG
 gstVfOylIgA821G+Gs5vKIJwbWdmi5Ap+j8VplQpwiyqz/2yDJmv7az1/WZrv0Xn3vs4
 lorHqnWSJcK6dJOZ1bHyuXMC7lWS1qrXp9dWCb+Lg7lh/TljJr6J9a+I49zgDvwRFw+L
 pa6H9GB3M/voay7IuzARQBAyWBVLuj2pYiy/hDKvO1eOVlNm1Ws3kkxIZ/cRMKwYnNqw iA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 3ag0qxh1v6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Mon, 16 Aug 2021 22:13:54 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 16 Aug
 2021 22:13:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 16 Aug 2021 22:13:52 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id EFB9C3F70A9;
        Mon, 16 Aug 2021 22:13:51 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 17H5Dpf9002560;
        Mon, 16 Aug 2021 22:13:51 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 17H5Dptk002559;
        Mon, 16 Aug 2021 22:13:51 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH 12/12] qla2xxx: Update version to 10.02.06.200-k
Date:   Mon, 16 Aug 2021 22:13:15 -0700
Message-ID: <20210817051315.2477-13-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20210817051315.2477-1-njavali@marvell.com>
References: <20210817051315.2477-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: NtavSiclBN-Bha9vAQfzqBmt4NE6d4r7
X-Proofpoint-GUID: NtavSiclBN-Bha9vAQfzqBmt4NE6d4r7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-17_01,2021-08-16_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_version.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_version.h b/drivers/scsi/qla2xxx/qla_version.h
index 8b0ace50b52f..055040cbef9b 100644
--- a/drivers/scsi/qla2xxx/qla_version.h
+++ b/drivers/scsi/qla2xxx/qla_version.h
@@ -6,9 +6,9 @@
 /*
  * Driver version
  */
-#define QLA2XXX_VERSION      "10.02.06.100-k"
+#define QLA2XXX_VERSION      "10.02.06.200-k"
 
 #define QLA_DRIVER_MAJOR_VER	10
 #define QLA_DRIVER_MINOR_VER	2
 #define QLA_DRIVER_PATCH_VER	6
-#define QLA_DRIVER_BETA_VER	100
+#define QLA_DRIVER_BETA_VER	200
-- 
2.23.1

