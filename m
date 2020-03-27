Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE40D1958D1
	for <lists+linux-scsi@lfdr.de>; Fri, 27 Mar 2020 15:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgC0OUN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 27 Mar 2020 10:20:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:55080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbgC0OUN (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 27 Mar 2020 10:20:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D0E4AB201;
        Fri, 27 Mar 2020 14:20:11 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        bvanassche@acm.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH v3 1/5] scsi: target: use #def for xcopy descriptor len
Date:   Fri, 27 Mar 2020 15:19:50 +0100
Message-Id: <20200327141954.955-2-ddiss@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200327141954.955-1-ddiss@suse.de>
References: <20200327141954.955-1-ddiss@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/target/target_core_xcopy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/target_core_xcopy.c b/drivers/target/target_core_xcopy.c
index 425c1070de08..7e5b13da0c20 100644
--- a/drivers/target/target_core_xcopy.c
+++ b/drivers/target/target_core_xcopy.c
@@ -134,7 +134,7 @@ static int target_xcopy_parse_tiddesc_e4(struct se_cmd *se_cmd, struct xcopy_op
 	 * Assigned designator
 	 */
 	desig_len = desc[7];
-	if (desig_len != 16) {
+	if (desig_len != XCOPY_NAA_IEEE_REGEX_LEN) {
 		pr_err("XCOPY 0xe4: invalid desig_len: %d\n", (int)desig_len);
 		return -EINVAL;
 	}
-- 
2.16.4

