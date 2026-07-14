Return-Path: <linux-scsi+bounces-26092-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a5UQDRaFVWpmpgAAu9opvQ
	(envelope-from <linux-scsi+bounces-26092-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 02:38:46 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE49074FE44
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 02:38:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QNgOHlQb;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26092-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26092-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89EB73036754
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 00:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3281A9F8D;
	Tue, 14 Jul 2026 00:38:03 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EE51A8F97
	for <linux-scsi@vger.kernel.org>; Tue, 14 Jul 2026 00:38:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783989483; cv=none; b=WLWR1uiZPI9a2i+Pd6vVzlwYwlNKhCjQ92cByrnI6+heLjvRBg/oixrDXsbiU2dAeX+gCcehqTbQWbf6tCKM8s1H5xQuEfu7H5yY5Y+oWXZeaHiLVk+W3BUCKBUgUPhdNFvCO/9tm9rPgYPbqPP7SyJ6vShzgIEGBSpz5Zn7C5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783989483; c=relaxed/simple;
	bh=bdwMNcZVjf0I1CDFWjmxuzGycazN9aJDtvxsS5g9hFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kBwUXERjYrvMFW+hQbMqaaZsvr4t42ln68yy1Q6Ky3J0LyjCF1UyFVxNLHorPw+TJ9xFnvnIvTUQIzm+Q1MVRTLLNizZuQvV03g3FSAj9fHGmsl9AnnN3O6BgBCmlbpeboatH1DjNWOnhX4al848SHl2Jexzq/xuuo3plwd3rr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNgOHlQb; arc=none smtp.client-ip=209.85.219.43
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-9034b6b7674so24065136d6.0
        for <linux-scsi@vger.kernel.org>; Mon, 13 Jul 2026 17:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783989481; x=1784594281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2CQIKIOUNHK4p/kK1ZVRgUxKnjETRbt3AMrCW5x1awc=;
        b=QNgOHlQbQPijlIFnlsGmiavCoAMkKcVYdiGl8ccUwyqXVmnFyi6Z9mT5Vkb2YATH2U
         yst4rXYof/LJlC7huBOP8WOqwoCkomWFBGOo8zityvLVPks1AzsW+lBqUfp2i2IZ3Z9J
         uajPxVKS/GEyBZwR5qMhsdaU3nQzJT3rQYztsB7DkiyRakdub6e9VD3bTXU48vS99/C9
         ZJ8/Txhv+50YDc7XClvA4BebSAGz1kaPIqT4Qaew4YjqcCc6qqUQlFGzP79rbqbJY3Yl
         pYuoCmyX/UrjRf9NJRYQ4cRTfIUwPwvdvnazzCt1Vt4ioNUwjtxY8h0xkRg4mY9Q4SLq
         UVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783989481; x=1784594281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2CQIKIOUNHK4p/kK1ZVRgUxKnjETRbt3AMrCW5x1awc=;
        b=TWz+QQAN7H+8sTp+9kyHAl5VsRMyFhqnehCjGzta6UDJ66jqVm59ZZNl+sWpY7IwjD
         uEtBybn3W0HtsQMnR8mZl2ItA62F6B2R2qRmPU9xH/EsrV/uwjiFyTo/LqMZg9h/FYkM
         vPzfIK6q9Z6RnnNn9c0mBRg5etFxb5gpdT0+OchMISpqh96ibwsP8Dv20ILd9jgJaLRU
         wNW5+zyXBuKoMrYi75RtQRiffT8rHOROpRth5YORpNH5w/fFvC1V9bMAMYcVkqmYchkN
         mvHyJP6Et0aQ2D1uZfvYsxr1GYG3BlPlfKsh03Fn0lwKOkVZrK+hGVNfyQPcs6V8III2
         ENVQ==
X-Gm-Message-State: AOJu0Yw2G5907KLb1noRue/1KN60r1fwWcjq4AC0lcVhKKKb5ahpCYLg
	PZY9+hTi8b4ixVGyZq/Cr/HQ5/d4LSbsaaZetdwr/08VFjyE0XBf7n8uSAd2XpM6uLI=
X-Gm-Gg: AfdE7ckLbHqoMj9quQ+AhOymDktBRT8xitSaF4L1vWLcNi5HTa/yvn6v0+x40a6ePPN
	LWhlYyxTF/q0DMJHnah12EmmV5IORCtc2oMzLSaIfKfvikee8JtyGc36X5H3SOq0IAtoFzjh9AP
	rDRI6Rk7sm54+Hra+Nl5W9T1oo9dBb3UWm6dntjQsRS3mdrDfhhQfgAHxjKBBPkyWrs8xhkQklY
	bZ/G498ofLoohuXqtXNd4K+SP0UOD01yLu4pLac0nv+mBwsbRmGUK01R5nxIqElNrvOBAmdZsCs
	m6nd9aFvYgS4VQULEnjbNWqjImeelEfomAag4JbFIPcs+7I/x3sAu3ZFXj/isve2DfqkaosmWY/
	0czNLgUa3yQq/7opubN17ihHRhdwx+DPHLh7wzMQQM2ZlTHRlfPhDmYr+Xl3jWxctWHgkLySsGq
	d7Yld60Sz3MyIpnQz246KWe+1m0aXv+7dojmPssS+xSEXEDq+TfvTK5tXV5V4tYMI5NluurnGQO
	lmEXMI7c3lkKPsu/3/VtHqq301Pf70L7WeUpGfCdpA=
X-Received: by 2002:a05:620a:40c9:b0:92e:72a4:f291 with SMTP id af79cd13be357-93083c771aamr128567685a.35.1783989480944;
        Mon, 13 Jul 2026 17:38:00 -0700 (PDT)
Received: from dhcp-10-231-55-133.dhcp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d6c28bsm1289899185a.46.2026.07.13.17.38.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2026 17:38:00 -0700 (PDT)
From: Justin Tee <justintee8345@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: jsmart833426@gmail.com,
	justin.tee@broadcom.com,
	Justin Tee <justintee8345@gmail.com>
Subject: [PATCH v3 14/14] lpfc: Update lpfc version to 15.0.0.1
Date: Mon, 13 Jul 2026 18:18:12 -0700
Message-Id: <20260714011812.106753-15-justintee8345@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20260714011812.106753-1-justintee8345@gmail.com>
References: <20260714011812.106753-1-justintee8345@gmail.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-26092-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[justintee8345@gmail.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-scsi@vger.kernel.org,m:jsmart833426@gmail.com,m:justin.tee@broadcom.com,m:justintee8345@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justintee8345@gmail.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE49074FE44

Update lpfc version to 15.0.0.1

Signed-off-by: Justin Tee <justintee8345@gmail.com>
---
 drivers/scsi/lpfc/lpfc_version.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_version.h b/drivers/scsi/lpfc/lpfc_version.h
index d6e6e436fbfc..7df63d118234 100644
--- a/drivers/scsi/lpfc/lpfc_version.h
+++ b/drivers/scsi/lpfc/lpfc_version.h
@@ -20,7 +20,7 @@
  * included with this package.                                     *
  *******************************************************************/
 
-#define LPFC_DRIVER_VERSION "15.0.0.0"
+#define LPFC_DRIVER_VERSION "15.0.0.1"
 #define LPFC_DRIVER_NAME		"lpfc"
 
 /* Used for SLI 2/3 */
-- 
2.38.0


