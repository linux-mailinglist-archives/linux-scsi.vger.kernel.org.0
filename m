Return-Path: <linux-scsi+bounces-25028-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fVp5JDluMWqRjAUAu9opvQ
	(envelope-from <linux-scsi+bounces-25028-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 17:39:37 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 309B66913F7
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 17:39:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KDv4rmuI;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25028-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25028-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3051313738C
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 15:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3172E43DA2D;
	Tue, 16 Jun 2026 15:30:33 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB0043E9C6;
	Tue, 16 Jun 2026 15:30:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623833; cv=none; b=PXl6fA8RFDyq11UfN0mM1Bn3Vzn8sLMXq2xhg1Meja2x/+8Cv02Usg10dkEVsakWAtnX9xiV1msaYe2gTMgClJDe1BaDKQpaVaeCw5mzpIZDCKCWcMVo72y7q/Toq1nTeYc6xtVc1y6qWsF3Qs011MumFI3RS8tTspotVsvDyqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623833; c=relaxed/simple;
	bh=9a8z1iwKQnqy6KEwtDO+vWVPHnbhMjURXgFjgniogRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDjt0rt5mT4oUfPPdNol0ncFPWj+WXH9M6xrgifNyYNLu/xugMvtZMoSMITSVONMNrDoa3bSKi5FPmpxkhb+OZOduyLwTtfjsZqY4VrVBsGDchErnNFpbTT+R8V+QTC2jlyEp+Qt/FdtQiPQyT0o2fADwaUVe5Te5v87U2/AxYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDv4rmuI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34E91F00A3A;
	Tue, 16 Jun 2026 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781623831;
	bh=nUS7SYRwGO7Dk5r+dINtODaRZr+3PT9sPBP/zZYA0eU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KDv4rmuICw10lcsmtQ19i5KUgGXgIrIakXPQy2AYyJGkFQa6b4rmCOVkn+Ts3P7lC
	 /GnkpvUihsQA7fRSIQy5mCD3AHt9CMTFI47Eh8kF2moOJv3e0gkYmpsiFYw59K9Pr9
	 /ptIR9ISPLFHowa8hisSAgdq1KUjRBGA9v5HPAvAZZ+NpnPtT9glanwycyGCMawpIe
	 cgWakyMZNozs/G+6gReUVQDX2NjApkpf61dkiSsTlqi9mMR8qG/nM0ossA3ioSdmS1
	 e/adKdf1/DaZpyI57nDQkhJ+H6M26k+qBwnwbnGqLilxfJwfzaNoCMpGCfb1/5hs9S
	 A585fdj6y9dgg==
From: Alexey Gladkov <legion@kernel.org>
To: Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: MPT-FusionLinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	legion@kernel.org
Subject: [PATCH v2] scsi: mptfusion: Fix array out of bounds error
Date: Tue, 16 Jun 2026 17:29:08 +0200
Message-ID: <20260616152908.363621-1-legion@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616124528.319527-1-legion@kernel.org>
References: <20260616124528.319527-1-legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sathya.prakash@broadcom.com,m:sreekanth.reddy@broadcom.com,m:suganath-prabu.subramani@broadcom.com,m:MPT-FusionLinux.pdl@broadcom.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:legion@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-25028-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[legion@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[legion@kernel.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,gitlab.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 309B66913F7

The driver retrieves the number of ports from the hardware. However, the
driver can handle no more than two such ports. It uses a fixed array for
them.

We use NumberOfPorts without checking, and maybe on actual hardware
there really are never more than two ports, but QEMU passes 8 [1][2].

[1] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/scsi/mptsas.h?ref_type=heads#L7
[2] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/scsi/mptsas.c?ref_type=heads#L619

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
v2:
* Replaced the retrieval of MPT_ADAPTER from pci_get_drvdata with a wrapper that
  checks the array boundaries.
* Replaced the magic number of array elements with a macro because these arrays
  are associated.

---
 drivers/message/fusion/mptbase.c  | 22 +++++++++++++++++++---
 drivers/message/fusion/mptbase.h  |  9 ++++++---
 drivers/message/fusion/mptctl.c   |  2 +-
 drivers/message/fusion/mptfc.c    |  4 ++--
 drivers/message/fusion/mptlan.c   |  4 ++--
 drivers/message/fusion/mptsas.c   |  6 +++---
 drivers/message/fusion/mptscsih.c |  6 +++---
 drivers/message/fusion/mptspi.c   |  6 +++---
 8 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 3a431ffd3e2e..9e738d0bb8e3 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -1741,6 +1741,21 @@ mpt_mapresources(MPT_ADAPTER *ioc)
 	return r;
 }
 
+MPT_ADAPTER *
+mpt_get_adapter(struct pci_dev *pdev)
+{
+	MPT_ADAPTER *ioc = pci_get_drvdata(pdev);
+
+	if (ioc && ioc->facts.NumberOfPorts >= ARRAY_SIZE(ioc->pfacts)) {
+		ioc->facts.NumberOfPorts = ARRAY_SIZE(ioc->pfacts);
+	}
+
+	BUILD_BUG_ON(ARRAY_SIZE(ioc->pfacts) != ARRAY_SIZE(ioc->fc_port_page0));
+	BUILD_BUG_ON(ARRAY_SIZE(ioc->pfacts) != ARRAY_SIZE(ioc->fc_data.fc_port_page1));
+
+	return ioc;
+}
+
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /**
  *	mpt_attach - Install a PCI intelligent MPT adapter.
@@ -2074,7 +2089,7 @@ mpt_attach(struct pci_dev *pdev, const struct pci_device_id *id)
 void
 mpt_detach(struct pci_dev *pdev)
 {
-	MPT_ADAPTER 	*ioc = pci_get_drvdata(pdev);
+	MPT_ADAPTER 	*ioc = mpt_get_adapter(pdev);
 	char pname[64];
 	u8 cb_idx;
 	unsigned long flags;
@@ -2140,7 +2155,7 @@ int
 mpt_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	u32 device_state;
-	MPT_ADAPTER *ioc = pci_get_drvdata(pdev);
+	MPT_ADAPTER *ioc = mpt_get_adapter(pdev);
 
 	device_state = pci_choose_state(pdev, state);
 	printk(MYIOC_s_INFO_FMT "pci-suspend: pdev=0x%p, slot=%s, Entering "
@@ -2179,7 +2194,7 @@ mpt_suspend(struct pci_dev *pdev, pm_message_t state)
 int
 mpt_resume(struct pci_dev *pdev)
 {
-	MPT_ADAPTER *ioc = pci_get_drvdata(pdev);
+	MPT_ADAPTER *ioc = mpt_get_adapter(pdev);
 	u32 device_state = pdev->current_state;
 	int recovery_state;
 	int err;
@@ -8451,6 +8466,7 @@ EXPORT_SYMBOL(mpt_reset_register);
 EXPORT_SYMBOL(mpt_reset_deregister);
 EXPORT_SYMBOL(mpt_device_driver_register);
 EXPORT_SYMBOL(mpt_device_driver_deregister);
+EXPORT_SYMBOL(mpt_get_adapter);
 EXPORT_SYMBOL(mpt_get_msg_frame);
 EXPORT_SYMBOL(mpt_put_msg_frame);
 EXPORT_SYMBOL(mpt_put_msg_frame_hi_pri);
diff --git a/drivers/message/fusion/mptbase.h b/drivers/message/fusion/mptbase.h
index b406fd676da0..ca0a873af01e 100644
--- a/drivers/message/fusion/mptbase.h
+++ b/drivers/message/fusion/mptbase.h
@@ -113,6 +113,8 @@
 #define MPT_PROCFS_SUMMARY_ALL_PATHNAME		"/proc/" MPT_PROCFS_SUMMARY_ALL_NODE
 #define MPT_FW_REV_MAGIC_ID_STRING		"FwRev="
 
+#define MPT_MAX_PORT_FACTS		2
+
 #define  MPT_MAX_REQ_DEPTH		1023
 #define  MPT_DEFAULT_REQ_DEPTH		256
 #define  MPT_MIN_REQ_DEPTH		128
@@ -537,7 +539,7 @@ typedef struct _FcCfgData {
 		FCPortPage1_t	*data;
 		dma_addr_t	 dma;
 		int		 pg_sz;
-	}			 fc_port_page1[2];
+	}			 fc_port_page1[MPT_MAX_PORT_FACTS];
 } FcCfgData;
 
 #define MPT_RPORT_INFO_FLAGS_REGISTERED	0x01	/* rport registered */
@@ -699,8 +701,8 @@ typedef struct _MPT_ADAPTER
 	u32			 hs_req[MPT_MAX_FRAME_SIZE/sizeof(u32)];
 	u16			 hs_reply[MPT_MAX_FRAME_SIZE/sizeof(u16)];
 	IOCFactsReply_t		 facts;
-	PortFactsReply_t	 pfacts[2];
-	FCPortPage0_t		 fc_port_page0[2];
+	PortFactsReply_t	 pfacts[MPT_MAX_PORT_FACTS];
+	FCPortPage0_t		 fc_port_page0[MPT_MAX_PORT_FACTS];
 	LANPage0_t		 lan_cnfg_page0;
 	LANPage1_t		 lan_cnfg_page1;
 
@@ -918,6 +920,7 @@ extern int	 mpt_reset_register(u8 cb_idx, MPT_RESETHANDLER reset_func);
 extern void	 mpt_reset_deregister(u8 cb_idx);
 extern int	 mpt_device_driver_register(struct mpt_pci_driver * dd_cbfunc, u8 cb_idx);
 extern void	 mpt_device_driver_deregister(u8 cb_idx);
+extern MPT_ADAPTER *mpt_get_adapter(struct pci_dev *pdev);
 extern MPT_FRAME_HDR	*mpt_get_msg_frame(u8 cb_idx, MPT_ADAPTER *ioc);
 extern void	 mpt_free_msg_frame(MPT_ADAPTER *ioc, MPT_FRAME_HDR *mf);
 extern void	 mpt_put_msg_frame(u8 cb_idx, MPT_ADAPTER *ioc, MPT_FRAME_HDR *mf);
diff --git a/drivers/message/fusion/mptctl.c b/drivers/message/fusion/mptctl.c
index 77fa55df70d0..8023062431e1 100644
--- a/drivers/message/fusion/mptctl.c
+++ b/drivers/message/fusion/mptctl.c
@@ -2849,7 +2849,7 @@ static long compat_mpctl_ioctl(struct file *f, unsigned int cmd, unsigned long a
 static int
 mptctl_probe(struct pci_dev *pdev)
 {
-	MPT_ADAPTER *ioc = pci_get_drvdata(pdev);
+	MPT_ADAPTER *ioc = mpt_get_adapter(pdev);
 
 	mutex_init(&ioc->ioctl_cmds.mutex);
 	init_completion(&ioc->ioctl_cmds.done);
diff --git a/drivers/message/fusion/mptfc.c b/drivers/message/fusion/mptfc.c
index b55deb988ad9..3c00f4c88343 100644
--- a/drivers/message/fusion/mptfc.c
+++ b/drivers/message/fusion/mptfc.c
@@ -1219,7 +1219,7 @@ mptfc_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if ((r = mpt_attach(pdev,id)) != 0)
 		return r;
 
-	ioc = pci_get_drvdata(pdev);
+	ioc = mpt_get_adapter(pdev);
 	ioc->DoneCtx = mptfcDoneCtx;
 	ioc->TaskCtx = mptfcTaskCtx;
 	ioc->InternalCtx = mptfcInternalCtx;
@@ -1525,7 +1525,7 @@ mptfc_init(void)
  */
 static void mptfc_remove(struct pci_dev *pdev)
 {
-	MPT_ADAPTER		*ioc = pci_get_drvdata(pdev);
+	MPT_ADAPTER		*ioc = mpt_get_adapter(pdev);
 	struct mptfc_rport_info	*p, *n;
 	struct workqueue_struct *work_q;
 	unsigned long		flags;
diff --git a/drivers/message/fusion/mptlan.c b/drivers/message/fusion/mptlan.c
index f7fc5cc04b92..ccd735aa532a 100644
--- a/drivers/message/fusion/mptlan.c
+++ b/drivers/message/fusion/mptlan.c
@@ -1380,7 +1380,7 @@ mpt_register_lan_device (MPT_ADAPTER *mpt_dev, int pnum)
 static int
 mptlan_probe(struct pci_dev *pdev)
 {
-	MPT_ADAPTER 		*ioc = pci_get_drvdata(pdev);
+	MPT_ADAPTER 		*ioc = mpt_get_adapter(pdev);
 	struct net_device	*dev;
 	int			i;
 
@@ -1426,7 +1426,7 @@ mptlan_probe(struct pci_dev *pdev)
 static void
 mptlan_remove(struct pci_dev *pdev)
 {
-	MPT_ADAPTER 		*ioc = pci_get_drvdata(pdev);
+	MPT_ADAPTER 		*ioc = mpt_get_adapter(pdev);
 	struct net_device	*dev = ioc->netdev;
 	struct mpt_lan_priv *priv = netdev_priv(dev);
 
diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
index c362f09a8c55..b328c8685192 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -5163,7 +5163,7 @@ mptsas_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (r)
 		return r;
 
-	ioc = pci_get_drvdata(pdev);
+	ioc = mpt_get_adapter(pdev);
 	mptsas_fw_event_off(ioc);
 	ioc->DoneCtx = mptsasDoneCtx;
 	ioc->TaskCtx = mptsasTaskCtx;
@@ -5337,7 +5337,7 @@ mptsas_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void
 mptsas_shutdown(struct pci_dev *pdev)
 {
-	MPT_ADAPTER *ioc = pci_get_drvdata(pdev);
+	MPT_ADAPTER *ioc = mpt_get_adapter(pdev);
 
 	mptsas_fw_event_off(ioc);
 	mptsas_cleanup_fw_event_q(ioc);
@@ -5345,7 +5345,7 @@ mptsas_shutdown(struct pci_dev *pdev)
 
 static void mptsas_remove(struct pci_dev *pdev)
 {
-	MPT_ADAPTER *ioc = pci_get_drvdata(pdev);
+	MPT_ADAPTER *ioc = mpt_get_adapter(pdev);
 	struct mptsas_portinfo *p, *n;
 	int i;
 
diff --git a/drivers/message/fusion/mptscsih.c b/drivers/message/fusion/mptscsih.c
index ec6edcc4ef56..290939225688 100644
--- a/drivers/message/fusion/mptscsih.c
+++ b/drivers/message/fusion/mptscsih.c
@@ -1171,7 +1171,7 @@ mptscsih_report_queue_full(struct scsi_cmnd *sc, SCSIIOReply_t *pScsiReply, SCSI
 void
 mptscsih_remove(struct pci_dev *pdev)
 {
-	MPT_ADAPTER 		*ioc = pci_get_drvdata(pdev);
+	MPT_ADAPTER 		*ioc = mpt_get_adapter(pdev);
 	struct Scsi_Host 	*host = ioc->sh;
 	MPT_SCSI_HOST		*hd;
 	int sz1;
@@ -1228,7 +1228,7 @@ mptscsih_shutdown(struct pci_dev *pdev)
 int
 mptscsih_suspend(struct pci_dev *pdev, pm_message_t state)
 {
-	MPT_ADAPTER 		*ioc = pci_get_drvdata(pdev);
+	MPT_ADAPTER 		*ioc = mpt_get_adapter(pdev);
 
 	scsi_block_requests(ioc->sh);
 	mptscsih_shutdown(pdev);
@@ -1244,7 +1244,7 @@ mptscsih_suspend(struct pci_dev *pdev, pm_message_t state)
 int
 mptscsih_resume(struct pci_dev *pdev)
 {
-	MPT_ADAPTER 		*ioc = pci_get_drvdata(pdev);
+	MPT_ADAPTER 		*ioc = mpt_get_adapter(pdev);
 	int rc;
 
 	rc = mpt_resume(pdev);
diff --git a/drivers/message/fusion/mptspi.c b/drivers/message/fusion/mptspi.c
index 56892b1f3de2..ad92c23bd632 100644
--- a/drivers/message/fusion/mptspi.c
+++ b/drivers/message/fusion/mptspi.c
@@ -1330,7 +1330,7 @@ mptspi_ioc_reset(MPT_ADAPTER *ioc, int reset_phase)
 static int
 mptspi_resume(struct pci_dev *pdev)
 {
-	MPT_ADAPTER 	*ioc = pci_get_drvdata(pdev);
+	MPT_ADAPTER 	*ioc = mpt_get_adapter(pdev);
 	struct _MPT_SCSI_HOST *hd = shost_priv(ioc->sh);
 	int rc;
 
@@ -1367,7 +1367,7 @@ mptspi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if ((r = mpt_attach(pdev,id)) != 0)
 		return r;
 
-	ioc = pci_get_drvdata(pdev);
+	ioc = mpt_get_adapter(pdev);
 	ioc->DoneCtx = mptspiDoneCtx;
 	ioc->TaskCtx = mptspiTaskCtx;
 	ioc->InternalCtx = mptspiInternalCtx;
@@ -1546,7 +1546,7 @@ mptspi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 static void mptspi_remove(struct pci_dev *pdev)
 {
-	MPT_ADAPTER *ioc = pci_get_drvdata(pdev);
+	MPT_ADAPTER *ioc = mpt_get_adapter(pdev);
 
 	scsi_remove_host(ioc->sh);
 	mptscsih_remove(pdev);
-- 
2.54.0


