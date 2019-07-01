Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B693A5A7C0
	for <lists+linux-scsi@lfdr.de>; Sat, 29 Jun 2019 01:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfF1Xs0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 28 Jun 2019 19:48:26 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:60726 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbfF1Xs0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 28 Jun 2019 19:48:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0D6838EE0F5;
        Fri, 28 Jun 2019 16:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1561765706;
        bh=8TfBUOwrfWPIW8hwVX/RWo8daA0gmzbJ8Erv3ZCUqCc=;
        h=Subject:From:To:Cc:Date:From;
        b=l0lt12s84JjE6WmBrY3R3qhZi5EUect7aahlyIOwAxw7Xv79sLoyBnPiuM0C3scgY
         KdTFWGT1CEtUZicjiM1cR95SbhksJUlIRru1CjV908qs8BkkHcXVB1LmswmDUTrucR
         1Pz6/krxXW9OQNO0k18jiOXYOegAFj/M+mY7jZoU=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IvOhdlC4EP8L; Fri, 28 Jun 2019 16:48:25 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 69B728EE0C7;
        Fri, 28 Jun 2019 16:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1561765705;
        bh=8TfBUOwrfWPIW8hwVX/RWo8daA0gmzbJ8Erv3ZCUqCc=;
        h=Subject:From:To:Cc:Date:From;
        b=H7MKM6/RiP9cM8NbXMApxe7/yrMrJNZhw966+2vWU/FM8/S2SGD3ohTC+NSzjpZw9
         hH2STS3eWZJMM3DJIgwvcMapgo7RaYqrxZPPvzMhGzavrP1FuZHeSXB92JmzfrOKTP
         WzOQNTBamUcgw3J+jQE9b4qFaD6hlpJbXppD8EHU=
Message-ID: <1561765703.5883.12.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.2-rc6
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 28 Jun 2019 16:48:23 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

One simple fix for a driver use after free.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Jan Kara (1):
      scsi: vmw_pscsi: Fix use-after-free in pvscsi_queue_lck()

And the diffstat:

 drivers/scsi/vmw_pvscsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index ecee4b3ff073..377b07b2feeb 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -763,6 +763,7 @@ static int pvscsi_queue_lck(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd
 	struct pvscsi_adapter *adapter = shost_priv(host);
 	struct pvscsi_ctx *ctx;
 	unsigned long flags;
+	unsigned char op;
 
 	spin_lock_irqsave(&adapter->hw_lock, flags);
 
@@ -775,13 +776,14 @@ static int pvscsi_queue_lck(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd
 	}
 
 	cmd->scsi_done = done;
+	op = cmd->cmnd[0];
 
 	dev_dbg(&cmd->device->sdev_gendev,
-		"queued cmd %p, ctx %p, op=%x\n", cmd, ctx, cmd->cmnd[0]);
+		"queued cmd %p, ctx %p, op=%x\n", cmd, ctx, op);
 
 	spin_unlock_irqrestore(&adapter->hw_lock, flags);
 
-	pvscsi_kick_io(adapter, cmd->cmnd[0]);
+	pvscsi_kick_io(adapter, op);
 
 	return 0;
 }
