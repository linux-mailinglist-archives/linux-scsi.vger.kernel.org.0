Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59769646DF7
	for <lists+linux-scsi@lfdr.de>; Thu,  8 Dec 2022 12:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiLHLDw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 8 Dec 2022 06:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiLHLCx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 8 Dec 2022 06:02:53 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3865BD66;
        Thu,  8 Dec 2022 03:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670497276; x=1702033276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fkMDbHJKptb+eHoWQREDqIKMzmlWlbmdh50ygb3ZD+w=;
  b=dRQVTaZ1EesjFjoqAvjNVXAcoEJcGbbNd4DeburTqEBi7mkbfgiRgcku
   nEvumr1j+0lUiZbWAyJ3fix8kzw3wcx04I6lXDywroE4y13Q3jta2EZjy
   sczA2yCilm+VwaqvGJ9oM2vIJaW5X3p4aReOSentsqIzQLoLS5qLgMwux
   lvx08tV+Egsn261frgZFXMPdokuzZJhUJLOTWRLiFxzk0BU/j4BlCxvyv
   UibxkFbOnd7ulFs1yfZGidiE7duMv25c7s+2W0Vjv6qIEbM58fohJvwym
   udu6ISPCYJXOxPHOzcHWVv5m4jEo949FrY+DN/tkXk79koZI99ljIgDml
   A==;
X-IronPort-AV: E=Sophos;i="5.96,227,1665417600"; 
   d="scan'208";a="223333401"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Dec 2022 19:01:16 +0800
IronPort-SDR: ZBokXB94yfwe0hU26qR8hBoBhrFxVNfibaMDPzL4Vh98DYJNcfFdK4ZEH6RgvwpXc3HvnUQJCZ
 PkaTXoBLpVSwmGZtrCTcgEZXcG1JwSLkSPPjHufmQQKjNRmae4r2iuVs4qzwUgRIsIMSSbvgsS
 tSgSwNPdwfqxw504l8eu5AxAr2A3St+pEt6YHrfvLXxtuE1ziK1fd+C5kY3CJuZc6cNw4Wj//0
 ZemBaD/rwxy2D6UXNDfozBbUKq0A97FneXm21yu/fMRQ6YTz/HLba2mqYdEzoMnHK2a1Nax+V1
 nDk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2022 02:14:01 -0800
IronPort-SDR: 5f6iq0uF0+5KUFxVzbvJEOSn9BUHltZIQiA9/o3Hata+JGC6s24sTmVidgNLX59xP3rIMtb9U7
 SdudTsfEIyb+AFKwgJOPHN0cRgzalM2I/lKviYg/TlPZTIwQf58FLmc6Af8pTWEzrsIavN+qjT
 BOxDuNpg7zmkPzcoQCXGravX/odHCINJ6PwTYu+qCs9vHlf4HP1k22r507Y6MImlTI/SGyPVpp
 Ua+RY465dfudAyz2VgzkYQE3VtZgU+ejyZYB5oacRwMaX8CuPbkCFFYDkbwLwbDYXDxSuxujc2
 BV8=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO x1-carbon.cphwdc) ([10.200.210.81])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Dec 2022 03:01:15 -0800
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 14/25] block: introduce duration-limits priority class
Date:   Thu,  8 Dec 2022 11:59:30 +0100
Message-Id: <20221208105947.2399894-15-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208105947.2399894-1-niklas.cassel@wdc.com>
References: <20221208105947.2399894-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Introduce the IOPRIO_CLASS_DL priority class to indicate that IOs should
be executed using duration-limits targets. The duration target to apply
to a command is indicated using the priority level. Up to 8 levels are
supported, with level 0 indiating "no limit".

This priority class has effect only if the target device supports the
command duration limits feature and this feature is enabled by the user.
In BFQ and mq-deadline, all requests with this new priority class are
handled using the highest priority class RT and priority level 0.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 block/bfq-iosched.c         | 10 ++++++++++
 block/blk-ioprio.c          |  3 +++
 block/ioprio.c              |  3 ++-
 block/mq-deadline.c         |  1 +
 include/linux/ioprio.h      |  2 +-
 include/uapi/linux/ioprio.h |  7 +++++++
 6 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index a72304c728fc..62cf7fa7e0cf 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5384,6 +5384,14 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
 		bfqq->new_ioprio_class = IOPRIO_CLASS_IDLE;
 		bfqq->new_ioprio = 7;
 		break;
+	case IOPRIO_CLASS_DL:
+		/*
+		 * For the duration-limits class, we want the disk to do the
+		 * scheduling. So map all levels to the highest RT level.
+		 */
+		bfqq->new_ioprio = 0;
+		bfqq->new_ioprio_class = IOPRIO_CLASS_RT;
+		break;
 	}
 
 	if (bfqq->new_ioprio >= IOPRIO_NR_LEVELS) {
@@ -5510,6 +5518,8 @@ static struct bfq_queue **bfq_async_queue_prio(struct bfq_data *bfqd,
 		return &bfqg->async_bfqq[1][ioprio];
 	case IOPRIO_CLASS_IDLE:
 		return &bfqg->async_idle_bfqq;
+	case IOPRIO_CLASS_DL:
+		return &bfqg->async_bfqq[0][0];
 	default:
 		return NULL;
 	}
diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 8bb6b8eba4ce..dfb5c3f447f4 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -27,6 +27,7 @@
  * @POLICY_RESTRICT_TO_BE: modify IOPRIO_CLASS_NONE and IOPRIO_CLASS_RT into
  *		IOPRIO_CLASS_BE.
  * @POLICY_ALL_TO_IDLE: change the I/O priority class into IOPRIO_CLASS_IDLE.
+ * @POLICY_ALL_TO_DL: change the I/O priority class into IOPRIO_CLASS_DL.
  *
  * See also <linux/ioprio.h>.
  */
@@ -35,6 +36,7 @@ enum prio_policy {
 	POLICY_NONE_TO_RT	= 1,
 	POLICY_RESTRICT_TO_BE	= 2,
 	POLICY_ALL_TO_IDLE	= 3,
+	POLICY_ALL_TO_DL	= 4,
 };
 
 static const char *policy_name[] = {
@@ -42,6 +44,7 @@ static const char *policy_name[] = {
 	[POLICY_NONE_TO_RT]	= "none-to-rt",
 	[POLICY_RESTRICT_TO_BE]	= "restrict-to-be",
 	[POLICY_ALL_TO_IDLE]	= "idle",
+	[POLICY_ALL_TO_DL]	= "duration-limits",
 };
 
 static struct blkcg_policy ioprio_policy;
diff --git a/block/ioprio.c b/block/ioprio.c
index 32a456b45804..1b3a9da82597 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -37,6 +37,7 @@ int ioprio_check_cap(int ioprio)
 
 	switch (class) {
 		case IOPRIO_CLASS_RT:
+		case IOPRIO_CLASS_DL:
 			/*
 			 * Originally this only checked for CAP_SYS_ADMIN,
 			 * which was implicitly allowed for pid 0 by security
@@ -47,7 +48,7 @@ int ioprio_check_cap(int ioprio)
 			if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_NICE))
 				return -EPERM;
 			fallthrough;
-			/* rt has prio field too */
+			/* RT and DL have prio field too */
 		case IOPRIO_CLASS_BE:
 			if (data >= IOPRIO_NR_LEVELS || data < 0)
 				return -EINVAL;
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f10c2a0d18d4..526d0ea4dbf9 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -113,6 +113,7 @@ static const enum dd_prio ioprio_class_to_prio[] = {
 	[IOPRIO_CLASS_RT]	= DD_RT_PRIO,
 	[IOPRIO_CLASS_BE]	= DD_BE_PRIO,
 	[IOPRIO_CLASS_IDLE]	= DD_IDLE_PRIO,
+	[IOPRIO_CLASS_DL]	= DD_RT_PRIO,
 };
 
 static inline struct rb_root *
diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index 7578d4f6a969..2f3fc2fbd668 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -20,7 +20,7 @@ static inline bool ioprio_valid(unsigned short ioprio)
 {
 	unsigned short class = IOPRIO_PRIO_CLASS(ioprio);
 
-	return class > IOPRIO_CLASS_NONE && class <= IOPRIO_CLASS_IDLE;
+	return class > IOPRIO_CLASS_NONE && class <= IOPRIO_CLASS_DL;
 }
 
 /*
diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index f70f2596a6bf..15908b9e9d8c 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -29,6 +29,7 @@ enum {
 	IOPRIO_CLASS_RT,
 	IOPRIO_CLASS_BE,
 	IOPRIO_CLASS_IDLE,
+	IOPRIO_CLASS_DL,
 };
 
 /*
@@ -37,6 +38,12 @@ enum {
 #define IOPRIO_NR_LEVELS	8
 #define IOPRIO_BE_NR		IOPRIO_NR_LEVELS
 
+/*
+ * The Duration limits class allows 8 levels: level 0 for "no limit" and levels
+ * 1 to 7, each corresponding to a read or write limit descriptor.
+ */
+#define IOPRIO_DL_NR_LEVELS	8
+
 enum {
 	IOPRIO_WHO_PROCESS = 1,
 	IOPRIO_WHO_PGRP,
-- 
2.38.1

