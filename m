Return-Path: <linux-scsi+bounces-26044-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9qXONuBlVGo4lgMAu9opvQ
	(envelope-from <linux-scsi+bounces-26044-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 06:13:20 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AE474710C
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 06:13:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UoI8T0Yj;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26044-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26044-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 515623018AFA
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 04:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3CB37189B;
	Mon, 13 Jul 2026 04:13:08 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C8634E75A;
	Mon, 13 Jul 2026 04:13:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783915988; cv=none; b=XUCVTTaO4XCzYgOfzUIEa0Z13Lg+Zz16oDHzGmb6EhT4PqDnbJ62qN/o/ROdpEk/CHUstmu3ai045kU7qgUCrIV3ui5l45JmIhABCEqouwsXbUx9RzDs/G0SeNmesoQ362l0V+8G1kuze0lRFVl3Fx5v71H3SQ4G3S70II0tlJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783915988; c=relaxed/simple;
	bh=bWJLb8y3IRnH0oBQBVLnQGIaMuOtOmr8g7OiytZuP5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZ9pmUu3McLdgnfdOV3q6BbshCrg871q2Gpxl7JHna+3loHK/vllxQrYEvp/zovcmZVa6o99cnINRqS9RsfxK5w1gJjthf/xM5ptiVBSEQ+quaZBGbkcPtubtIZbx5hrpwyT4pGB7W3sZ+scK7FP7ly04qjDsmGPDpSY4oRAlic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoI8T0Yj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159EF1F00A3D;
	Mon, 13 Jul 2026 04:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783915986;
	bh=rFRMX/2DttBTvXWfZlaFdhLkr1Ta3uJllRUjHcKnJAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UoI8T0YjB14O3U6SWwc8IKx+JST0/jvsBvtHuhRbb99E892TlQlqxL/FqtRSxAsj5
	 D3POQbAIh+O9p0AnVzRS9id7EOJT3GcamWCAjd+nRUWtM2aceyBdWM+GZpImt70NQ5
	 RthDwgLJQjKjqZXsdlMEbWGJH/Cmhl/WSojfnnXPQVZ7pNcauzMFtASDgtuaEpE9SE
	 Rrw712OsZozoB9feE4dXOXpptC9+qakIhw67kVueKL8ENhcAtqkh00Q8GHRHWbUxf5
	 oG09OLgk3hvQWJfObFTbn1MbagLo9E4PLPi2CvcfhGmOicLfqxpDSFZhkuLZt3xn9L
	 GRo7YLDtZIRpg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Igor Pylypiv <ipylypiv@google.com>,
	John Garry <john.g.garry@oracle.com>,
	Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v3 2/2] scsi: libsas: terminate deferred commands on time out
Date: Mon, 13 Jul 2026 13:12:52 +0900
Message-ID: <20260713041252.463401-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713041252.463401-1-dlemoal@kernel.org>
References: <20260713041252.463401-1-dlemoal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-ide@vger.kernel.org,m:cassel@kernel.org,m:linux-scsi@vger.kernel.org,m:martin.petersen@oracle.com,m:ipylypiv@google.com,m:john.g.garry@oracle.com,m:yanaijie@huawei.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-26044-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67AE474710C

If a command timeout occurs while we have a deferred non-NCQ command
waiting to be issued, the SCSI EH task is not immediately woken up as the
waiting deferred command is never issued nor completed, thus leaving this
command to always be counted as "busy" for the SCSI host. This results in
the test "shost->host_failed != scsi_host_busy(shost))" in the function
scsi_error_handler() to always be true, keeping the EH task sleeping.
Eventually, when the deferred command also times out, the SCSI EH task
is woken up and the timeout processing occurs.

Avoid this unnecessary additional SCSI EH trigger wait time with the same
method as implemented in libata-scsi, using the eh_timed_out SCSI host
template operation. The function sas_eh_timed_out() implements this
operation and executes the function ata_eh_schedule_deferred_qc_retry()
for SATA devices.

Co-developed-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-eh.c             |  1 +
 drivers/ata/libata.h                |  2 --
 drivers/scsi/libsas/sas_scsi_host.c | 17 +++++++++++++++++
 include/linux/libata.h              |  2 ++
 include/scsi/libsas.h               |  2 ++
 5 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 8e9d57c6f039..ff6d9f94ebed 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -570,6 +570,7 @@ void ata_eh_schedule_deferred_qc_retry(struct ata_port *ap,
 	}
 	spin_unlock_irqrestore(ap->lock, flags);
 }
+EXPORT_SYMBOL_GPL(ata_eh_schedule_deferred_qc_retry);
 
 /**
  *	ata_scsi_error - SCSI layer error handler callback
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index e1fdecd93ccf..700627596ce1 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -198,8 +198,6 @@ extern void ata_eh_about_to_do(struct ata_link *link, struct ata_device *dev,
 			       unsigned int action);
 extern void ata_eh_done(struct ata_link *link, struct ata_device *dev,
 			unsigned int action);
-void ata_eh_schedule_deferred_qc_retry(struct ata_port *ap,
-				       struct scsi_cmnd *scmd);
 extern void ata_eh_autopsy(struct ata_port *ap);
 const char *ata_get_cmd_name(u8 command);
 extern void ata_eh_report(struct ata_port *ap);
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index c83282733ec4..6b62522bd0b2 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -502,6 +502,23 @@ int sas_eh_target_reset_handler(struct scsi_cmnd *cmd)
 }
 EXPORT_SYMBOL_GPL(sas_eh_target_reset_handler);
 
+/*
+ * Handle deferred QCs in case of a command timeout.
+ * See ata_scsi_eh_timed_out() for details.
+ */
+enum scsi_timeout_action sas_eh_timed_out(struct scsi_cmnd *cmd)
+{
+	struct domain_device *dev = NULL;
+
+	if (cmd)
+		dev = cmd_to_domain_dev(cmd);
+	if (dev && dev_is_sata(dev))
+		ata_eh_schedule_deferred_qc_retry(dev->sata_dev.ap, cmd);
+
+	return SCSI_EH_NOT_HANDLED;
+}
+EXPORT_SYMBOL_GPL(sas_eh_timed_out);
+
 /* Try to reset a device */
 static int try_to_reset_cmd_device(struct scsi_cmnd *cmd)
 {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 327da43d7496..2ea7bfbdd867 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1261,6 +1261,8 @@ extern int sata_link_hardreset(struct ata_link *link,
 extern int sata_link_resume(struct ata_link *link, const unsigned int *params,
 			    unsigned long deadline);
 extern void ata_eh_analyze_ncq_error(struct ata_link *link);
+void ata_eh_schedule_deferred_qc_retry(struct ata_port *ap,
+				       struct scsi_cmnd *scmd);
 #else
 static inline const unsigned int *
 sata_ehc_deb_timing(struct ata_eh_context *ehc)
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 163f23c92b41..c7017ae76c61 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -705,6 +705,7 @@ void sas_task_abort(struct sas_task *);
 int sas_eh_abort_handler(struct scsi_cmnd *cmd);
 int sas_eh_device_reset_handler(struct scsi_cmnd *cmd);
 int sas_eh_target_reset_handler(struct scsi_cmnd *cmd);
+enum scsi_timeout_action sas_eh_timed_out(struct scsi_cmnd *cmd);
 
 extern void sas_target_destroy(struct scsi_target *);
 extern int sas_sdev_init(struct scsi_device *);
@@ -743,6 +744,7 @@ void sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
 	.this_id			= -1,				\
 	.eh_device_reset_handler	= sas_eh_device_reset_handler,	\
 	.eh_target_reset_handler	= sas_eh_target_reset_handler,	\
+	.eh_timed_out			= sas_eh_timed_out,		\
 	.target_destroy			= sas_target_destroy,		\
 	.ioctl				= sas_ioctl,			\
 
-- 
2.55.0


