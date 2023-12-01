Return-Path: <linux-scsi+bounces-389-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C29080029F
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 05:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F428B20F1B
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 04:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A232D8826
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 04:34:53 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 97A2B171D;
	Thu, 30 Nov 2023 19:00:21 -0800 (PST)
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 976C760105E65;
	Fri,  1 Dec 2023 11:00:18 +0800 (CST)
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
Subject: [PATCH v2 1/3] scsi: aic7xxx: return negative error codes in ahc_linux_register_host()
Date: Fri,  1 Dec 2023 10:59:54 +0800
Message-Id: <20231201025955.1584260-2-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231201025955.1584260-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ahc_linux_register_host() return both positive and negative error code,
it's better to make this function only return negative error codes.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/scsi/aic7xxx/aic7xxx_osm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
index 4ae0a1c4d374..b0c4f2345321 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -1085,7 +1085,7 @@ ahc_linux_register_host(struct ahc_softc *ahc, struct scsi_host_template *templa
 	template->name = ahc->description;
 	host = scsi_host_alloc(template, sizeof(struct ahc_softc *));
 	if (host == NULL)
-		return (ENOMEM);
+		return -ENOMEM;
 
 	*((struct ahc_softc **)host->hostdata) = ahc;
 	ahc->platform_data->host = host;
-- 
2.30.2


