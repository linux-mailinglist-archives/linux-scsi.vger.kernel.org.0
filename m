Return-Path: <linux-scsi+bounces-25209-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XnF7DL9gO2r2WwgAu9opvQ
	(envelope-from <linux-scsi+bounces-25209-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Jun 2026 06:44:47 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E466BB467
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Jun 2026 06:44:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=j7KH251n;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25209-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25209-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cisco.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEE76302BDC9
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Jun 2026 04:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C10231F980;
	Wed, 24 Jun 2026 04:44:41 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE5635BDDB;
	Wed, 24 Jun 2026 04:44:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782276281; cv=none; b=IYo2RwvJoTqC8s3Zie4rmOA/L56uSx1ANoVBtwiERcV6bEAr1Ag4ggQdjW2RxuOBvLSwv7z9urPNTtE6kt+vzPRDygvdoDD0ZxwbHcab57fxlzWsI8Y95gW+Do+XGW+9b/N/Nm86OuEQGfwvZuiOTitleldD5fKQlo8tjMqewzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782276281; c=relaxed/simple;
	bh=ZCNcv4P7AkVPotlXpvPK5iNoL4fsncxpnHstGG2BLQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUpRVai8a9oGsHsSmAmZI/DF883AMBnWQpw2zPz6rKcx4wZm/lCC0ATx47MyP5QfTa4j9x/He+nBWVP+RqTYQk9qE2g3RO+a3i/+ZJA+JOsttSz9dlDXjb06Q9S+XFsbfrnvqxYCO9zRlMG8xu6hgET08rceL/d1Xk5AaqvkiZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=j7KH251n; arc=none smtp.client-ip=173.37.86.77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2821; q=dns/txt;
  s=iport01; t=1782276279; x=1783485879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sLADWQIE9KTz+/SzYGCIkSHf9EF3QcETYxY+2sa7yfs=;
  b=j7KH251n3iwtAdyo4f4tORo0aih/ilodjDvbaTlBKJZMjj8OqSBVjjTQ
   qQ4Eg/GpuSgk9BK0L1111oECVRCXudCUbIBvACjUgejw9GeCb7Q/sgERi
   m3geQragMrLyxkOSbloMC1U4MfTrg201TIqH4OC4rHg03GwGy1dsPox57
   f0UbTzoFnpZaGBAFE6NlJuavYMGGH8Yl/EoQ9MLO3ggDuErIiyDNM6bvT
   y8qFPiT13hR6CzR+6oJG6mczl/gBk38SvLUXbB+AixAeFH50fu/3eCpaK
   sx9B7oMF2vSaFJtcQ5hi9f72coOyDb1uepi24bwR14VgYDzQqCVPFS3zo
   g==;
X-CSE-ConnectionGUID: rJ0NzyX7RqWvkqh/1xr2Kw==
X-CSE-MsgGUID: eE5KiUyXSOmO9crNhwgKbA==
X-IPAS-Result: =?us-ascii?q?A0BCAgDmXjtq/4//Ja1aglmCV4FSQxkwlCqgP4F+DwEBA?=
 =?us-ascii?q?Q9RBAEBhQYCjUoCJjQJDgECBAMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBD?=
 =?us-ascii?q?hOGXIZbAgEDJwsBRhBRVhmDAoJ0A7I5gXkzgQHeQ4FmAQsUAYE4jV50hHwnF?=
 =?us-ascii?q?QaBSUSBFYNpgVKDPoV4BIMcEpECSIEeA1ksAVUTDQoLBwWBZgM1EioVbjIdg?=
 =?us-ascii?q?SM+F4EMGwcFgR2BboEEhQIjHwM5f4E/gSRkZhUwNYEBAREfCoE1AwsYDUgRL?=
 =?us-ascii?q?DcUGwQ+bgeMXRcPgj2BD4EwZyiTT5AegiGhD4QnoVsaM6psLphaqUKBaDyBW?=
 =?us-ascii?q?TMaCBsVgyJTGQ+OLRbSOicyPQEBBwIHDgMLgWiRfQEB?=
IronPort-Data: A9a23:PSFB7Kod1DrDyU3ZmwJ3zHpJQtleBmLpZBIvgKrLsJaIsI4StFCzt
 garIBnVOPeINzGneookbIW09h4Bu5Tcy4NmHgE5+X9hQ3wQp+PIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9j8kif3gqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYgPNNwJcaDpOtfrd8kg35pwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0vxVWUdc5
 MxHEikycBOah6Xv0KjhafY506zPLOGzVG8ekmtrwTecCbMtRorOBv2Uo9RZxzw3wMtJGJ4yZ
 eJANmEpN0uGOUASfA5LU/rSn8/w7pX7Wz5Rsk6UoaM0y2PS1wd2lrPqNbI5f/TWFJQOxx7B/
 DiuE2LRDzxHF92i2Aq+1XeL1+TVuyPkV6EYPejtnhJtqBjJroAJMzUWXEG2ifq0kEizX5RYM
 UN80igjr6Ia8E2tU8m7Xhe95nWDu3Y0XtNKD+w8rhmA1qfO+AufLm8eRzVFZZots8pebTUm3
 1yOh9T0LSZivL2cVTSW8bL8hTG3NC4YIm8DTTUJQQsM/5/op4RbpgjCUNt5C4avg9H1EC22y
 DePxAA6i6gVhscN/76m5l2BiDWpzrDNTwgo9kDUU3ij4wdReoGofcqr5ELd4PIGK5yWJnGFv
 X4Zi42F5/sPJY+CmTbLQ+gXGrytofGfP1XhbUVHBZIt8XGpvnWkZ40VuG84L0ZyOcFCcjjsC
 KPOhT5sCFZoFCPCRcdKj0iZUqzGEYCI+QzZa83p
IronPort-HdrOrdr: A9a23:/RcNXaDNtQXqOyXlHelm55DYdb4zR+YMi2TDGXocdfUzSL39qy
 nAppomPHPP4gr5HUtQ+uxoW5PwJE80l6QV3WB5B97LNzUO+lHYTr2KhrGM/9SPIUDD398Y/b
 t8cqR4Fd37BUV3gILH+gWieuxQp+VviJrJuc7ui1FwUAptd6Zsqy19CgqdDwlKYTMuP+teKH
 JZjfA33wZJvh8sH72GOkU=
X-Talos-CUID: 9a23:gVzxU2/wNkCOIR1n6CaVv1Q2QuY3Y02C9m7vPUyhCSEwWKfPakDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AMQp+Gw0Wq3vhyAieJvgNL1M8XzUj7onzK0EwgKU?=
 =?us-ascii?q?9nMyjZCdqHTeCgxe9a9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,221,1774310400"; 
   d="scan'208";a="499310122"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Jun 2026 04:44:33 +0000
Received: from fedora.lan?044cisco.com (unknown [10.188.122.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kartilak@cisco.com)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPSA id B913C180003A1;
	Wed, 24 Jun 2026 04:44:31 +0000 (GMT)
From: Karan Tilak Kumar <kartilak@cisco.com>
To: sebaddel@cisco.com
Cc: arulponn@cisco.com,
	djhawar@cisco.com,
	gcboffa@cisco.com,
	mkai2@cisco.com,
	satishkh@cisco.com,
	aeasi@cisco.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com,
	revers@redhat.com,
	adakopou@redhat.com,
	lduncan@suse.com,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH v5 02/13] scsi: fnic: Use fnic_num for non-SCSI identifiers
Date: Tue, 23 Jun 2026 21:43:23 -0700
Message-ID: <20260624044334.3079-3-kartilak@cisco.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260624044334.3079-1-kartilak@cisco.com>
References: <20260624044334.3079-1-kartilak@cisco.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.188.122.232];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.188.122.232, [10.188.122.232]
X-Outbound-Node: rcdn-l-core-06.cisco.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[cisco.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25209-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:sebaddel@cisco.com,m:arulponn@cisco.com,m:djhawar@cisco.com,m:gcboffa@cisco.com,m:mkai2@cisco.com,m:satishkh@cisco.com,m:aeasi@cisco.com,m:jejb@linux.ibm.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jmeneghi@redhat.com,m:revers@redhat.com,m:adakopou@redhat.com,m:lduncan@suse.com,m:kartilak@cisco.com,m:hare@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kartilak@cisco.com,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartilak@cisco.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cisco.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email,cisco.com:dkim,cisco.com:email,cisco.com:mid,cisco.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63E466BB467

Use SCSI host numbers only for FCP initiator paths.

Name NVMe-facing FDMI and debugfs entries with fnic_num, and record
trace events with the driver instance number.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Reviewed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Reviewed-by: Arun Easi <aeasi@cisco.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Lee Duncan <lduncan@suse.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
Co-developed-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/scsi/fnic/fdls_disc.c    | 8 ++++++--
 drivers/scsi/fnic/fnic_debugfs.c | 5 ++++-
 drivers/scsi/fnic/fnic_scsi.c    | 2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/fnic/fdls_disc.c b/drivers/scsi/fnic/fdls_disc.c
index 5880ca28a0ad..f665460ef62c 100644
--- a/drivers/scsi/fnic/fdls_disc.c
+++ b/drivers/scsi/fnic/fdls_disc.c
@@ -2083,8 +2083,12 @@ static void fdls_fdmi_register_pa(struct fnic_iport_s *iport)
 	fnic_fdmi_attr_set(fdmi_attr, FNIC_FDMI_TYPE_MAX_FRAME_SIZE,
 		FNIC_FDMI_MFS_LEN, data, &attr_off_bytes);
 
-	snprintf(tmp_data, FNIC_FDMI_OS_NAME_LEN - 1, "host%d",
-		 fnic->host->host_no);
+	if (IS_FNIC_FCP_INITIATOR(fnic))
+		snprintf(tmp_data, FNIC_FDMI_OS_NAME_LEN - 1, "host%d",
+			fnic->host->host_no);
+	else if (IS_FNIC_NVME_INITIATOR(fnic))
+		snprintf(tmp_data, FNIC_FDMI_OS_NAME_LEN - 1, "nvfnic%d",
+			fnic->fnic_num);
 	strscpy_pad(data, tmp_data, FNIC_FDMI_OS_NAME_LEN);
 	fnic_fdmi_attr_set(fdmi_attr, FNIC_FDMI_TYPE_OS_NAME,
 		FNIC_FDMI_OS_NAME_LEN, data, &attr_off_bytes);
diff --git a/drivers/scsi/fnic/fnic_debugfs.c b/drivers/scsi/fnic/fnic_debugfs.c
index ba86964fb45e..467fba29ea5f 100644
--- a/drivers/scsi/fnic/fnic_debugfs.c
+++ b/drivers/scsi/fnic/fnic_debugfs.c
@@ -681,7 +681,10 @@ int fnic_stats_debugfs_init(struct fnic *fnic)
 {
 	char name[16];
 
-	snprintf(name, sizeof(name), "host%d", fnic->host->host_no);
+	if (IS_FNIC_FCP_INITIATOR(fnic))
+		snprintf(name, sizeof(name), "host%d", fnic->host->host_no);
+	else if (IS_FNIC_NVME_INITIATOR(fnic))
+		snprintf(name, sizeof(name), "nvfnic%d", fnic->fnic_num);
 
 	fnic->fnic_stats_debugfs_host = debugfs_create_dir(name,
 						fnic_stats_debugfs_root);
diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 0759540f6675..b92260583c67 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -894,7 +894,7 @@ static inline void fnic_fcpio_ack_handler(struct fnic *fnic,
 
 	spin_unlock_irqrestore(&fnic->wq_copy_lock[wq_index], flags);
 	FNIC_TRACE(fnic_fcpio_ack_handler,
-		  fnic->host->host_no, 0, 0, ox_id_tag[2], ox_id_tag[3],
+		  fnic->fnic_num, 0, 0, ox_id_tag[2], ox_id_tag[3],
 		  ox_id_tag[4], ox_id_tag[5]);
 }
 
-- 
2.47.1


