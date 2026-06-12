Return-Path: <linux-scsi+bounces-24913-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eXkhBkVNLGpIPAQAu9opvQ
	(envelope-from <linux-scsi+bounces-24913-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 20:17:41 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3EC67B9A0
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 20:17:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=YlfH9MTw;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24913-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24913-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cisco.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25205300680B
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 18:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A6C37FF60;
	Fri, 12 Jun 2026 18:17:38 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5981379C43;
	Fri, 12 Jun 2026 18:17:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288258; cv=none; b=qbrZ7aav0d6LiYjP+QsIoB17Tvz6FgO4oSpgtkkSxUV8BH+VfRRiaPRlPkOoyTQ5UvQiWMGwJYDw1gUlxvwVCTIP8Qktrl4YSDh26oF94+Ki/99EQpoNuoqFeGkCQLVB8ldinJ5HdKxGvLEVnE6KvZDgHFf+xkSSKcP4jfy9xSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288258; c=relaxed/simple;
	bh=WHaVe4lxP3vzySB73pwv+/q2GF2UEAHCOQH6XlTNEPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEexsKtHccr9au/ejJcjmwYBgSY5LlLRHTLP7sfM4XqxIGIDID3jlxqmr0Jm3X0tJxdIzlnRP0wQk7dvDd+GnEnmir+HBbDzj076kcsB4MweTGtHS62kgPj0hWH/qp7qRdvCe1blviRys+LthXqvp9va2sa9FJQxNq+HVPB1W6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=YlfH9MTw; arc=none smtp.client-ip=173.37.86.80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=982; q=dns/txt;
  s=iport01; t=1781288256; x=1782497856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ih4/4CQtXsRllMF+cu0QXC1vYWo60kbbCDWls6M2bSg=;
  b=YlfH9MTw2Wx7nAwY1P/RYsfbZxDrosXhfUIL5puMNQFfzxjQb6jUZxyh
   cGTxw6dV5jdNPSoPY7L+JyT3RBKwcSyqIxYOmoFQ058kh9L3u1YKn3MJ3
   3bGa075c6V11ZDC+VVPO7gD6YhtG7WX2wtkPXfKbfU0Jnwxu13ncgW2GW
   s8U39qCh2t6AIDqm/rCLLp+4AT4azociZLOwc+KLi0LLjw6/OwUtMFU3t
   lXsoIbffrSsJd1nKtRSHECXnFGU4u8Tv3Bb91n8mz6uQodKjpoflEDtx1
   4a09sfGRVxpOpZlC2Cly9GR6VBEbX9VzBAyJl9Gm6kdj4AqbgnjMVXjqR
   g==;
X-CSE-ConnectionGUID: kVGF1BY3QY6jR2mzgNRFTQ==
X-CSE-MsgGUID: IOee0ABGTI+n658fj/eUjQ==
X-IPAS-Result: =?us-ascii?q?A0BCAgDoSyxq/4v/Ja1aglmCV4FSQxkwlCqgP4F+DwEBA?=
 =?us-ascii?q?Q9RBAEBhQYCjUMCJjQJDgECBAMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBD?=
 =?us-ascii?q?hOGXIZbAgEDMgFGEFFWGYMCgnQDtV2CLIEB3kOBZgELFAGBOI1edIR8JxUGg?=
 =?us-ascii?q?UlEhH6BUoI4gQaFeASDHBKQd0iBHgNZLAFVEw0KCwcFgWYDNRIqFW4yHYEjP?=
 =?us-ascii?q?heBDBsHBYFKgStqgQOFDSMfAzl/gXSBKGdpFTA1gQEBER0DCxgNSBEsNxQbB?=
 =?us-ascii?q?D5uB4xIFw+CPoEOgTGBD6YOoQ+EJ6FbGjOqbJkIqUKBaDyBWTMaCBsVgyJTG?=
 =?us-ascii?q?Q/ZdicyPQIHAgcOAwuRaIF9AQE?=
IronPort-Data: A9a23:cmaP9qPXaDX7KGTvrR1UlsFynXyQoLVcMsEvi/4bfWQNrUpz3jwEm
 mUbDWqBa/qNYjOjKdgjYY7n9RwB68WEn9c3T3M5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFTmE+kvF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WV/lV
 e/a+ZWFZgf7gmQsaAr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj6/ZQI29vF7xDw9cpA1sU8
 O4XDgojUinW0opawJrjIgVtrt4oIM+uOMYUvWttiGmDS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2M0PXwsYDUXUrsTIJE3hvupgnD8WzZZs1mS46Ew5gA/ySQtgeK8aouKJ4DiqcN9v2GVq
 zrv1UvFI1IcaoHPxzjC/0+uv7qa9c/8cMdIfFGizdZqiUee7m8eEhsbUR28u/bRokyzWdh3L
 00S5zporKI3skesS7HVWhSivH+C+AYRR9dKCOA8wAaXw6HQ7kCSAW1sZjdNYd8hrMgrbSYn2
 l+Ag5XiAjkHmL+QRHSQ+beVhSm/NSgcMSkJYipsZREI/dT5u6kpgx7PR8olG6mw5vXxFSz2y
 DmMhDMjnLhVhskOv42//Fbak3evq4LPQwod+AraRCSm4xl/aYrjYJangXDf7PBdPMOCRUKAl
 GYLltLY7+0UC5yJ0iuXT40w8KqB/f2JNnjYxFVoBZRkr27r8H+4docW6zZ7TKt0Dvs5lfbSS
 Be7kWtsCFV7YBNGsYcfj1qNNvkX
IronPort-HdrOrdr: A9a23:8Z3f8aFHK6VmXUnypLqEIseALOsnbusQ8zAXPo5KJSC9Ffbo8/
 xG88506faZslwssTQb6LO90cq7MBbhHPxOgLX5VI3KNGLbUSmTXeNfBODZrAEIdReSysdtkY
 99bqlzD8DxB1Bmgcu/3BO1CL8bsb66GdiT5dv2/jNKURxgbb1m4kNSDwaWFVAzeSx9bKBJcq
 Z1IqF81kKdkbN9VLXDOkU4
X-Talos-CUID: 9a23:sAopBWBI2Cghzub6EypZ22BNMPF+S0yDzk2KJl23L1xHdITAHA==
X-Talos-MUID: 9a23:8LSHHwtEbYLPm86Hjs2npRZvOZ9ByYuSKQMLz8hWtcvDOBFyAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,201,1774310400"; 
   d="scan'208";a="492929754"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 12 Jun 2026 18:17:28 +0000
Received: from fedora.lan?044cisco.com (unknown [10.188.127.244])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kartilak@cisco.com)
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTPSA id 3A2CD180007DA;
	Fri, 12 Jun 2026 18:17:27 +0000 (GMT)
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
Subject: [PATCH v4 13/13] scsi: fnic: Bump up version number
Date: Fri, 12 Jun 2026 11:09:18 -0700
Message-ID: <20260612180918.8554-14-kartilak@cisco.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260612180918.8554-1-kartilak@cisco.com>
References: <20260612180918.8554-1-kartilak@cisco.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.188.127.244];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.188.127.244, [10.188.127.244]
X-Outbound-Node: rcdn-l-core-02.cisco.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[cisco.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24913-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:sebaddel@cisco.com,m:arulponn@cisco.com,m:djhawar@cisco.com,m:gcboffa@cisco.com,m:mkai2@cisco.com,m:satishkh@cisco.com,m:aeasi@cisco.com,m:jejb@linux.ibm.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jmeneghi@redhat.com,m:revers@redhat.com,m:adakopou@redhat.com,m:lduncan@suse.com,m:kartilak@cisco.com,m:hare@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kartilak@cisco.com,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,cisco.com:dkim,cisco.com:email,cisco.com:mid,cisco.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB3EC67B9A0

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


