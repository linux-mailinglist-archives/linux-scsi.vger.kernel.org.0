Return-Path: <linux-scsi+bounces-22702-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JjPIHEZzmmnkgYAu9opvQ
	(envelope-from <linux-scsi+bounces-22702-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Apr 2026 09:23:29 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 146A8385157
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Apr 2026 09:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 556BE3131A4B
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Apr 2026 07:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978323890E4;
	Thu,  2 Apr 2026 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U/25INLE"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2455434676D
	for <linux-scsi@vger.kernel.org>; Thu,  2 Apr 2026 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775114255; cv=none; b=NKqnF37dpLqwlGLF5LqmTY920RLY+Vi3z3aUaEah0obdJRXOqZayd/Ch9QkRWYjCvmECV1Z9QnBU6Fkl9BfkoQiraIcvZ72REFxmS3Rvu80Y0W+Cc4Mnq/OLSypOP9ZgTIR3GOfto/dl89iJaUGJ5va+Alx9OZMFsZQLIETNKFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775114255; c=relaxed/simple;
	bh=8VtY1s07JsvpgjHmz/k4durVfj/YL5x4wNgvwrQk6Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWG5j84oMncZ8foWVcGjeujoAZ7s1oUY59d8E64uVAj12MuOyCmn6BxWCnS0nYKZB7X6ZYvh6sP9dLIiaBj4PJgIGkXyg2Hl0CFPAKpGkHhFlv0YfAYgRhshh6fkpevpPbhgUxvuTMbkFILvVVqQsGRfsTLE3UWHlOOLaTydfxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U/25INLE; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-35d90833cacso281453a91.2
        for <linux-scsi@vger.kernel.org>; Thu, 02 Apr 2026 00:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775114253; x=1775719053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TftjXKzvnuKTg+BCeN292xhOJ4TG6xE+i1ind2ngbzc=;
        b=cXPLZeO8d1FGArzvdgoQdGtFvi2UkdhkveQ+q58IlfucSrVinWZMVT5FlSirR+9uqY
         uBRml+tA/lRs7/cxlh3VpmUjLLtJfAUHMX9fJ0HJZg5RS0hOUT1WAUAy9Q9iMupw1a2F
         A1hFhqYfHIjpzU4UgtsTTt0AAoCj1e9Co/yl7zxSCAWnWY6rODCttmdWWYEd6g2t9Hrm
         pBgBV4j2eCOwn4RUIbv6/Cy1w+0rNuP24agBeO25DFEoW6UsOHbWfDf1L8jEHV9fp4ws
         SWAoLIKgVm29t2xG+5j1D29iKwqNgc/hkts701UIQ3mQNPBp6JQVuLu17prJDzHdrTCC
         Ak+w==
X-Gm-Message-State: AOJu0YwoKZ14p4POSDxQSY/cs99YS4+MiB/X+e3C3MKHFrS+3/whAhRv
	KavUoNwWKgX4oDAVbqcF5rKAx2hIazWlhEa/wdUkVbpNcNmNefGiXZ/PtUoLKMqeG2dJ3MiP4Am
	YGoERLcwFSEpx+tStje1P6REF7lh9tA7XKTX2Er0vyQSh18Xo6I9igSLySFHAcL4VkpksqBGMzC
	K93V/7RbPbtmuJ3zfaVamMGn+8nHLF1qu5bwa58RXEkrG5jwQEB1ebAjQM/gDDFuQsOhRJAGCI5
	KQQjbXUSv59smvdVy8=
X-Gm-Gg: AeBDieuze5yAkOxBdiU/HCzZJDDqc1YymNC6rmzOD5smkF1nLSJ6s9w95jd1tuEEfbb
	F3lkEK5zd/M0ytlZWmcqi7mrIlfxsGuDoWDXFA/+jrMAqJ3NU2fjdVwQXiEeP1AVuaKODK0V6zx
	0LcZeSyqjaoG6tH1lSJRk4lrF/HCjUDjVDbkflrRh7aO/XYmAXbwuBC2t15amSc3ILulRl4xEF2
	ZfmOgf9JWiABBMDYT450Zhsfol377Av21z7qeDG4BnL/Guwccd2uQZpiUoq5OWWEljcNLV4e35V
	7SiYhgY7mVXrPJK043jxa2HmKygdUxjN4gRJKzEzr8wQgCiuFiBorJ/Alm0kr1ngXd1GzJCfSWf
	Y2tiYtOKhE4FbRxwGxPx87VV7lhX/Np5ElyvbrIkvf2MF0qhxQoxQIjgRayzVIL13cyq1p98d0V
	nQUu/E3x/jsRhzmx2SbBf1IGKwL7LdHfcF9On3LGLkv3h8GU7t2wt7MuzY
X-Received: by 2002:a17:90a:c110:b0:35b:9c97:3d18 with SMTP id 98e67ed59e1d1-35dc6eae327mr5949753a91.12.1775114253399;
        Thu, 02 Apr 2026 00:17:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35dbb766541sm561785a91.1.2026.04.02.00.17.32
        for <linux-scsi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2026 00:17:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b242f76113so6484755ad.0
        for <linux-scsi@vger.kernel.org>; Thu, 02 Apr 2026 00:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775114251; x=1775719051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TftjXKzvnuKTg+BCeN292xhOJ4TG6xE+i1ind2ngbzc=;
        b=U/25INLE5V5WYvIqsku7osmS7drm3kAvUorZ0HPUSiIdVUs6F5cY8t176bGD/CqzvM
         l2aB43/3tJfdwXGFbTiwwD+s7m0ApOfDHVAJDNtemoWlVk3z9mUeq7V9/PypOOxTJeeW
         o0btTHDUeurmMtIbAGJWng6lB9NF9g13dRvkM=
X-Received: by 2002:a17:903:2984:b0:2b0:5ae9:ee4 with SMTP id d9443c01a7336-2b269aa3b7emr63373945ad.5.1775114251497;
        Thu, 02 Apr 2026 00:17:31 -0700 (PDT)
X-Received: by 2002:a17:903:2984:b0:2b0:5ae9:ee4 with SMTP id d9443c01a7336-2b269aa3b7emr63373715ad.5.1775114251087;
        Thu, 02 Apr 2026 00:17:31 -0700 (PDT)
Received: from sumit_ws.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477c54bsm24612825ad.27.2026.04.02.00.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 00:17:30 -0700 (PDT)
From: Sumit Saxena <sumit.saxena@broadcom.com>
To: martin.petersen@oracle.com,
	axboe@kernel.dk
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	James Rizzo <james.rizzo@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>
Subject: [PATCH 2/3] block: align nr_active_requests_shared_tags to avoid cache line contention
Date: Thu,  2 Apr 2026 13:16:36 +0530
Message-ID: <20260402074637.92417-3-sumit.saxena@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260402074637.92417-1-sumit.saxena@broadcom.com>
References: <20260402074637.92417-1-sumit.saxena@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22702-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.saxena@broadcom.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 146A8385157
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: James Rizzo <james.rizzo@broadcom.com>

Place nr_active_requests_shared_tags on its own cache line so it does not
share a cache line with nr_requests and other hot fields, avoiding
significant performance hits from false sharing on some CPU architectures.

Signed-off-by: James Rizzo <james.rizzo@broadcom.com>
Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
---
 include/linux/blkdev.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d463b9b5a0a5..7ed566c81c1b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -561,7 +561,9 @@ struct request_queue {
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
 
-	atomic_t		nr_active_requests_shared_tags;
+	/* ensure nr_active_requests_shared_tags and nr_requests are on different cache lines
+	   to avoid significant performance hits on cache line contention on some CPU architectures */
+	atomic_t		nr_active_requests_shared_tags ____cacheline_aligned_in_smp;
 
 	struct blk_mq_tags	*sched_shared_tags;
 
-- 
2.43.7


