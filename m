Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D293D3700
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Jul 2021 10:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbhGWIGr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Jul 2021 04:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbhGWIGr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 23 Jul 2021 04:06:47 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A20EC061575
        for <linux-scsi@vger.kernel.org>; Fri, 23 Jul 2021 01:47:21 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1627030038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KDpKJoO3R1KRA6EmHhLbfvLJUnTQjl832LFdWEvn2Eo=;
        b=LVdD2v+BoL0A7sExnyvw4cFjW2BWmh7nradQ+7AsYH32ifdf5iV/ogRcJ7m3t2h+JpBfR+
        Gt1lxjU3CdJtqZXgRpcSVhyxoCeRmwF2GA8VpfvRL/Soj7z+NeQjpTOhTHQ4GkXSVzxiuu
        MXEK+MxcbeNY6bdT5zFftxZ6GxwkOOY=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: libsas: Drop BLK_DEV_BSGLIB selection
Date:   Fri, 23 Jul 2021 16:46:24 +0800
Message-Id: <20210723084624.2596297-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: guoqing.jiang@linux.dev
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Guoqing Jiang <jiangguoqing@kylinos.cn>

It can be dropped since SCSI_SAS_ATTRS already selects BLK_DEV_BSGLIB in
drivers/scsi/Kconfig.

Signed-off-by: Guoqing Jiang <jiangguoqing@kylinos.cn>
---
 drivers/scsi/libsas/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/libsas/Kconfig b/drivers/scsi/libsas/Kconfig
index 052ee3a26f6e..c640535d1ac0 100644
--- a/drivers/scsi/libsas/Kconfig
+++ b/drivers/scsi/libsas/Kconfig
@@ -10,7 +10,6 @@ config SCSI_SAS_LIBSAS
 	tristate "SAS Domain Transport Attributes"
 	depends on SCSI
 	select SCSI_SAS_ATTRS
-	select BLK_DEV_BSGLIB
 	help
 	  This provides transport specific helpers for SAS drivers which
 	  use the domain device construct (like the aic94xxx).
-- 
2.25.1

