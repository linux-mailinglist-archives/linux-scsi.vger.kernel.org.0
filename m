Return-Path: <linux-scsi+bounces-20826-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGJDAEs+jmkMBQEAu9opvQ
	(envelope-from <linux-scsi+bounces-20826-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Feb 2026 21:55:39 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA6F131119
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Feb 2026 21:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74CCC3018717
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Feb 2026 20:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418B728467C;
	Thu, 12 Feb 2026 20:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRJT4lFC"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49F72ED84C
	for <linux-scsi@vger.kernel.org>; Thu, 12 Feb 2026 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770929736; cv=none; b=qnPpL1HWZKPeyvhDZ/5y0+cdxFqPAA7MSGYzn0lb2s4o65qvW79u+3YUiKhDXKU25UpO7yItfqqnbo7wQvA+LROxfYQBF5D1ruBZqpepEm1X1aHcJPuyCSto/AitSZFsaXk5/FnhTwfnwLsi44KxPpDObJ9B5fO6pTsbiObkZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770929736; c=relaxed/simple;
	bh=9YrUwoT6yywre+A11Pt1domoWAEFHxDOU1K5iNBV7Ug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcvOeWnN+VZ+vOBqmTmpdVgvmyGK33hrcATaIgkgEFru51laB0qsjnver+VrNreUfbex0N8m2tp2EVujMIpfd8GDt5g0oU9rCa4T2mk0wrKy4RsDfxKMzqdG8VbsNsc6BIQPwGcZJrQ3i41qbOKzZ18AmFs52uCOn8xNg0htybY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRJT4lFC; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c9f6b78ca4so42869385a.0
        for <linux-scsi@vger.kernel.org>; Thu, 12 Feb 2026 12:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770929734; x=1771534534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2B5cX3M8kAQkIlFcNAdyOkHvH6VNhopGxjq+hYOXLA=;
        b=NRJT4lFCbQP7M25wdJpKecfZVxj/7S9vu3jBY3VQpON8lhHLlj51EXdYcnW5pszwz1
         0sqBLD9Ahfhgpy8mo+2yrV5mqpkUn666wTHoG6ajEQ4Y9g8HcpqeC2VaeVnhy+CEIsO7
         rrtb//rdsyZ0XsX8PloAuAGw7UEncoPoNX0l/j4YHV/j2McFFhhZhY2cXY7OMGvy71+4
         aYpD1j9grvnqLuNK6pwRdVjgIBAzzU+pLWz+S/NjFiceaAYSt7S/7xW0jTkUX0Lbnrz5
         JFz+BvqBOoNWx61Ocq/rWmJMZMoj2LiCdvcTdxwlFgkyS27i+DpEIN+9+gn27LNo5F/U
         27sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770929734; x=1771534534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e2B5cX3M8kAQkIlFcNAdyOkHvH6VNhopGxjq+hYOXLA=;
        b=SWJsMoQwwD5ND9ZfwAE/JWcAVYa2s8ASChyTtD4VKCJ60o5rIhSa2EqEd+KNZpFIhl
         d37R1z6M5ZVHTp+b8HqXQsrq5CfpIPwvsdrEImaucmOmtjzQ11+QWl+Q+uX2TTJIWsCG
         NqsouW43Hystut/1O0oYtSvSKc6S79Ilw0oi4MrUGa6yWbcG+SW0d9I6QBBE0hwnXRIK
         Y8OVK5ZfjhkA/wPQeJOv7ph4ecyrkt8pF9yLf5gfdjeLv3fl519EaNX64Mx77b/7Wm15
         EXAE1MhYppwJwtNVLffJ1ufdMZOnwXlW0VgTMlwjti2cera4Ex+ZvBeOsPUd0qWlvuMt
         3P5g==
X-Gm-Message-State: AOJu0Yx2R6nw05hpN9FuVo6uMmGJKEe0D6gRB/QXJ1cR+umxrihoMBw0
	kXIISGL2WTLrtIG8SbPe3DGQoglC2Ah2gsunATxW5pNk9ejLdZD8mQrEvZWkE6nd
X-Gm-Gg: AZuq6aKUAvIcTH9CCYHK2c7+nAtiLq6P/SS1EYzbQ3x/zdn++eHZrXLewVeMAq52BXy
	0nq7OBSk4kXGf/m3ShW3lGCM1+UO9WiGC+Wps8vphUd/K1Xe+o5PAYgZL+sOEXby0YBedtIiT9D
	Tq/RJRaqfoSxy23FoYWTR5mj3uyD0/TTuxEDrnXYPOS0QX1+BKrdxCmrrY5mAJ2poTAhYm1lSFz
	mdoBi5/vnTFIjK40JwQh/v4C3UVKSJGk7yFMTHY81REopKJ2lc7H4mTVmrbAjwMV40N03+sLjRU
	BiBArc1N5HNe7o7/h+peX+r+M6n1AWH/rgZb9dw6MBT3JbRGLgHUy74H449zZv+xATY4joaE8oa
	1Ceale2y+om+DDUXPaK5+SP7iQ23aYCmx1j1qC/50W9VBE0mW3OlZ/zrZkyX0FY/IkNTewkDBuW
	vvpGxw1qqbq3FO4EY5kS7gaWVx4az7f8Lr8iI/hYeMzd20DHnYZcM8CiqNXr8LQsxpswSOHxaU2
	+i53Ghs/rk=
X-Received: by 2002:a05:620a:3713:b0:8c6:e579:a81f with SMTP id af79cd13be357-8cb4086a5c8mr31869485a.23.1770929733721;
        Thu, 12 Feb 2026 12:55:33 -0800 (PST)
Received: from dhcp-10-231-55-133.dhcp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc823a4sm44446646d6.8.2026.02.12.12.55.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2026 12:55:33 -0800 (PST)
From: Justin Tee <justintee8345@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: jsmart833426@gmail.com,
	justin.tee@broadcom.com,
	Justin Tee <justintee8345@gmail.com>
Subject: [PATCH 04/13] lpfc: Use min_t() instead of min() in lpfc_sli4_driver_resource_setup
Date: Thu, 12 Feb 2026 13:29:59 -0800
Message-Id: <20260212213008.149873-5-justintee8345@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20260212213008.149873-1-justintee8345@gmail.com>
References: <20260212213008.149873-1-justintee8345@gmail.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20826-lists,linux-scsi=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justintee8345@gmail.com,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DBA6F131119
X-Rspamd-Action: no action

The member called cfg_sg_dma_buf_size is declared as a u32, while the min
comparator's second argument called SLI4_PAGE_SIZE is a #define.  Proper
comparison should be using the same type, therefore change to use min_t.

Signed-off-by: Justin Tee <justintee8345@gmail.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index a116a16c4a6f..c3023474427a 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -1,7 +1,7 @@
 /*******************************************************************
  * This file is part of the Emulex Linux Device Driver for         *
  * Fibre Channel Host Bus Adapters.                                *
- * Copyright (C) 2017-2025 Broadcom. All Rights Reserved. The term *
+ * Copyright (C) 2017-2026 Broadcom. All Rights Reserved. The term *
  * “Broadcom” refers to Broadcom Inc. and/or its subsidiaries.  *
  * Copyright (C) 2004-2016 Emulex.  All rights reserved.           *
  * EMULEX and SLI are trademarks of Emulex.                        *
@@ -8287,7 +8287,7 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 			phba->cfg_total_seg_cnt,  phba->cfg_scsi_seg_cnt,
 			phba->cfg_nvme_seg_cnt);
 
-	i = min(phba->cfg_sg_dma_buf_size, SLI4_PAGE_SIZE);
+	i = min_t(u32, phba->cfg_sg_dma_buf_size, SLI4_PAGE_SIZE);
 
 	phba->lpfc_sg_dma_buf_pool =
 			dma_pool_create("lpfc_sg_dma_buf_pool",
-- 
2.38.0


