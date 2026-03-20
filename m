Return-Path: <linux-scsi+bounces-22330-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACwnG4LCvWmEBQMAu9opvQ
	(envelope-from <linux-scsi+bounces-22330-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 20 Mar 2026 22:56:18 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FD92E1863
	for <lists+linux-scsi@lfdr.de>; Fri, 20 Mar 2026 22:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93E9B3009806
	for <lists+linux-scsi@lfdr.de>; Fri, 20 Mar 2026 21:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B6B3D2FF7;
	Fri, 20 Mar 2026 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OmBP6vwm"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542AD2C08D4;
	Fri, 20 Mar 2026 21:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774043771; cv=none; b=RMUd1YCnOHYjlR3BlAt3ZdfItLSalJQPUrQ2Jeu1CGNzTZWmjVQimo8koko8XBz3vPmH7u4YbErHm5p9yjUAHIvJyIG6rhN6Db0RtIyGYzYYKjNQUPew+1bu0vEuzmxjYGo5I/e7EPIxsOPMPVHTc4aF9qzDyTRpkzl2Qk7oVkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774043771; c=relaxed/simple;
	bh=/Rf2eakh5ZeaAaheFJYAVxm4fy6YqH2KFkakWRjpmuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CuG8hQBLU1NK5TdKjW46N4YdNXBKqqv8jiFy1dxdmbUHKgnNwNNL7rivjMNJZ/YVLMX/xBddbgw/bCeRlaohlGp7Vomj0g5cpk1Dw/v+3OhgS5swWZEFjyACh+XQQTn1vUF/GqJjcwEZWYBIDehebjDCWo1mkyC0rsA29Rl840s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OmBP6vwm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774043770; x=1805579770;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/Rf2eakh5ZeaAaheFJYAVxm4fy6YqH2KFkakWRjpmuM=;
  b=OmBP6vwmwkW+kjZbjRMjAh5HF8o+bsC4ksMXj8MicvWjyp1kWdAWj60l
   PDJwG8EGusvSqI9pFqX0cf3pX5N+A7awzLGB+OkWjKyfYR+vVuig8UXas
   80lSMxr/ZE7rPETxELLMHZUla/uD6Dvq7FRlGhVRdxn4DCwBzrIAsFuvZ
   gIaQetj75a/G36vjR1liM0xw2HwD1ekfTOE5uaQLhCWZV4KGgsVwi20nQ
   XIOQXHtBuViN0vYzpIdKTM1F9RURTcKjufAPb/j+pUM8/ut0p7fY0n2kH
   tEwnW5kkyotN6T2/mA6UYQpDm+/TSTlUrEx52SW523DoPyyqwyXPutToh
   A==;
X-CSE-ConnectionGUID: EGf0mmyaTFyRzyawpNS1Qg==
X-CSE-MsgGUID: m4Jo797vRBahNsNGrTlUzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="75206238"
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="75206238"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 14:56:10 -0700
X-CSE-ConnectionGUID: RKkVuXzFSeeUmx+o2YwLYw==
X-CSE-MsgGUID: Kp0B0jduSwCPwqIM2VlfoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="220732837"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 20 Mar 2026 14:56:07 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id DB47195; Fri, 20 Mar 2026 22:56:06 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	linux-scsi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] scsi: ufs: rockchip: Drop unused include
Date: Fri, 20 Mar 2026 22:56:06 +0100
Message-ID: <20260320215606.3236516-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22330-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 73FD92E1863
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This driver includes the legacy header <linux/gpio.h> but does
not use any symbols from it. Drop the inclusion.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ufs/host/ufs-rockchip.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-rockchip.c b/drivers/ufs/host/ufs-rockchip.c
index 7fff34513a60..bac68f238e1c 100644
--- a/drivers/ufs/host/ufs-rockchip.c
+++ b/drivers/ufs/host/ufs-rockchip.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/clk.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
-- 
2.50.1


