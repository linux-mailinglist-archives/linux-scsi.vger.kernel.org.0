Return-Path: <linux-scsi+bounces-764-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C18180A37B
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Dec 2023 13:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB3C4B20AE5
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Dec 2023 12:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCAD1C68F
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Dec 2023 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="kEKahupk";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="aAuCPI/4"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72830199A;
	Fri,  8 Dec 2023 02:39:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702031989; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=X2NYuAd/M+joW0pWe3l7KB0uDjyclgCr6MiibDFbl37Ont9KMN9Nwsq3X5MPPPGf1K
    6AB0glok9gbakX5f4QDCBYvK61Gd5vias5UYEjMfHsczZe3g1JVzFy32WCwQnRic32bl
    5Z9MOnHXierJvRHjxgxcwWetA6Kv40uQU94owMY3dq4/UltFaBjdOwVsafOHH/0FTz6c
    FqmLFh9G7s0p7xNxQn9rPKFzpkfeRQZKP/s1aUW/8JGBYwzEBxGxe1fDzGqO+prw37zq
    d4Uki5Tsx5UeSZo6sJWXa5lxYiigm7cHeUr01CZOIidBKcY3Tv7r/Lwg3OQidTKjHBAE
    E47A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1702031989;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WshsXzYobF6aU8b/TwxHeFrJvt/30IpR0AsKITwfNw4=;
    b=l3AYDMSgOwAn3Hudhcpe6eY7D6xew2EsZOWxG0HKaa4uKI6uE5DER40x1V6zD9QgwL
    1TCpTDZSC68dEgPdSUCu9GeNEb+Yx777m3ZQaOb8xEVMdrQIt4pd17C8QSnaG8MHqio1
    072Aik7lFx9pt5mVARWEiDeZeK+qSEHV0RKcj/zeZFO0A6+6huX5cn+d3CI+aVmBu9vN
    v3bZFKhfjXxs8Vgqkmo/l5i4XzqctvOftoyEyipFYxM9rLlFNuKLpAwRdZx86LXG3kt2
    vByUO1nAbKu+A+JQ+OfiaOH9i1295OMakJdCLV8gxROF1Vuspi15q4LESSjYMRfvv+4i
    ea9Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1702031989;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WshsXzYobF6aU8b/TwxHeFrJvt/30IpR0AsKITwfNw4=;
    b=kEKahupk5Wo3x33mSts3H1vqJjbZ9uAK8Bjhr57FRX5+W5eQ8QHhm4cSZX9k9zdrPd
    pUZHdtqqcFBvQ2x7MQBARaRmQZhiBFVrKA/xS3d/fuHqMM+KTQ930tft+Ut+dSAks866
    d3eWtUqkCRCIPpPRCH/3/8Ha7h6b1KyTCcyosvEjy3tYfm9Dt6b+HPuP5MoFRbYcWFWn
    zehVWAzTSXwld3dxdBBm5yfTsNXbgvLRMUG29Vc+boKUEEUzUJ1ydYoaWWYpU97EIgBD
    GF9PVZyKMUsmGvlWimP+B+5ouN5dwlBuvhxy3TIY3jB3yXifTldR7vFIv1gJzqOTJov0
    Rv0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1702031989;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WshsXzYobF6aU8b/TwxHeFrJvt/30IpR0AsKITwfNw4=;
    b=aAuCPI/4QCY/8fLS0DaBq3xDILgQD2bynTZihytRSrOWTFZY3H0BJ9XbX8mHMfXkYI
    XW5Mu3s9qFjATkcHz5Ag==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
Received: from Munilab01-lab.micron.com
    by smtp.strato.de (RZmta 49.10.0 AUTH)
    with ESMTPSA id z4c2a6zB8AdmBb4
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 8 Dec 2023 11:39:48 +0100 (CET)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	bvanassche@acm.org,
	alim.akhtar@samsung.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	mani@kernel.org,
	quic_cang@quicinc.com,
	quic_asutoshd@quicinc.com,
	beanhuo@micron.com,
	thomas@t-8ch.de
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mikebi@micron.com,
	lporzio@micron.com
Subject: [PATCH v4 1/3] scsi: ufs: core: Add ufshcd_is_ufs_dev_busy()
Date: Fri,  8 Dec 2023 11:39:38 +0100
Message-Id: <20231208103940.153734-2-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208103940.153734-1-beanhuo@iokpp.de>
References: <20231208103940.153734-1-beanhuo@iokpp.de>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Bean Huo <beanhuo@micron.com>

Add helper inline for retrieving whether UFS device is busy or not.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index f0b837cb0c2b..32cfcba66d60 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -235,6 +235,13 @@ ufs_get_desired_pm_lvl_for_dev_link_state(enum ufs_dev_pwr_mode dev_state,
 	return UFS_PM_LVL_0;
 }
 
+static inline bool ufshcd_is_ufs_dev_busy(struct ufs_hba *hba)
+{
+	return (hba->clk_gating.active_reqs || hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL ||
+		hba->outstanding_reqs || hba->outstanding_tasks || hba->active_uic_cmd ||
+		hba->uic_async_done);
+}
+
 static const struct ufs_dev_quirk ufs_fixups[] = {
 	/* UFS cards deviations table */
 	{ .wmanufacturerid = UFS_VENDOR_MICRON,
@@ -1917,10 +1924,7 @@ static void ufshcd_gate_work(struct work_struct *work)
 		goto rel_lock;
 	}
 
-	if (hba->clk_gating.active_reqs
-		|| hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL
-		|| hba->outstanding_reqs || hba->outstanding_tasks
-		|| hba->active_uic_cmd || hba->uic_async_done)
+	if (ufshcd_is_ufs_dev_busy(hba))
 		goto rel_lock;
 
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
-- 
2.34.1


