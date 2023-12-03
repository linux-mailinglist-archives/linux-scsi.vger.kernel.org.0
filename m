Return-Path: <linux-scsi+bounces-458-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4455E80256F
	for <lists+linux-scsi@lfdr.de>; Sun,  3 Dec 2023 17:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75ACE1C208DB
	for <lists+linux-scsi@lfdr.de>; Sun,  3 Dec 2023 16:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53A01799E
	for <lists+linux-scsi@lfdr.de>; Sun,  3 Dec 2023 16:31:42 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24B4CF
	for <linux-scsi@vger.kernel.org>; Sun,  3 Dec 2023 08:06:19 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r9oz0-0005gg-DZ; Sun, 03 Dec 2023 17:06:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r9oyz-00DK9b-AA; Sun, 03 Dec 2023 17:06:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r9oyz-00DPoY-18; Sun, 03 Dec 2023 17:06:13 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 01/14] scsi: a3000: Convert to platform remove callback returning void
Date: Sun,  3 Dec 2023 17:05:46 +0100
Message-ID:  <811d180950b76c2d95cd080e3c251757ca011380.1701619134.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701619134.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701619134.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2007; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=FWmyBG6+tosrER5aYhbcZFS6iW6Rp5zpoo99vHGj6y8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlbKdZ5mpZm/TAn5pBfmQQEXUh96znGSqOye8Lm CKdnheIJxiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZWynWQAKCRCPgPtYfRL+ Ti6JCACt/hu9m+xc9l8ynuGIyK/CqoUmIUb+jp5LthyeKHHb4bwhXSwiWsnm2QzQrpjPKX9GR8J NHJheZS3LWqj+dqRhBTbb+dC0nxbTHlGH9XsMN3xYU0aDRVSnCM/NRKzgKIHuLrizWpILtNPUNU Rt8mqhWWmvNZu1W5tBGwZ0miMEawxr27FyraZ1xatBqcDPh2N+7ugeMeDs7keZYW1nYGjUvEvJ7 SK4XuSIGQARQQH64FsykVM6wPrl6SrUvjIntt3DJL/nI94mocTLnzXznS48Ik5LupHxI3rESWsm fGKL/qqsP2dzF7fFDFIsnpKyz7hw+HFLs+w7xatMZOpkzhhW
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-scsi@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

In the error path emit an error message replacing the (less useful)
message by the core. Apart from the improved error message there is no
change in behaviour.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/scsi/a3000.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/a3000.c b/drivers/scsi/a3000.c
index c3028726bbe4..378906f77909 100644
--- a/drivers/scsi/a3000.c
+++ b/drivers/scsi/a3000.c
@@ -282,7 +282,7 @@ static int __init amiga_a3000_scsi_probe(struct platform_device *pdev)
 	return error;
 }
 
-static int __exit amiga_a3000_scsi_remove(struct platform_device *pdev)
+static void __exit amiga_a3000_scsi_remove(struct platform_device *pdev)
 {
 	struct Scsi_Host *instance = platform_get_drvdata(pdev);
 	struct a3000_hostdata *hdata = shost_priv(instance);
@@ -293,11 +293,10 @@ static int __exit amiga_a3000_scsi_remove(struct platform_device *pdev)
 	free_irq(IRQ_AMIGA_PORTS, instance);
 	scsi_host_put(instance);
 	release_mem_region(res->start, resource_size(res));
-	return 0;
 }
 
 static struct platform_driver amiga_a3000_scsi_driver = {
-	.remove = __exit_p(amiga_a3000_scsi_remove),
+	.remove_new = __exit_p(amiga_a3000_scsi_remove),
 	.driver   = {
 		.name	= "amiga-a3000-scsi",
 	},
-- 
2.42.0


