Return-Path: <linux-scsi+bounces-390-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3439F8002A0
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 05:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660661C20B28
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 04:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C9C1FAA
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 04:34:58 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 0F9CE1722;
	Thu, 30 Nov 2023 19:00:23 -0800 (PST)
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 6E5CF60105E65;
	Fri,  1 Dec 2023 11:00:21 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: dan.carpenter@linaro.org,
	hare@suse.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com
Cc: Su Hui <suhui@nfschina.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2 3/3] scsi: aic7xxx: return negative error codes in aic7770_probe()
Date: Fri,  1 Dec 2023 10:59:56 +0800
Message-Id: <20231201025955.1584260-4-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231201025955.1584260-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aic7770_config() returns both negative and positive error code.
it's better to make aic7770_probe() only return negative error codes.

And the previous patch made ahc_linux_register_host() return negative error
codes, which makes sure aic7770_probe() returns negative error codes.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/scsi/aic7xxx/aic7770_osm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic7770_osm.c b/drivers/scsi/aic7xxx/aic7770_osm.c
index bdd177e3d762..a19cdd87c453 100644
--- a/drivers/scsi/aic7xxx/aic7770_osm.c
+++ b/drivers/scsi/aic7xxx/aic7770_osm.c
@@ -87,17 +87,17 @@ aic7770_probe(struct device *dev)
 	sprintf(buf, "ahc_eisa:%d", eisaBase >> 12);
 	name = kstrdup(buf, GFP_ATOMIC);
 	if (name == NULL)
-		return (ENOMEM);
+		return -ENOMEM;
 	ahc = ahc_alloc(&aic7xxx_driver_template, name);
 	if (ahc == NULL)
-		return (ENOMEM);
+		return -ENOMEM;
 	ahc->dev = dev;
 	error = aic7770_config(ahc, aic7770_ident_table + edev->id.driver_data,
 			       eisaBase);
 	if (error != 0) {
 		ahc->bsh.ioport = 0;
 		ahc_free(ahc);
-		return (error);
+		return error < 0 ? error : -error;
 	}
 
  	dev_set_drvdata(dev, ahc);
-- 
2.30.2


