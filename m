Return-Path: <linux-scsi+bounces-4719-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C1F8AF8D5
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Apr 2024 23:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046F028AF61
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Apr 2024 21:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6663143873;
	Tue, 23 Apr 2024 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aqsQPL2o"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE7D143868;
	Tue, 23 Apr 2024 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713907132; cv=none; b=Oepp8k84rmu+uMoDAkeKUfOcUcyGbYoiDVHo2yqGPpf+HQtpUXAzMcJymgMbG8mttewKIcDkYw717AHPRC56vpS7lR5t8I/8p0RRX5Y9iDVgaUOj52uXCtyJBMo7Z3ZF5pmOfHZeA+kaLISz/WCZ+OMYThidiRPEN17w2CekIB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713907132; c=relaxed/simple;
	bh=odZkNKxOuyBfEnaOqYjDaNuTGmJkTByxigLuItAxkuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IjKDqBmMHAE8k3foU7BRvAnJ99Od/azQS8pIVFb2b0qwyIuIZHZipeVzU6vVErW9QhFLNicqpyZv1nkW+hLkx5U60AehExZhyDYzPsxIs01NWF8UV/AR4Vt92ziqX0QTBw9UQThQeNLndc2/BPJKnw53zZECk0KNN4OAdg0RdA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aqsQPL2o; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713907131; x=1745443131;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=odZkNKxOuyBfEnaOqYjDaNuTGmJkTByxigLuItAxkuI=;
  b=aqsQPL2o/7m7y0wmKsVfFCRYwRYpIM2GRWXfMs2bZTZGprLK7asjhKwS
   1kbo5ot5HlYCO8rj9yIOtFLqsDjMmiWhA3o/YuwWFa/sFvsifPSsBqgS/
   hItqN6CM0j4gCoP9AcRcsKQ1lq+DnXrOe1rJ/8raqqcugLB8u98X523bC
   e+Ju8H2/limwi6qxVuQnlNhPhlu8ITiJnz0q20yi7kEyVAzFSlH9SIhWZ
   Ku9nNKWvcvJubG1VlEtUegy9lh7b7QC4mvu0zwcJ1MCxeL4DpyTkneQdp
   WCEV3Kay5YN+oCWo8fW62bQ5thH8wUVJWFj7op8RjHQWd82mgM3DIYV41
   A==;
X-CSE-ConnectionGUID: /ToywuwvSJ6bpGIPguBSsA==
X-CSE-MsgGUID: yyNhyqdGRR2fyT47g10jdQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9623608"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9623608"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 14:18:51 -0700
X-CSE-ConnectionGUID: ZcCK3jZLT6mKBgqt5TMv6Q==
X-CSE-MsgGUID: x8LCblCySIqS4mcEyvF+Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24526472"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 23 Apr 2024 14:18:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5595A28A; Wed, 24 Apr 2024 00:18:48 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] scsi: Don't use "proxy" headers
Date: Wed, 24 Apr 2024 00:18:43 +0300
Message-ID: <20240423211843.3996046-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/scsi/scsi.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
index d90645f06a3a..96b350366670 100644
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -7,8 +7,9 @@
 #define _SCSI_SCSI_H
 
 #include <linux/types.h>
-#include <linux/scatterlist.h>
-#include <linux/kernel.h>
+
+#include <asm/param.h>
+
 #include <scsi/scsi_common.h>
 #include <scsi/scsi_proto.h>
 #include <scsi/scsi_status.h>
-- 
2.43.0.rc1.1336.g36b5255a03ac


