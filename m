Return-Path: <linux-scsi+bounces-24504-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AZ2eKSJgI2qRrgEAu9opvQ
	(envelope-from <linux-scsi+bounces-24504-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sat, 06 Jun 2026 01:47:46 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B4F64BD97
	for <lists+linux-scsi@lfdr.de>; Sat, 06 Jun 2026 01:47:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=Sf7qFkrn;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24504-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24504-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cisco.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21CD8301F492
	for <lists+linux-scsi@lfdr.de>; Fri,  5 Jun 2026 23:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E3A36A36B;
	Fri,  5 Jun 2026 23:47:40 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B8930AAB8;
	Fri,  5 Jun 2026 23:47:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780703260; cv=none; b=mQV4cMRGs9sW3OX97LTMqsaGxO4t+Sr+s7HRfPrrFZV6+AndwVIjlyjHJGDsE3Ql9HjcyYa3sjeZ+f3Mgp1blQ1IBEqPdRDQVo0Gdg1QdtYS1anMWw8M2hw5Zf20KJ8UbYy7e61dtWQQwvBKeTm7TMDmOfRlZeee5ZIw6OU+SU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780703260; c=relaxed/simple;
	bh=ZCNcv4P7AkVPotlXpvPK5iNoL4fsncxpnHstGG2BLQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTcggKPVHkW+T8rR8d8kdTR5CmEw5NSmNrNf8zHyGRKheFtmNO2Dsg/2K5UAZMNH0ajyHIkCHRm4TgtpAVASCXno+ztllBhmVbftyAWATtJUcdE21J62LaKqtCmehVzH2ekf/JY2f9HrlQ7AFg+BKkw0R8m5zNE0kZAydC80j3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=Sf7qFkrn; arc=none smtp.client-ip=173.37.86.76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2821; q=dns/txt;
  s=iport01; t=1780703258; x=1781912858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sLADWQIE9KTz+/SzYGCIkSHf9EF3QcETYxY+2sa7yfs=;
  b=Sf7qFkrndKEnsxbjqXRo/ZjHVkQUj/b3o/GfZNzPBfN6f9+0vlPFbmVM
   +pdaOgOqseZJnntGDxgW5XAn9KK2T4kukIUa0YYeN07FWcQspo76XTRxj
   bJ7ZLLjsYRDS6so16b82Z4Lbrg6MnCGCqa85vd5KPdy3ARIv6XFmfBon9
   cyXh+zV9QcoBoBCQ1ZvDo8z0oVQNwHcaFNNa/htV3R6rFsLYcmdA7igai
   UZ77s7i2krQ0vDbIuBg5Z+gZNqjuv1C0rCyieUsjbTMeuBf8EUyUVaE2t
   Et10YxQTgkLX3mMVE0LqL9OF7hzn+0WfgfT2SI4saWtv7rzlwi52GaYtE
   A==;
X-CSE-ConnectionGUID: dLg76KTsQ+Gd8UxqCzr0WQ==
X-CSE-MsgGUID: 1olCJQ6UTL6V60K3c0oxAQ==
X-IPAS-Result: =?us-ascii?q?A0BCAgCwXiNq/5P/Ja1aglmCV4FSQxkwlCqgP4F+DwEBA?=
 =?us-ascii?q?Q9RBAEBhQYCjTMCJjQJDgECBAMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBD?=
 =?us-ascii?q?hOGXIZbAgEDJwsBRhBRVhmDAoJ0A7QSgXkzgQHeQoFmAQsUAYE4jV10hHsnF?=
 =?us-ascii?q?QaBSUSBFYNogVKDPoV3BIMcEpBcSIEeA1ksAVUTDQoLBwWBZgM1EioVbjIdg?=
 =?us-ascii?q?SM+F4ELGwcFgUqBSWqBBIUSIx8DOYEXgXyBKGdpFTE6FwMLGA1IESw3FBsEP?=
 =?us-ascii?q?m4HjC4XD4I3gQ+BMGcok0+QHoIhoQ6EJqFbGjOqay6YWKlAgWg8gVkzGggbF?=
 =?us-ascii?q?YMiUxkPji0WyDwnMj0BAQcCBw4DC4FokX0BAQ?=
IronPort-Data: A9a23:Do184qjBfCY89NVi2g1IGSRWX161kREKZh0ujC45NGQN5FlHY01je
 htvWDyBM/3eNDf0e9ByboXn9h4D6pXSyNFqHAtlqXhjEXhjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOOn9SUgvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZeDULOZ82QsaDxMtfre8EoHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqUU3ukoX0Jy7
 sVbBzxdUwCarPCsmI2CH7wEasQLdKEHPasFsX1miDWcBvE8TNWaG+PB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWZgh/5JEWxI9EglH8eidEqVacpoI84nPYy0p6172F3N/9Jo3SGp8OzhvJz
 o7A1z3+Bjo4DYKi9R7bzCz0pbTExSTrcbtHQdVU8dYv2jV/3Fc7CBQMWHO4rOO/h0r4XMhQQ
 2QW9ygkhawz8lG7CNj3Wluzp3vslhsVQcZRFasi5R2A0LHZ5S6eHGEPSjMHY9sj3Oc/STUp0
 UeOgvvzCDBvuaHTQnWYnp+WqD60NCcVLEcYaCMERBdD6N7myKkpgwzCVM1LCqO5jtTpXzr3x
 liiqCQjgb4ai+YQyr62u1vAhlqEopnPUx5w5QjNWG+hxh12aZTjZIGy71Xfq/FaI+6xSliHo
 WhBgMOF7cgQApyX0i+AWuMAGPeu/fntDdHHqURkE59k83Gm/GSuONkIpjp/P0xudM0DfFcFf
 XPuhO+Y37cLVFPCUEO9S9vZ5xgCpUQ4KenYaw==
IronPort-HdrOrdr: A9a23:ejXllq8XAE5aUrbNtGhuk+ASI+orL9Y04lQ7vn2ZhyY4TiX+rb
 HLoB1173HJYVoqMk3I3OrwW5VoIkmskKKdg7NxAV7KZmCP01dAbrsSj7cKqAeOJ8SRzINg/J
 YlW7RiCdH2EFhxhdv37U2FCdo6qeP3l5xA/d2/815dCSd3dqpn8wB1TiyfEkFwWU16IKBRLu
 v72iKCzADQAUj+qa+AdwA4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AqVDRMGlSqXuWmeC1AI3KwplBl/7XOXH5wyiOAHO?=
 =?us-ascii?q?jMCVGRO2oWUa76rk8rPM7zg=3D=3D?=
X-Talos-MUID: 9a23:/1AbjwaRhvo2FuBT7jjorxNbavpUx/qQVhguyp5evNmtDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,189,1774310400"; 
   d="scan'208";a="490723859"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 05 Jun 2026 23:46:28 +0000
Received: from fedora.lan?044cisco.com (unknown [10.188.102.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kartilak@cisco.com)
	by rcdn-l-core-10.cisco.com (Postfix) with ESMTPSA id 2598218000887;
	Fri,  5 Jun 2026 23:46:27 +0000 (GMT)
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
Subject: [PATCH v3 02/13] scsi: fnic: Use fnic_num for non-SCSI identifiers
Date: Fri,  5 Jun 2026 16:45:27 -0700
Message-ID: <20260605234538.7950-3-kartilak@cisco.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260605234538.7950-1-kartilak@cisco.com>
References: <20260605234538.7950-1-kartilak@cisco.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.188.102.68];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.188.102.68, [10.188.102.68]
X-Outbound-Node: rcdn-l-core-10.cisco.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24504-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sebaddel@cisco.com,m:arulponn@cisco.com,m:djhawar@cisco.com,m:gcboffa@cisco.com,m:mkai2@cisco.com,m:satishkh@cisco.com,m:aeasi@cisco.com,m:jejb@linux.ibm.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jmeneghi@redhat.com,m:revers@redhat.com,m:adakopou@redhat.com,m:lduncan@suse.com,m:kartilak@cisco.com,m:hare@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER(0.00)[kartilak@cisco.com,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[cisco.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartilak@cisco.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:mid,cisco.com:dkim,cisco.com:from_mime,cisco.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21B4F64BD97

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


