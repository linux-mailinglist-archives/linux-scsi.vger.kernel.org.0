Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5426A2C97B1
	for <lists+linux-scsi@lfdr.de>; Tue,  1 Dec 2020 07:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgLAGwd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 1 Dec 2020 01:52:33 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:50828 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgLAGwc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 1 Dec 2020 01:52:32 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id BD4322B6CF; Tue,  1 Dec 2020 01:51:51 -0500 (EST)
To:     Michael Schmitz <schmitzmic@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Thomas Gleixner" <tglx@linutronix.de>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <58cf6feeaf5dae1ee0c78c1b25c00c73de15b087.1606805196.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] scsi/NCR5380: Remove in_interrupt() test
Date:   Tue, 01 Dec 2020 17:46:36 +1100
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The in_interrupt() macro is deprecated. Also, it's usage in
NCR5380_poll_politely2() has long been redundant.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ahmed S. Darwish <a.darwish@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201126132952.2287996-1-bigeasy@linutronix.de
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/scsi/NCR5380.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index 462d911a89f2..6972e7ceb81a 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -223,7 +223,10 @@ static int NCR5380_poll_politely2(struct NCR5380_hostdata *hostdata,
 		cpu_relax();
 	} while (n--);
 
-	if (irqs_disabled() || in_interrupt())
+	/* Sleeping is not allowed when in atomic or interrupt contexts.
+	 * Callers in such contexts always disable local irqs.
+	 */
+	if (irqs_disabled())
 		return -ETIMEDOUT;
 
 	/* Repeatedly sleep for 1 ms until deadline */
-- 
2.26.2

