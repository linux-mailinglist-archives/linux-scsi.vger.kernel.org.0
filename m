Return-Path: <linux-scsi+bounces-23921-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPaxBWTGDGp2lwUAu9opvQ
	(envelope-from <linux-scsi+bounces-23921-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 19 May 2026 22:21:56 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1103D5849A1
	for <lists+linux-scsi@lfdr.de>; Tue, 19 May 2026 22:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7CD303029CCB
	for <lists+linux-scsi@lfdr.de>; Tue, 19 May 2026 20:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CD03B3BEB;
	Tue, 19 May 2026 20:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqzTgg10"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7C32E7F2C;
	Tue, 19 May 2026 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222110; cv=none; b=pOFBuDM2xoYBoBYLe8HRaawqFImR1+QAfR/WcdPiETFxIlLmvYV84jGAV1i33piMmTOvY+ED0+LSthTRPNilUZR/SSllsslObyrgEOP0XiQDvIgeJREgUcuyVwWCzID3V/GezWklgoiVUj3yO40v0RnEVlgNEu1KjyoKH0cybLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222110; c=relaxed/simple;
	bh=ubc1l+OcfR5/MPRrLhc6BNL3WpvLkCPcShU5H3ylQrw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nDtZw8u0KSr/47hLz5lQpAFlu5Vc/mnIO0CL3+FPYFbima6a6lgy0V1JyBVhmwVBVsvlFCKLE9JcUwz28NO/4jWb1DspjyYLuWhD6SS5EJY5O20oLjOz0bAxoihPF60x0y7JS4Itd89XIkg7YSFBYU0GndxlzF9DrLULBR8hi9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqzTgg10; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5272F1F000E9;
	Tue, 19 May 2026 20:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779222108;
	bh=vF0SREBXyGRMringWBzmpzVqc1g/Mlb0KOno9gGckgo=;
	h=From:To:Cc:Subject:Date;
	b=fqzTgg10wXZnY6feN5DEUwTaoPQdimbiWZsVPm++3M09NIM8xuKHRoTWHZFv/vyXj
	 DrlKuI1AlANprHyAjzj3duXgPR+B3F6yd9vi5JTetKRm3nV+6cvaVeRDz8qVBvVVXf
	 aCL8H6bIGNERYV9RlLlbjLbbcvK+woclQm7F+hFok+P0VRY9b1C2T9vxHcrzwGGB2X
	 6Nw92aIcVSnvFEVVmbeHbxZOmHjhkzjJ5FfaFEfmmZwYqfqI8yRgguPSWugLOi+5sM
	 S8BY16LrI3l6PVrlKvXWJE2YPxij+I6PDxR5oIXXPjfLfgRcos8Peeu6mIFEOKMi+Z
	 fSFS8Y09/OLnw==
From: Arnd Bergmann <arnd@kernel.org>
To: Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Kees Cook <kees@kernel.org>,
	megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: megaraid: reduce stack usage in megaraid_cmm_register()
Date: Tue, 19 May 2026 22:21:24 +0200
Message-Id: <20260519202143.1305850-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23921-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1103D5849A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arnd Bergmann <arnd@arndb.de>

The megaraid_cmm_register() function has a local copy of mraid_mmadp_t on
the stack that gets copied into the actual structure used at runtime. When
-fsanitize=thread is enabled, this causes the per-function stack frame
to grow beyond the warning limit:

megaraid_mbox.c: In function 'megaraid_cmm_register':
megaraid_mbox.c:3472:1: error: the frame size of 1312 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]

Refactor this by moving the allocation into the caller to
save the extra on-stack copy of the structure.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/megaraid/megaraid_mbox.c | 26 ++++++++++++++---------
 drivers/scsi/megaraid/megaraid_mm.c   | 30 +++++++--------------------
 2 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
index 06cf94ee4e36..ce89032a5a74 100644
--- a/drivers/scsi/megaraid/megaraid_mbox.c
+++ b/drivers/scsi/megaraid/megaraid_mbox.c
@@ -3396,7 +3396,7 @@ static int
 megaraid_cmm_register(adapter_t *adapter)
 {
 	mraid_device_t	*raid_dev = ADAP2RAIDDEV(adapter);
-	mraid_mmadp_t	adp;
+	mraid_mmadp_t	*adp;
 	scb_t		*scb;
 	mbox_ccb_t	*ccb;
 	int		rval;
@@ -3404,11 +3404,16 @@ megaraid_cmm_register(adapter_t *adapter)
 
 	// Allocate memory for the base list of scb for management module.
 	adapter->uscb_list = kzalloc_objs(scb_t, MBOX_MAX_USER_CMDS);
+	adp = kzalloc_obj(*adp);
 
-	if (adapter->uscb_list == NULL) {
+	if (!adapter->uscb_list || !adp) {
 		con_log(CL_ANN, (KERN_WARNING
 			"megaraid: out of memory, %s %d\n", __func__,
 			__LINE__));
+
+		kfree(adapter->uscb_list);
+		kfree(adp);
+
 		return -1;
 	}
 
@@ -3452,20 +3457,21 @@ megaraid_cmm_register(adapter_t *adapter)
 		list_add_tail(&scb->list, &adapter->uscb_pool);
 	}
 
-	adp.unique_id		= adapter->unique_id;
-	adp.drvr_type		= DRVRTYPE_MBOX;
-	adp.drvr_data		= (unsigned long)adapter;
-	adp.pdev		= adapter->pdev;
-	adp.issue_uioc		= megaraid_mbox_mm_handler;
-	adp.timeout		= MBOX_RESET_WAIT + MBOX_RESET_EXT_WAIT;
-	adp.max_kioc		= MBOX_MAX_USER_CMDS;
+	adp->unique_id		= adapter->unique_id;
+	adp->drvr_type		= DRVRTYPE_MBOX;
+	adp->drvr_data		= (unsigned long)adapter;
+	adp->pdev		= adapter->pdev;
+	adp->issue_uioc		= megaraid_mbox_mm_handler;
+	adp->timeout		= MBOX_RESET_WAIT + MBOX_RESET_EXT_WAIT;
+	adp->max_kioc		= MBOX_MAX_USER_CMDS;
 
-	if ((rval = mraid_mm_register_adp(&adp)) != 0) {
+	if ((rval = mraid_mm_register_adp(adp)) != 0) {
 
 		con_log(CL_ANN, (KERN_WARNING
 			"megaraid mbox: did not register with CMM\n"));
 
 		kfree(adapter->uscb_list);
+		kfree(adp);
 	}
 
 	return rval;
diff --git a/drivers/scsi/megaraid/megaraid_mm.c b/drivers/scsi/megaraid/megaraid_mm.c
index 538da0e98131..60db48dc8f3a 100644
--- a/drivers/scsi/megaraid/megaraid_mm.c
+++ b/drivers/scsi/megaraid/megaraid_mm.c
@@ -898,42 +898,28 @@ hinfo_to_cinfo(mraid_hba_info_t *hinfo, mcontroller_t *cinfo)
 
 /**
  * mraid_mm_register_adp - Registration routine for low level drivers
- * @lld_adp	: Adapter object
+ * @adapter	: Adapter object
  */
 int
-mraid_mm_register_adp(mraid_mmadp_t *lld_adp)
+mraid_mm_register_adp(mraid_mmadp_t *adapter)
 {
-	mraid_mmadp_t	*adapter;
 	mbox64_t	*mbox_list;
 	uioc_t		*kioc;
 	uint32_t	rval;
 	int		i;
 
 
-	if (lld_adp->drvr_type != DRVRTYPE_MBOX)
+	if (adapter->drvr_type != DRVRTYPE_MBOX)
 		return (-EINVAL);
 
-	adapter = kzalloc_obj(mraid_mmadp_t);
-
-	if (!adapter)
-		return -ENOMEM;
-
-
-	adapter->unique_id	= lld_adp->unique_id;
-	adapter->drvr_type	= lld_adp->drvr_type;
-	adapter->drvr_data	= lld_adp->drvr_data;
-	adapter->pdev		= lld_adp->pdev;
-	adapter->issue_uioc	= lld_adp->issue_uioc;
-	adapter->timeout	= lld_adp->timeout;
-	adapter->max_kioc	= lld_adp->max_kioc;
 	adapter->quiescent	= 1;
 
 	/*
 	 * Allocate single blocks of memory for all required kiocs,
 	 * mailboxes and passthru structures.
 	 */
-	adapter->kioc_list	= kmalloc_objs(uioc_t, lld_adp->max_kioc);
-	adapter->mbox_list	= kmalloc_objs(mbox64_t, lld_adp->max_kioc);
+	adapter->kioc_list	= kmalloc_objs(uioc_t, adapter->max_kioc);
+	adapter->mbox_list	= kmalloc_objs(mbox64_t, adapter->max_kioc);
 	adapter->pthru_dma_pool = dma_pool_create("megaraid mm pthru pool",
 						&adapter->pdev->dev,
 						sizeof(mraid_passthru_t),
@@ -956,11 +942,11 @@ mraid_mm_register_adp(mraid_mmadp_t *lld_adp)
 	 */
 	INIT_LIST_HEAD(&adapter->kioc_pool);
 	spin_lock_init(&adapter->kioc_pool_lock);
-	sema_init(&adapter->kioc_semaphore, lld_adp->max_kioc);
+	sema_init(&adapter->kioc_semaphore, adapter->max_kioc);
 
 	mbox_list	= (mbox64_t *)adapter->mbox_list;
 
-	for (i = 0; i < lld_adp->max_kioc; i++) {
+	for (i = 0; i < adapter->max_kioc; i++) {
 
 		kioc		= adapter->kioc_list + i;
 		kioc->cmdbuf	= (uint64_t)(unsigned long)(mbox_list + i);
@@ -997,7 +983,7 @@ mraid_mm_register_adp(mraid_mmadp_t *lld_adp)
 
 pthru_dma_pool_error:
 
-	for (i = 0; i < lld_adp->max_kioc; i++) {
+	for (i = 0; i < adapter->max_kioc; i++) {
 		kioc = adapter->kioc_list + i;
 		if (kioc->pthru32) {
 			dma_pool_free(adapter->pthru_dma_pool, kioc->pthru32,
-- 
2.39.5


