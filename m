Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE94194B61
	for <lists+linux-scsi@lfdr.de>; Thu, 26 Mar 2020 23:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgCZWPP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 26 Mar 2020 18:15:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:56088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbgCZWPO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 26 Mar 2020 18:15:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 15914AE87;
        Thu, 26 Mar 2020 22:15:13 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        bvanassche@acm.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 4/5] scsi: target: increase XCOPY I/O size
Date:   Thu, 26 Mar 2020 23:15:04 +0100
Message-Id: <20200326221505.5303-5-ddiss@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200326221505.5303-1-ddiss@suse.de>
References: <20200326221505.5303-1-ddiss@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The I/O size is already bound by dev_attrib.hw_max_sectors, so increase
the hardcoded XCOPY_MAX_SECTORS maximum to improve performance against
backstores with high-latency.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/target/target_core_xcopy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/target_core_xcopy.h b/drivers/target/target_core_xcopy.h
index 9558974185ea..f1aaf7140798 100644
--- a/drivers/target/target_core_xcopy.h
+++ b/drivers/target/target_core_xcopy.h
@@ -5,7 +5,7 @@
 #define XCOPY_TARGET_DESC_LEN		32
 #define XCOPY_SEGMENT_DESC_LEN		28
 #define XCOPY_NAA_IEEE_REGEX_LEN	16
-#define XCOPY_MAX_SECTORS		1024
+#define XCOPY_MAX_SECTORS		4096
 
 /*
  * SPC4r37 6.4.6.1
-- 
2.16.4

