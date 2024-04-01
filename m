Return-Path: <linux-scsi+bounces-3851-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F332589382D
	for <lists+linux-scsi@lfdr.de>; Mon,  1 Apr 2024 08:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A192B1F2127E
	for <lists+linux-scsi@lfdr.de>; Mon,  1 Apr 2024 06:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75D98F5B;
	Mon,  1 Apr 2024 06:10:46 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx2.usergate.com (mx2.usergate.com [46.229.79.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8853BE;
	Mon,  1 Apr 2024 06:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.229.79.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711951846; cv=none; b=mSB59Kp0HB6d9gJsUog+0SoEKxEiptkLtMCn9yZVQOIGR8aDft2qsCNeJxZDjhdtNGNlUxSaT8o/y6+9KlCBy5mqzL3YEhQVErLwFwH04YtH2/ACJaPz0d3eyMQDVr6RGtT1IrM9e5zwXLpYOrJZWJKt5Szi17WqNFefEraP8Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711951846; c=relaxed/simple;
	bh=+UHLdCQTMrUw8WO10zf7gQvU/OLD5joucmE9A0+3Iog=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=envy35H0yujQsLTA6BJbxVcIgk/UkI05KGjIVXKvUN9PK+hs/hpgrmHoZBmE2UbGqW9JLd65XN2dEJ6YDgqJO3m/Xrg3jYwH9m7cJkpnI8Yyyr+lnzFDpYMepm13UbrME2vKvDBQ0MvseJIdFdcax61CnbtE6U2K+HFrgHnIUMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usergate.com; spf=pass smtp.mailfrom=usergate.com; arc=none smtp.client-ip=46.229.79.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usergate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usergate.com
Received: from mail.usergate.com[192.168.90.36] by mx2.usergate.com with ESMTP id
	 8FF7B9684B1C4A189249FF167EC005ED; Mon, 1 Apr 2024 13:10:26 +0700
From: Aleksandr Aprelkov <aaprelkov@usergate.com>
To: Hannes Reinecke <hare@suse.com>
CC: Aleksandr Aprelkov <aaprelkov@usergate.com>,"James E.J. Bottomley" <jejb@linux.ibm.com>,"Martin K. Petersen" <martin.petersen@oracle.com>,<linux-scsi@vger.kernel.org>,<linux-kernel@vger.kernel.org>,<lvc-project@linuxtesting.org>
Subject: [PATCH] scsi: aic79xx: add scb NULL check in ahd_handle_msg_reject()
Date: Mon, 1 Apr 2024 13:10:09 +0700
Message-ID: <20240401061010.589751-1-aaprelkov@usergate.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ESLSRV-EXCH-01.esafeline.com (192.168.90.36) To
 nsk02-mbx01.esafeline.com (10.10.1.35)
X-Message-Id: 216EAD62768046DBA990E016335F1F2F
X-MailFileId: 71D8BFED459B4CA494BB17C93467D2DF

If ahd_lookup_scb() returns NULL and ahd_sent_msg() checks are false,
then NULL pointer dereference happens

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Aleksandr Aprelkov <aaprelkov@usergate.com>
---
 drivers/scsi/aic7xxx/aic79xx_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
index 3e3100dbfda3..9e0fafa12e87 100644
--- a/drivers/scsi/aic7xxx/aic79xx_core.c
+++ b/drivers/scsi/aic7xxx/aic79xx_core.c
@@ -5577,7 +5577,7 @@ ahd_handle_msg_reject(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 		       "Using asynchronous transfers\n",
 		       ahd_name(ahd), devinfo->channel,
 		       devinfo->target, devinfo->lun);
-	} else if ((scb->hscb->control & SIMPLE_QUEUE_TAG) != 0) {
+	} else if (scb && (scb->hscb->control & SIMPLE_QUEUE_TAG) != 0) {
 		int tag_type;
 		int mask;
 
-- 
2.34.1


