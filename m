Return-Path: <linux-scsi+bounces-25310-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S8/QGONiP2o5SgkAu9opvQ
	(envelope-from <linux-scsi+bounces-25310-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sat, 27 Jun 2026 07:42:59 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D07A6D1328
	for <lists+linux-scsi@lfdr.de>; Sat, 27 Jun 2026 07:42:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=purestorage.com header.s=google2022 header.b=CWCUvefa;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25310-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25310-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=purestorage.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A23903014761
	for <lists+linux-scsi@lfdr.de>; Sat, 27 Jun 2026 05:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884E438B122;
	Sat, 27 Jun 2026 05:42:50 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f231.google.com (mail-pl1-f231.google.com [209.85.214.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BD51991CB
	for <linux-scsi@vger.kernel.org>; Sat, 27 Jun 2026 05:42:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782538970; cv=none; b=EL1u9nOTT2cG3U3j7vamkUjvfhu1ywPqrB6sz4bjphMBetohA+uwsg8zSpgYZBpmLVpLLdz3W4FFko4fGZV2sFKj+jbFKloqa7MGHTKyrQdGL48XySwuiHW+SHV99kf+QAmCyq73Txor+IXIBXczhDuucjgAMT/0+jqpn2S8Kaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782538970; c=relaxed/simple;
	bh=ibHZUitqlYEsZVyxLJ8fClmaaZMHceqKSYFgEU/W9Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r6mzMqjcco3iL1oW6cSOCPysKPO4YZZ/PI7H+1aAYKxWzJk8OKJX8fRq/DVuS8CXAv+6cNtfZgtyiDZZo/Hy/YN0lCXzGiXqOnRU/ty79B5GvHln0M7c2ZzcUgJ4VN/D5S0Y+pjeI2Kxh/Sf8EXymUChMF26SEG7MhKY8vJFr/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CWCUvefa; arc=none smtp.client-ip=209.85.214.231
Received: by mail-pl1-f231.google.com with SMTP id d9443c01a7336-2c996117854so2063485ad.3
        for <linux-scsi@vger.kernel.org>; Fri, 26 Jun 2026 22:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782538967; x=1783143767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LBI2TZBBdvnIGwxDwxfcA0X2DAXeqtxaRyAM5YR83X8=;
        b=CWCUvefaDDQch/+W35Qc+2rLWEJHBY9EPbsKXfHAsoZBU+Y/jlJPlY1axXuRB0uZNo
         NgmRAQ4S1Vaoi1w1KsL3hhe0LDWfMvcb9uk46rKBuJeMZPL6eveSY05tVaGmTA5liGpA
         +wDfqNs3pdsdjA2cK/EHSfKkJ6S1cYoVa7q/QsWvlaNsKbBki4h+fiOl5LKy+4LvEHZe
         hIdyZOoTIkhqKWkxd9ZK63LgQA06dr/xondc4LzkUvtIXuO0MI5yRXSISHWXf/uwfEHq
         sSUHiuRvZkN2W//7VOX+q7FMBwHjSBXydMp9fydZfhGvuQqrHVOj1Eo1P2g5PHsiU+o5
         U6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782538967; x=1783143767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LBI2TZBBdvnIGwxDwxfcA0X2DAXeqtxaRyAM5YR83X8=;
        b=Trqn/UZcIE0GhGhGBwPHjDaskFOlyRViH7wmIe8e7uMM5Vim09ML/2HEUNLXjHxctg
         KUIZh0BuV/0YBz9TrhSzUdtDhE3MJh7p9xX06Tx+0e0Tlo9/Jc+RZ6Uj1DHclHVLiBzO
         fmDxF/fH4OrTrovkLxDSXcKe4ttf4ht5/NOiy+eTQODNo6FU569f6fKRLG8nlWRqSQbG
         CjKs12Q8QTaj40iAJMYRdiUO185ZxW5Woz/zmI1ZBLPFvADZH6cRrLp19viirJY5w2We
         k+jWpYQmNaX9ZuG/rthpjbqkvRMwUfUERZ12gcn9MZbHPgcChrB/VleJ5ErzjmbMSZSZ
         srNg==
X-Forwarded-Encrypted: i=1; AHgh+RqZ7jJnS0LWMDR4+ZlJNcq7De7czO51ca9tLf7bQHtxEDZeJ6CUFQHFbRS2gWKT4evo8fbZWbL+HMTH@vger.kernel.org
X-Gm-Message-State: AOJu0YzAvWu2oBpaNw+TTFAKivTo8gRGRfVk4YcbFdlfB0kxVy48r29l
	ZLyOHxaJ/dYLq+qvos8kZE6F9d7B6ELmjazUoT1Vs5n7GftnvF5Fe2ZJlaYA9cIm70jcvT45Qf7
	be3qrNkk6yp9zdSJ78GEovG9AuIrhYxAxPyvrZ7X1wrsiX2sgCaEY
X-Gm-Gg: AfdE7ck4OJreRn7Xo0DQ8/MvVK9NdaHbGAVjai2O4YWixHrNd5rm7DZC8EHxnWpraku
	n6OtqWnW82rkUjFdEhll0axuBNrVIipHBmZUVfeXfJDN87wfzFWcXC84N6bE+L1KhWH5/LIl8Y9
	NHgeJ7l1nEIaiTBoHpONIoh3th0WiSNn3N/GZ8fHy760dZ8t4LCAZbYRSP8ZH7nIOoNYoGOUk0P
	WF4uAocKSXhRy5HANx0Mcc4dpzjIZ6u0oNDjqL3PyfzXaLV/pI8A7+dElWqavdFJn0rNtdxvn4H
	KZhm08fgEnSw4PQ77cqhvoyC1U/spc+5bfbjxzSOk3sfF7V7R1UuHcaZOK4OGQaMtEeppt32mqt
	TDhQ88lhpob9aFsRUVEQE2lk6+F/e
X-Received: by 2002:a17:90b:5207:b0:364:be8f:1d86 with SMTP id 98e67ed59e1d1-37dfa223d7dmr4789320a91.8.1782538966692;
        Fri, 26 Jun 2026 22:42:46 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-37fb11c60c1sm166693a91.3.2026.06.26.22.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 22:42:46 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 0809840146;
	Fri, 26 Jun 2026 23:42:46 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id F351FE40712; Fri, 26 Jun 2026 23:42:45 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 0/5] block: use integrity interval instead of sector as seed
Date: Fri, 26 Jun 2026 23:42:15 -0600
Message-ID: <20260627054220.2174166-1-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
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
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-25310-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[csander@purestorage.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:martin.petersen@oracle.com,m:anuj20.g@samsung.com,m:linux-block@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-scsi@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:csander@purestorage.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[csander@purestorage.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,purestorage.com:dkim,purestorage.com:mid,purestorage.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D07A6D1328

The block integrity layer currently sets the integrity seed (initial
reference tag) in units of 512-byte sectors. However, Type 1 and Type 2
ref tags are actually in units of integrity intervals. On devices with
integrity interval size > 512 bytes, ref tags are seeded incorrectly.

Ref tag "remapping" in blk_integrity_{prepare,complete}() covers up this
ref tag seed discrepancy by offsetting all ref tags in each bio to
convert to/from the absolute integrity interval numbers. But
REQ_OP_ZONE_APPEND operations don't have their ref tags remapped, so the
ref tags using units of sectors will be stored to the device. As future
optimizations, the ref tag remapping could be avoided entirely on NVMe
and some SCSI devices by passing the ref tag seed instead of the
absolute integrity interval as the expected initial ref tag.

So avoid relying on remapping to convert between the ref tag seed in
units of sectors and stored ref tags in units of integrity intervals.
Initialize the ref tag seed as the integrity interval, not sector.

The subsequent commits clean up the integrity ref tag seed code a bit.

v4:
- Drop patch already applied

v3: https://lore.kernel.org/linux-block/20260417015732.2692434-1-csander@purestorage.com/T/
- Drop bi and bip arguments to bip_set_seed() (Christoph)

v2:
- Reorder fixes before refactoring commits
- Use u64, SECTOR_SHIFT (Christoph)
- Don't take sector_t in bip_set_seed() (Christoph)

Caleb Sander Mateos (5):
  block: use integrity interval instead of sector as seed
  blk-integrity: take u64 in bio_integrity_intervals()
  bio-integrity-fs: use integrity interval instead of sector as seed
  t10-pi: use bio_integrity_intervals() helper
  blk-integrity: avoid sector_t in bip_{get,set}_seed()

 block/bio-integrity-fs.c            |  2 +-
 block/bio-integrity.c               |  4 ++--
 block/t10-pi.c                      |  7 ++++---
 drivers/nvme/target/io-cmd-bdev.c   |  3 +--
 drivers/target/target_core_iblock.c |  3 +--
 include/linux/bio-integrity.h       | 11 -----------
 include/linux/blk-integrity.h       | 27 ++++++++++++++++++++-------
 include/linux/bvec.h                |  1 +
 8 files changed, 30 insertions(+), 28 deletions(-)

-- 
2.54.0


