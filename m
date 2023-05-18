Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00925707B7D
	for <lists+linux-scsi@lfdr.de>; Thu, 18 May 2023 09:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjERH7Z (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 18 May 2023 03:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjERH7K (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 18 May 2023 03:59:10 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1B42696
        for <linux-scsi@vger.kernel.org>; Thu, 18 May 2023 00:59:09 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I7GwSm003576
        for <linux-scsi@vger.kernel.org>; Thu, 18 May 2023 00:59:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=O/tsimA+DXuNNZ7GNg4hFuClc73p2oytq70CFw2IPmc=;
 b=SVkoq238M+/Jmx3qMg8RxuwDQq1sJTIErQuunxpfGm8PbuROuk46UWcy3g5dV88JsKI5
 eic3k1d3nkl7I2AoLIpcZXpXuLyeEG1rZ3cK56zTbIHnG9H+FAi9llI5RH5IVtIDb3w7
 tJc3pji80Nyoq2iY1Rmp2NQQnhLGxanyIhe6Qs194L/eSM8euHC/7IT1aqz/CCXtcpVM
 ZFHjXXXR47GvILnIR1y1AA1EcJPWD66qUoDfpqsC0j7Me/5/1z+lQDA8JkBRYowUTgsp
 1Gqfmr0Bwl6TtlDc0hGQubxvRH+9xTuUgRtyvyAq45YfBFjIeEejNtyfO6Cr2r38gG5y rA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3qmyexb9h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Thu, 18 May 2023 00:59:08 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 18 May
 2023 00:59:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 18 May 2023 00:59:06 -0700
Received: from localhost.marvell.com (unknown [10.30.46.195])
        by maili.marvell.com (Postfix) with ESMTP id 71D5D3F7055;
        Thu, 18 May 2023 00:59:04 -0700 (PDT)
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>, <bhazarika@marvell.com>,
        <agurumurthy@marvell.com>, <sdeodhar@marvell.com>
Subject: [PATCH 8/8] qla2xxx: Update version to 10.02.08.400-k
Date:   Thu, 18 May 2023 13:28:41 +0530
Message-ID: <20230518075841.40363-9-njavali@marvell.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20230518075841.40363-1-njavali@marvell.com>
References: <20230518075841.40363-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: R-0ik_EMq_97NEY9uGCIjwRu2Oo4UhOu
X-Proofpoint-ORIG-GUID: R-0ik_EMq_97NEY9uGCIjwRu2Oo4UhOu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_05,2023-05-17_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_version.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_version.h b/drivers/scsi/qla2xxx/qla_version.h
index 4d6f06fb156b..e3771923b0d7 100644
--- a/drivers/scsi/qla2xxx/qla_version.h
+++ b/drivers/scsi/qla2xxx/qla_version.h
@@ -6,9 +6,9 @@
 /*
  * Driver version
  */
-#define QLA2XXX_VERSION      "10.02.08.300-k"
+#define QLA2XXX_VERSION      "10.02.08.400-k"
 
 #define QLA_DRIVER_MAJOR_VER	10
 #define QLA_DRIVER_MINOR_VER	2
 #define QLA_DRIVER_PATCH_VER	8
-#define QLA_DRIVER_BETA_VER	300
+#define QLA_DRIVER_BETA_VER	400
-- 
2.23.1

