Return-Path: <linux-scsi+bounces-23198-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPd7DXDO6GklQQIAu9opvQ
	(envelope-from <linux-scsi+bounces-23198-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Apr 2026 15:34:40 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C91DA446CA3
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Apr 2026 15:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE0EC3098B2A
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Apr 2026 13:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2B03EBF1E;
	Wed, 22 Apr 2026 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="XyMTgi10"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7223EB815
	for <linux-scsi@vger.kernel.org>; Wed, 22 Apr 2026 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864440; cv=none; b=cSX7bfVbMo7EJroXvEoilTea2uLOTLJ7B4XN/tDJWDGsUl4NDpD64D6Aesp0DDWZGT7ouJIWcJoQiQ9ZZpJ4dVSfB0lnkryxV5wTKaGlWdNWJEEiZo4vuguT7ANCkfxRyeyt5Rj/JXL5sGIqF/8mmlBOd5fBPLOZEF9d4Ft+BM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864440; c=relaxed/simple;
	bh=CNmV50fwWM2qTb/hOpmr0ep4rnwuMTOUpDhQuUCzzaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oku099x2W7cqmbGFJ8JhGKfgTFge5geNwXynyZHeK6CUpylEGXpK0pUtZ+nLCB1SzkmP42brdh4BRYfVTulDHDTUoE1WKzhd4Ty4Lvk1A5BcLzDkG8oORy57Qw2IE95BW01mQ+c4mzUQtK/GB0f/d6/3GLYFslvB1qza5LBtajE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=XyMTgi10; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b24fede2acso34658235ad.3
        for <linux-scsi@vger.kernel.org>; Wed, 22 Apr 2026 06:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1776864437; x=1777469237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jDcTBG+hlhD51mSvRcMB9jaoIaf7As497aHU40CIgJU=;
        b=XyMTgi101dgrRbsAoVmGjSzfdqoZEZtd46wbhVU5xf2s8AUrD19aA2WtP/eLB//XPd
         ufi/gtA24nuqyyqAE2k1yI9LZ9rKXJEqdEegpFXxuR9AiA2ZVEds3wKYIyfGrDJaTYJb
         533m3mgCjQXKtr+ij6VsyJsSNPTnQbtPiKAZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776864437; x=1777469237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDcTBG+hlhD51mSvRcMB9jaoIaf7As497aHU40CIgJU=;
        b=kV2UT0sKIYhgB3QtrZZnJQULvq6zdGexOw4CUpLRw5aP8vYC7jK+Ef9KgJ81HApb0V
         p/e5UkvAlO22hw73o5eeD/CHuPaTi+aOqKpur0kVCdxv2L3GF2ZwIFjsrpJc1VPxULGj
         EgY1JojJU4ZfQdCeSk1tfVDGYYSnwo7hA2qcvbozYAwkJ48KMxLn6SjzW4Vv4vlyZLL0
         cHsCKY7c/+Bcy1loJYw70vKh8YkGIL3gBpPw40zwnxj2oa151bsZcXw2n6EuyAtsV9nc
         cDDi5tAE1zP1ajYa6+uB7NdcZ7D9SkgirZ1mYyWKISo9LIdn/hkrjdrVZwj1SUYz1l1k
         BdFg==
X-Forwarded-Encrypted: i=1; AFNElJ89ahYHr9MPoMVcREpVH3QKOjmHB9ePSp8SmVOr0Gyb0FaNzCGSOtMNjXiTiDieVt5d//wBLE6jx3fI@vger.kernel.org
X-Gm-Message-State: AOJu0YyrhNjWU5NMR/wysVEqhEuAeeNFoogMHZyJDhry0ikk/HbO5tvt
	kxy+NGHVMl8QAxtkgXciver6HDUQR6CqNObWTzQpuo0GjSwF5HYVWnsxxK+PMwhibYg=
X-Gm-Gg: AeBDieuou2/SeUoVq5Pa+wK56QYNqzKOcJqPPhpcA83yXZ2uOeDWugJ0dOY5sLfiIeM
	TZwTd9J8TXKzz5ZMRjn7/9Uvuxc5le5xGorCbuWRHIq/o+ssdZfEH6ouj+7aQj0HO66CktFgM5J
	kTd6/hJ94AIUrgoLJvx7LXcfeKVh378oub2vOC8geMS2uQGTW7NQGvRRRoqGXljJlYsvCd5PYuj
	R7fOV/RfrR56IDRaBTnUy7IHsmt3jdqembV3LerOUPlBcjsCi/Y/rdcTXnKPONkNiV1hWSDL0qk
	WQE51MldPgWngR1D+/7G/LP3+SnGCOkp7Xxy39s75oXiF692EgdjCR9QSZ/U3fFoQ7C1jL4jjtV
	bHRcGT2gVArzu2QG0rlO6ILcY4tdx+YajcJtiR3AMhid9kfIAr1q3H9ToN/YUTm0dytC4Yu54ZM
	WiE8fY/AYH0wGBMTGjyC22ANj5lPUc4pOFrzt4mK4+MXrmBhdT6bv8fHALLEd/om+Uo9X3dLRP4
	NNPrigb8UIJgimOSf3/FM5p
X-Received: by 2002:a17:902:7c0f:b0:2b0:663f:6b53 with SMTP id d9443c01a7336-2b5f9eb2b36mr169293385ad.13.1776864436549;
        Wed, 22 Apr 2026 06:27:16 -0700 (PDT)
Received: from kinako.work.home.arpa (p1329195-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [114.145.5.195])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b5faa34ea7sm165756005ad.34.2026.04.22.06.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:27:16 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: andrew+netdev@lunn.ch
Cc: geert@linux-m68k.org,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-m68k@lists.linux-m68k.org,
	linux-scsi@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH] m68k: mvme147: Make me the maintainer
Date: Wed, 22 Apr 2026 22:27:10 +0900
Message-ID: <20260422132710.2855826-1-daniel@thingy.jp>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[thingy.jp:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-23198-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[thingy.jp];
	DKIM_TRACE(0.00)[thingy.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@thingy.jp,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-scsi,netdev];
	NEURAL_HAM(-0.00)[-0.983];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[thingy.jp:email,thingy.jp:dkim,thingy.jp:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C91DA446CA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm actively using mainline + patches on this board as a bootloader
for another VME board and as a terminal server using a multiport
serial board in the same VME backplane. I even have mainline u-boot
on real EPROMs.

Make me the maintainer of its ethernet, scsi and arch code so I get
an email before one or more of them get deleted.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d25342ca8aa1..9949b5528bcf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15311,6 +15311,13 @@ S:	Maintained
 W:	http://www.tazenda.demon.co.uk/phil/linux-hp
 F:	arch/m68k/hp300/
 
+M68K ON MVME147
+M:	Daniel Palmer <daniel@thingy.jp>
+S:	Maintained
+F:	arch/m68k/mvme147/
+F:	drivers/net/ethernet/amd/mvme147.c
+F:	drivers/scsi/mvme147.*
+
 M88DS3103 MEDIA DRIVER
 L:	linux-media@vger.kernel.org
 S:	Orphan
-- 
2.53.0


