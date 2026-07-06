Return-Path: <linux-scsi+bounces-25623-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wg5oCFFiS2oQQgEAu9opvQ
	(envelope-from <linux-scsi+bounces-25623-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 10:07:45 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBDA70DE9D
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 10:07:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="ck/K3T8c";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25623-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25623-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D365301BD6D
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jul 2026 07:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375DD4CA264;
	Mon,  6 Jul 2026 06:56:35 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FE83EB0F4;
	Mon,  6 Jul 2026 06:56:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783320992; cv=none; b=OX08P78nNRF3GSPuXuXx34tTxGXooxDG85SfvTdBiwQcvCM/FmskiV81VCaFXN4pvb8B1kD7F2rz2KJgf2pwV4pI8zAPUMz5boPoWDeZb0sNzk7N6xap7BuDVxBl0asXa7MzQ343724vy+bZIqGO8ciFvAyk/qr5MNnj90J8SuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783320992; c=relaxed/simple;
	bh=gluATQgK136X2NaA5l+2c6eiRoyER7NSQNkZM4FdPu4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlnP0L36SJ1Jhkb5tRdxn+US77MZp6KsJ3j8+JJguJfP5kT58+HMw+60Co7+M1YYZTbIqQfirS1Bh+rypeSn5OxMXzwbZZxjqvvmswlb9pFUV+HAUtbXfgk6J47k/Btw/PqBHIVvHolrMpGqJnL16CxgFPeG2AgOxBCkB4DQ1g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ck/K3T8c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CDB1F00A3E;
	Mon,  6 Jul 2026 06:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783320983;
	bh=Yqrc2pZmygpf5FsngFXVeilRsT/c6BKvSjZbpBLe59E=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=ck/K3T8cjvYxWnNmHJf3LV0ej41y+a40TUsEoQjTbXwnVeMdDtqMGkaXerkW2p2RS
	 uOQCIENHF42DZjrCK9eOkgY4NfIa0yVVBb24TZ21XbdfxX6t42yfGj9BghkDE9Sj+v
	 CI2pPCfSjiO1Y0izxIVfGnExdfs0zBO8T2g8yrHx/d11FF6INFiybvXpmyWhMvR6hE
	 fR5ZmiKx6Jjvk8d021OKpBmnkL9TyUINIg8+p3JpnB21QEgJPWRGvERDANTqCxWyTT
	 iKq4uPaRqByk3HoOwVvHlYF/4CuNpzjszq9McWlxgslQ8AIkr39hFrrPyVUwFeGudX
	 tRvRBl9SCTEPw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v1 2/9] scsi: define depopulation capabilities related service actions
Date: Mon,  6 Jul 2026 15:56:03 +0900
Message-ID: <20260706065610.3559692-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706065610.3559692-1-dlemoal@kernel.org>
References: <20260706065610.3559692-1-dlemoal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-ide@vger.kernel.org,m:cassel@kernel.org,m:linux-scsi@vger.kernel.org,m:martin.petersen@oracle.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25623-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5EBDA70DE9D

Add to include/scsi/scsi_proto.h the definition of the four service
actions of the SERVICE ACTION IN (16) command for the storage element
depopulation and restoration capabilities, as defined in the SBC5 and
ZBC2 specifications. These are:
 - SAI_GET_PHYSICAL_ELEMENT_STATUS (GET PHYSICAL ELEMENT STATUS command)
 - SAI_REMOVE_ELEMENT_AND_TRUNCATE (REMOVE ELEMENT AND TRUNCATE command)
 - SAI_RESTORE_ELEMENTS_AND_REBUILD (RESTORE ELEMENTS AND REBUILD command)
 - SAI_REMOVE_ELEMENT_AND_MODIFY_ZONES (REMOVE ELEMENT AND MODIFY ZONES
   command)

The physical element types and physical element health values reported by
the GET PHYSICAL ELEMENT STATUS command are also defined.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 include/scsi/scsi_proto.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/scsi/scsi_proto.h b/include/scsi/scsi_proto.h
index 965cde7ebc5b..c6b4a4dc8d9c 100644
--- a/include/scsi/scsi_proto.h
+++ b/include/scsi/scsi_proto.h
@@ -129,6 +129,10 @@
 #define SAI_GET_LBA_STATUS    0x12
 #define SAI_REPORT_REFERRALS  0x13
 #define SAI_GET_STREAM_STATUS 0x16
+#define SAI_GET_PHYSICAL_ELEMENT_STATUS 0x17
+#define SAI_REMOVE_ELEMENT_AND_TRUNCATE 0x18
+#define SAI_RESTORE_ELEMENTS_AND_REBUILD 0x19
+#define SAI_REMOVE_ELEMENT_AND_MODIFY_ZONES 0x1a
 /* values for maintenance in */
 #define MI_REPORT_IDENTIFYING_INFORMATION 0x05
 #define MI_REPORT_TARGET_PGS  0x0a
@@ -464,6 +468,25 @@ enum zbc_zone_alignment_method {
 	ZBC_CONSTANT_ZONE_START_OFFSET	= 0x8,
 };
 
+/* SCSI physical element types */
+enum scsi_phys_element_type {
+	SCSI_PHYS_ELEM_TYPE_ALL_ACCESS_STORAGE	= 0x1,
+	SCSI_PHYS_ELEM_TYPE_FRAC_ACCESS_STORAGE	= 0x2,
+};
+
+/* SCSI physical element health. */
+enum scsi_phys_element_health {
+	SCSI_PHYS_ELEM_HEALTH_NOT_REPORTED		= 0x00,
+	SCSI_PHYS_ELEM_HEALTH_WITHIN_SPEC_LIMITS	= 0x01,
+	SCSI_PHYS_ELEM_HEALTH_AT_SPEC_LIMITS		= 0x64,
+	SCSI_PHYS_ELEM_HEALTH_OUTSIDE_SPEC_LIMITS	= 0x65,
+	SCSI_PHYS_ELEM_HEALTH_DEPOP_REVOKE_ERR		= 0xFB,
+	SCSI_PHYS_ELEM_HEALTH_DEPOP_REVOKE_IN_PROGRESS	= 0xFC,
+	SCSI_PHYS_ELEM_HEALTH_DEPOP_ERR			= 0xFD,
+	SCSI_PHYS_ELEM_HEALTH_DEPOP_IN_PROGRESS		= 0xFE,
+	SCSI_PHYS_ELEM_HEALTH_DEPOP_OK			= 0xFF,
+};
+
 /* Version descriptor values for INQUIRY */
 enum scsi_version_descriptor {
 	SCSI_VERSION_DESCRIPTOR_FCP4	= 0x0a40,
-- 
2.54.0


