Return-Path: <linux-scsi+bounces-24169-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE0QLfhMF2q4AQgAu9opvQ
	(envelope-from <linux-scsi+bounces-24169-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 27 May 2026 21:58:48 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C195E9D3F
	for <lists+linux-scsi@lfdr.de>; Wed, 27 May 2026 21:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D41C301373D
	for <lists+linux-scsi@lfdr.de>; Wed, 27 May 2026 19:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825BF3B19D1;
	Wed, 27 May 2026 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="E8/TPWKm"
X-Original-To: linux-scsi@vger.kernel.org
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B13C2F3C26;
	Wed, 27 May 2026 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911923; cv=none; b=hYPZnXNSH3Z/JpWIhNVvqgmKqFnOH2PI60aW/jmw+NsG8tRy2iCTk4NybTa+zEdWvo2nSMrXLjZeqODC6q4Kb+EsLnM36lTik0NRgyiRlBJkVtOqa3VOkpU9caQPWTXyVMWyVJ+RR9Ryyw8GSf5xCpdu9y+oD5MfVQoVPkq0jCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911923; c=relaxed/simple;
	bh=WHaVe4lxP3vzySB73pwv+/q2GF2UEAHCOQH6XlTNEPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6v39z+U/7jZrn6GPSFSHWt5TScR3lHJC+ZmkMbaKSB/ZHt2bPohc+XC8lqw8+Y0yDtnaY0qvpIuEmqWYE+bSuvMx3nBVVL+Gi1mPq8t+82nsnIrc48V5jMq1vHgiqGIqZjSY6HfnMscIppA2ED2Su/Kom/8pPGgKQl0HtHznLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=E8/TPWKm; arc=none smtp.client-ip=173.37.86.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=982; q=dns/txt;
  s=iport01; t=1779911922; x=1781121522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ih4/4CQtXsRllMF+cu0QXC1vYWo60kbbCDWls6M2bSg=;
  b=E8/TPWKmTydkI2jihrJVSHkhfINaho4cSZDOyqz0iY6obggDVL+S0W0O
   cJ4nm28fHYCqLUjbboh3gXo1f6iflW5zh3NmimcQkQz3PBd9pNiPoB8Ry
   KSg/CK4Bt5jmDMJa6mtF4gNpRc0DidnLPcru7Yeuoe5XZe4TizRzFRInL
   l6FmpxuoesrGD0plySuc/Y4NDaREzp/oQVq0Ff6hwUIP2oA6JKSfydl1I
   Sf9xk3r8TBs2FjSVOs3R+Klwj4+gNd+NZK0O2yFLsFlquDI1c09PVTAth
   pCV6bDUOg/oNR0ViJGXtgU/XEwQGO/OEwP6WiAGICqsaIfhx1UWh2MkB4
   A==;
X-CSE-ConnectionGUID: VlR4YvZpSjqGpmuF/Pjoug==
X-CSE-MsgGUID: kTeyuWDPR8Gyr9i3tLKDBQ==
X-IPAS-Result: =?us-ascii?q?A0BBAgA7TBdq/5P/Ja1aHgEBCxIMggULgleBUEMZMJQqo?=
 =?us-ascii?q?D+Bfg8BAQEPUQQBAYUGAo0yAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQsBAQUBA?=
 =?us-ascii?q?QECAQcFgQ4ThlyGWwIBAzIBRhBRVhmDAoJ0A7RfgiyBAd5BgWQBCxQBgTiNX?=
 =?us-ascii?q?HSEeycVBoFJRIR9gVKCOIEGhXcEgxwSjxFIgR4DWSwBVRMNCgsHBYFmAzUSK?=
 =?us-ascii?q?hVuMh2BIz4XgQsbBwWBS3ZyaoEFhRgjJgNOgS2Bf10DCxgNSBEsNxQbBD5uB?=
 =?us-ascii?q?4p1Gg+CMYEOgTGBD6YOoQ6EJqFbGjOqa5kGqUCBaDyBWTMaCBsVgyJTGQ/dK?=
 =?us-ascii?q?CcyPQIHAgcOAwuRaIF9AQE?=
IronPort-Data: A9a23:s1osB6Nv3ROCaDjvrR1UlsFynXyQoLVcMsEvi/4bfWQNrUoj0jwHy
 zEfCG6DM/jYZGD2et93b4qy80wO7cfdnddhGXM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFTmE+kvF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WV/lV
 e/a+ZWFZgf4gWEsaAr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj68tqNh0HI78AweRuLnlL6
 NJfEDIKcx/W0opawJrjIgVtrt4oIM+uOMYUvWttiGiBS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzM3wsYDUXUrsTIJE3hvupgnD8WzZZs1mS46Ew5gA/ySQtgOW9a4WFIYLiqcN9nXqVt
 3/501zDUj4LLo2ekiah0V6Gv7qa9c/8cMdIfFGizdZqiUee7m8eEhsbUR28u/bRokyzWdh3L
 00S5zporKI3skesS7HVWhSivH+C+AYRR9dKCOA8wAaXw6HQ7kCSAW1sZjdNYd8hrMgrbSYn2
 l+Ag5XiAjkHmL+QRHSQ+beVhSm/NSgcMSkJYipsZREI/dT5u6kpgx7PR8olG6mw5vXxFSz2y
 DmMhDMjnLhVhskOv42//Fbak3evq4LPQwod+AraRCSm4xl/aYrjYJangXDf7PBdPMOCRUKAl
 GYLltLY7+0UC5yJ0iuXT40w8KqB/f2JNnjYxFVoBZRkrmzr8H+4docW6zZ7TKt0Dvs5lfbSS
 Be7kWtsCFV7ZRNGsYcfj1qNNvkX
IronPort-HdrOrdr: A9a23:x4wcZKMtcO8NSMBcTgujsMiBIKoaSvp037Dk7SxMoHtuA6ilfq
 +V8sjzuSWftN9VYgBCpTniAtjkfZq/z/9ICOAqVN/IYOClghrLEGgI1+TfKlPbdhHWx6p0yb
 pgf69iCNf5EFR2yfrh7BLQKadG/DD+ysCVrNab6WtxRgd3bKwlxQJ4BgGHVnBSfmB9dPwE/F
 723Ls+m9JmEk5nF/iGOg==
X-Talos-CUID: 9a23:Z7rEmm2zM3bJ7MuBqIOgy7xfJMQfLkzD/m/rIVaXEWN0ZvqtS1iN9/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3A2I003Azcx8KeW12/yLDZbF3IxSOaqKeSBVEQrrk?=
 =?us-ascii?q?+gZmrJDYhOmyBqBebaLZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,172,1774310400"; 
   d="scan'208";a="485837836"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 27 May 2026 19:58:41 +0000
Received: from fedora.lan?044cisco.com (unknown [10.188.14.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kartilak@cisco.com)
	by rcdn-l-core-10.cisco.com (Postfix) with ESMTPSA id 9740018000241;
	Wed, 27 May 2026 19:58:39 +0000 (GMT)
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
Subject: [PATCH v2 13/13] scsi: fnic: Bump up version number
Date: Wed, 27 May 2026 12:50:00 -0700
Message-ID: <20260527195000.8444-14-kartilak@cisco.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260527195000.8444-1-kartilak@cisco.com>
References: <20260527195000.8444-1-kartilak@cisco.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.188.14.55];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.188.14.55, [10.188.14.55]
X-Outbound-Node: rcdn-l-core-10.cisco.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24169-lists,linux-scsi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_NEQ_ENVFROM(0.00)[kartilak@cisco.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[cisco.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cisco.com:email,cisco.com:mid,cisco.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 38C195E9D3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Bump up version number to 1.9.0.0.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Reviewed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Reviewed-by: Arun Easi <aeasi@cisco.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Lee Duncan <lduncan@suse.com>
Tested-by: Karan Tilak Kumar <kartilak@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
Co-developed-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/scsi/fnic/fnic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index 951549aff521..7a46b3ce0cb3 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -31,7 +31,7 @@
 
 #define DRV_NAME		"fnic"
 #define DRV_DESCRIPTION		"Cisco FCoE HBA Driver"
-#define DRV_VERSION		"1.8.0.3"
+#define DRV_VERSION		"1.9.0.0"
 #define PFX			DRV_NAME ": "
 #define DFX                     DRV_NAME "%d: "
 
-- 
2.47.1


